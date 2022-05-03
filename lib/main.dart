import 'package:device_preview/device_preview.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';

import 'core/cache/image_cache/image_cache.dart';
import 'system/localization.dart';
import 'system/network/network.dart';
import 'system/quick_actions/quick_actions.dart';
import 'system/window_manager/window_manager.dart';
import 'system/platform.dart';
import 'modules/dashboard/routes/dashboard/route.dart' show HomeRouter;

/// LunaSea Entry Point: Initialize & Run Application
///
/// Runs app in guarded zone to attempt to capture fatal (crashing) errors
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runZonedGuarded(
    () async {
      //LunaSea initialization
      await Database().initialize();
      if (LunaFirebase.isSupported) await LunaFirebase().initialize();
      LunaLogger().initialize();
      LunaTheme().initialize();
      if (LunaWindowManager.isSupported) await LunaWindowManager().initialize();
      if (LunaNetwork.isSupported) LunaNetwork().initialize();
      if (LunaImageCache.isSupported) LunaImageCache().initialize();
      LunaRouter().initialize();
      await LunaInAppPurchases().initialize();
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

    return ProviderScope(
      child: DevicePreview(
        enabled: kDebugMode && LunaPlatform().isDesktop,
        builder: (context) => EasyLocalization(
          supportedLocales: LunaLocalization().supportedLocales(),
          path: LunaLocalization.fileDirectory,
          fallbackLocale: LunaLocalization.fallbackLocale,
          startLocale: LunaLocalization.fallbackLocale,
          useFallbackTranslations: true,
          child: LunaState.providers(
            child: ValueListenableBuilder(
              valueListenable: Database.lunasea.box.listenable(keys: [
                LunaDatabaseValue.THEME_AMOLED.key,
                LunaDatabaseValue.THEME_AMOLED_BORDER.key,
              ]),
              builder: (context, dynamic box, _) {
                return Layout(
                  child: MaterialApp(
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
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class LunaOS extends StatefulWidget {
  const LunaOS({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<LunaOS> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback((_) => _boot());
  }

  Future<void> _initNotifications() async {
    LunaFirebaseMessaging _messaging = LunaFirebaseMessaging();
    LunaFirebaseFirestore _firestore = LunaFirebaseFirestore();
    await _messaging.requestNotificationPermissions();

    _firestore.addDeviceToken();
    _messaging.checkAndHandleInitialMessage();
    _messaging.registerOnMessageListener();
    _messaging.registerOnMessageOpenedAppListener();
  }

  Future<void> _boot() async {
    if (LunaFirebaseMessaging.isSupported) _initNotifications();

    String? tag = LunaLanguage.ENGLISH.fromLocale(context.locale)?.languageTag;
    tag ??= LunaLanguage.ENGLISH.languageTag;
    Intl.defaultLocale = tag;

    if (LunaQuickActions.isSupported) LunaQuickActions().initialize();
    LunaChangelogSheet().show(
      context: LunaState.navigatorKey.currentContext!,
      checkBuildVersion: true,
    );
  }

  @override
  Widget build(BuildContext context) => HomeRouter().widget();
}
