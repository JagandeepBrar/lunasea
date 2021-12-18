import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';

/// LunaSea Entry Point: Initialize & Run Application
///
/// Runs app in guarded zone to attempt to capture fatal (crashing) errors
Future<void> main() async {
  runZonedGuarded(
    () async {
      await _init();
      LunaLocalization localization = LunaLocalization();
      return runApp(
        EasyLocalization(
          supportedLocales: localization.supportedLocales,
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

/// Initializes LunaSea before running the BIOS Widget.
Future<void> _init() async {
  WidgetsFlutterBinding.ensureInitialized();
  //LunaSea initialization
  await Database().initialize();
  await LunaFirebase().initialize();
  LunaLogger().initialize();
  LunaTheme().initialize();
  LunaDesktopWindow().initialize();
  LunaNetworking().initialize();
  LunaImageCache().initialize();
  LunaRouter().initialize();
  await LunaInAppPurchases().initialize();
  await LunaLocalization().initialize();
}

class LunaBIOS extends StatefulWidget {
  const LunaBIOS({
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<LunaBIOS> {
  StreamSubscription _firebaseOnMessageListener;
  StreamSubscription _firebaseOnMessageOpenedAppListener;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) => _boot());
  }

  @override
  void dispose() {
    Future.wait([
      if (_firebaseOnMessageListener != null)
        _firebaseOnMessageListener.cancel(),
      if (_firebaseOnMessageOpenedAppListener != null)
        _firebaseOnMessageOpenedAppListener.cancel(),
      Database().deinitialize(),
      LunaInAppPurchases().deinitialize(),
    ]).then((_) => super.dispose());
  }

  /// Runs the first-step boot sequence that is required for widgets
  Future<void> _boot() async {
    // Initialize notifications
    // - Request notification permission
    // - Add device token to Firebase (if logged in)
    // - Check and handle initial message (if found)
    // - Add notification listeners for onMessage and onMessageOpenedApp
    await LunaFirebaseMessaging().requestNotificationPermissions();
    LunaFirebaseFirestore().addDeviceToken();
    LunaFirebaseMessaging().checkAndHandleInitialMessage();
    _firebaseOnMessageListener = LunaFirebaseMessaging().onMessageListener();
    _firebaseOnMessageOpenedAppListener =
        LunaFirebaseMessaging().onMessageOpenedAppListener();
    // Remaining boot sequence
    Intl.defaultLocale =
        LunaLanguage.ENGLISH.fromLocale(context.locale)?.languageTag ?? 'en';
    LunaQuickActions().initialize();
    LunaChangelog().checkAndShowChangelog();
  }

  @override
  Widget build(BuildContext context) => LunaState.providers(
        child: ValueListenableBuilder(
          valueListenable: Database.lunaSeaBox.listenable(keys: [
            LunaDatabaseValue.THEME_AMOLED.key,
            LunaDatabaseValue.THEME_AMOLED_BORDER.key,
          ]),
          builder: (context, box, _) {
            return MaterialApp(
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              routes: LunaRouter().routes,
              onGenerateRoute: LunaRouter.router.generator,
              navigatorKey: LunaState.navigatorKey,
              darkTheme: LunaTheme().activeTheme(),
              theme: LunaTheme().activeTheme(),
              title: 'LunaSea',
            );
          },
        ),
      );
}
