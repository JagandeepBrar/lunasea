import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';

import 'modules/dashboard.dart';

/// LunaSea Entry Point: Initialize & Run Application
///
/// Runs app in guarded zone to attempt to capture fatal (crashing) errors
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runZonedGuarded(
    () async {
      //LunaSea initialization
      await Database().initialize();
      await LunaFirebase().initialize();
      LunaLogger().initialize();
      LunaTheme().initialize();
      await LunaDesktopWindow().initialize();
      LunaNetworking().initialize();
      LunaImageCache().initialize();
      LunaRouter().initialize();
      await LunaInAppPurchases().initialize();
      await LunaLocalization().initialize();

      // Launch application
      LunaLocalization localization = LunaLocalization();
      return runApp(
        EasyLocalization(
          supportedLocales: localization.supportedLocales as List<Locale>,
          path: localization.fileDirectory,
          fallbackLocale: localization.fallbackLocale,
          startLocale: localization.fallbackLocale,
          useFallbackTranslations: true,
          child: const LunaBIOS(),
        ),
      );
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
    return LunaState.providers(
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
              routes: LunaRouter().routes,
              onGenerateRoute: LunaRouter.router.generator,
              navigatorKey: LunaState.navigatorKey,
              darkTheme: LunaTheme().activeTheme(),
              theme: LunaTheme().activeTheme(),
              title: 'LunaSea',
            ),
          );
        },
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
    _initNotifications();

    String? tag = LunaLanguage.ENGLISH.fromLocale(context.locale)?.languageTag;
    tag ??= LunaLanguage.ENGLISH.languageTag;
    Intl.defaultLocale = tag;

    LunaQuickActions().initialize();
    LunaChangelogSheet().show(
      context: LunaState.navigatorKey.currentContext,
      checkBuildNumber: true,
    );
  }

  @override
  Widget build(BuildContext context) => DashboardHomeRouter().widget();
}
