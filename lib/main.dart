import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';

/// LunaSea Entry Point: Initialize & Run Application
/// 
/// Runs app in guarded zone to attempt to capture fatal (crashing) errors
Future<void> main() async {
    unawaited(runZonedGuarded(
        () async {
            await _init();
            return runApp(
                EasyLocalization(
                    supportedLocales: LunaLocalization().supportedLocales,
                    path: LunaLocalization().fileDirectory,
                    fallbackLocale: LunaLocalization().fallbackLocale,
                    useFallbackTranslations: true,
                    child: LunaBIOS(),
                ),
            );
        },
        (error, stack) => LunaLogger().critical(error, stack),
    ));
}

/// Initializes LunaSea before running the BIOS Widget.
/// 
/// Sets up (in order):
/// - System UI Overlay Styling
/// - Logger
/// - Network
/// - Image Cache
/// - Router
/// - Firebase
/// - IAPs
/// - Database
Future<void> _init() async {
    WidgetsFlutterBinding.ensureInitialized();
    //LunaSea initialization
    await Database().initialize();
    await LunaFirebase().initialize();
    LunaLogger().initialize();
    LunaTheme().intialize();
    LunaDesktopWindow().initialize();
    LunaNetworking().initialize();
    LunaImageCache().initialize();
    LunaRouter().intialize();
    await LunaInAppPurchases().initialize();
    await LunaLocalization().initialize();
}

class LunaBIOS extends StatefulWidget {
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
            if(_firebaseOnMessageListener != null) _firebaseOnMessageListener.cancel(),
            if(_firebaseOnMessageOpenedAppListener != null) _firebaseOnMessageOpenedAppListener.cancel(),
            Database().deinitialize(),
            LunaInAppPurchases().deinitialize(),
        ]).then((_) => super.dispose());
    }

    /// Runs the first-step boot sequence that is required for widgets
    Future<void> _boot() async {
        LunaFirebaseAnalytics().appOpened();
        // Initialize notifications
        // - Request notification permission
        // - Add device token to Firebase (if logged in)
        // - Check and handle initial message (if found)
        // - Add notification listeners for onMessage and onMessageOpenedApp
        await LunaFirebaseMessaging().requestNotificationPermissions()
        .then((value) {
            if(value) {
                unawaited(LunaFirebaseFirestore().addDeviceToken());
                unawaited(LunaFirebaseMessaging().checkAndHandleInitialMessage());
                _firebaseOnMessageListener = LunaFirebaseMessaging().onMessageListener();
                _firebaseOnMessageOpenedAppListener = LunaFirebaseMessaging().onMessageOpenedAppListener();
            }
        });
        // Remaining boot sequence
        LunaQuickActions().initialize();
        unawaited(LunaChangelog().checkAndShowChangelog());
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
                    navigatorObservers: [
                        if(LunaFirebaseAnalytics.isPlatformCompatible) LunaFirebaseAnalytics.observer,
                    ],
                    darkTheme: LunaTheme().activeTheme(),
                    theme: LunaTheme().activeTheme(),
                    title: 'LunaSea',
                );
            },
        ),
    );
}
