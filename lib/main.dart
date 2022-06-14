import 'package:device_preview/device_preview.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/database/database.dart';
import 'package:lunasea/firebase/core.dart';
import 'package:lunasea/firebase/firestore.dart';
import 'package:lunasea/firebase/messaging.dart';
import 'package:lunasea/modules/dashboard/routes/dashboard/route.dart'
    show HomeRouter;
import 'package:lunasea/system/build.dart';
import 'package:lunasea/system/cache/image/image_cache.dart';
import 'package:lunasea/system/flavor.dart';
import 'package:lunasea/system/in_app_purchase/in_app_purchase.dart';
import 'package:lunasea/system/localization.dart';
import 'package:lunasea/system/network/network.dart';
import 'package:lunasea/system/quick_actions/quick_actions.dart';
import 'package:lunasea/system/window_manager/window_manager.dart';
import 'package:lunasea/system/platform.dart';
import 'package:lunasea/utils/changelog/sheet.dart';

/// LunaSea Entry Point: Initialize & Run Application
///
/// Runs app in guarded zone to attempt to capture fatal (crashing) errors
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runZonedGuarded(
    () async {
      //LunaSea initialization
      await LunaDatabase().initialize();
      if (LunaFirebase.isSupported) await LunaFirebase().initialize();
      LunaLogger().initialize();
      LunaTheme().initialize();
      if (LunaWindowManager.isSupported) await LunaWindowManager().initialize();
      if (LunaNetwork.isSupported) LunaNetwork().initialize();
      if (LunaImageCache.isSupported) LunaImageCache().initialize();
      LunaRouter().initialize();
      if (LunaInAppPurchase.isSupported) LunaInAppPurchase().initialize();
      await LunaLocalization().initialize();
      // Run application
      return runApp(const LunaBIOS());
    },
    (error, stack) => LunaLogger().critical(error, stack),
  );
}

class LunaBIOS extends StatelessWidget {
  const LunaBIOS({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LunaTheme theme = LunaTheme();
    LunaRouter router = LunaRouter();

    return LunaState.providers(
      child: DevicePreview(
        enabled: kDebugMode && LunaPlatform.isDesktop,
        builder: (context) => EasyLocalization(
          supportedLocales: LunaLocalization().supportedLocales(),
          path: LunaLocalization.fileDirectory,
          fallbackLocale: LunaLocalization.fallbackLocale,
          startLocale: LunaLocalization.fallbackLocale,
          useFallbackTranslations: true,
          child: LunaBox.lunasea.watch(
            selectItems: [
              LunaSeaDatabase.THEME_AMOLED,
              LunaSeaDatabase.THEME_AMOLED_BORDER,
            ],
            builder: (context, _) {
              return MaterialApp(
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                builder: DevicePreview.appBuilder,
                routes: router.routes,
                useInheritedMediaQuery: true,
                onGenerateRoute: LunaRouter.router.generator,
                navigatorKey: LunaState.navigatorKey,
                darkTheme: theme.activeTheme(),
                theme: theme.activeTheme(),
                scrollBehavior: LunaScrollBehavior(),
                title: 'LunaSea',
              );
            },
          ),
        ),
      ),
    );
  }
}

class LunaOS extends StatefulWidget {
  const LunaOS({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<LunaOS> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _boot();
      _healthCheck();
    });
  }

  Future<void> _initNotifications() async {
    final messaging = LunaFirebaseMessaging();
    final firestore = LunaFirebaseFirestore();
    await messaging.requestNotificationPermissions();

    firestore.addDeviceToken();
    messaging.checkAndHandleInitialMessage();
    messaging.registerOnMessageListener();
    messaging.registerOnMessageOpenedAppListener();
  }

  Future<void> _healthCheck() async {
    if (LunaFlavor.isStable) {
      LunaBuild().isLatestBuildVersion().then((isLatest) {
        if (!isLatest.item1) ChangelogSheet().show();
      });
    }
  }

  Future<void> _boot() async {
    if (LunaFirebaseMessaging.isSupported) _initNotifications();

    String? tag = LunaLanguage.ENGLISH.fromLocale(context.locale)?.languageTag;
    tag ??= LunaLanguage.ENGLISH.languageTag;
    Intl.defaultLocale = tag;

    if (LunaQuickActions.isSupported) LunaQuickActions().initialize();
  }

  @override
  Widget build(BuildContext context) => HomeRouter().widget();
}
