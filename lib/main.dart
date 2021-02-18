import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/system.dart';
import 'package:package_info/package_info.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

/// LunaSea Entry Point: Initialize & Run Application
/// 
/// Runs app in Sentry guarded zone to attempt to capture fatal (crashing) errors
Future<void> main() async => await SentryFlutter.init(
    (options) => options
        ..dsn = LunaLogger.SENTRY_DSN,
    appRunner: () async {
        await _init();
        runApp(LunaBIOS());
    }
);

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
/// 
/// Does not call [WidgetsFlutterBinding.ensureInitialized()] as that is called during Sentry's initialization.
/// If Sentry is removed, you should call that method to prevent black-screen flashing on launch.
Future<void> _init() async {
    //Set system UI overlay style (navbar, statusbar)
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.black,
        systemNavigationBarDividerColor: Colors.black,
        statusBarColor: Colors.transparent,
    ));
    //LunaSea initialization
    LunaLogger().initialize();
    LunaNetworking().initialize();
    LunaImageCache().initialize();
    LunaRouter().intialize();
    await LunaFirebase().initialize();
    await LunaInAppPurchases().initialize();
    await Database().initialize();
}

class LunaBIOS extends StatefulWidget {
    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<LunaBIOS> {
    StreamSubscription _notificationListener;

    @override
    void initState() {
        super.initState();
        SchedulerBinding.instance.addPostFrameCallback((_) => _boot());
    }

    @override
    void dispose() {
        Future.wait([
            if(_notificationListener != null) _notificationListener.cancel(),
            Database().deinitialize(),
            LunaInAppPurchases().deinitialize(),
        ]).then((_) => super.dispose());
    }

    /// Runs the first-step boot sequence that is required for widgets
    Future<void> _boot() async {
        // Initialize notifications: Request notification permission, add device token to Firebase (if logged in), add a notification listener for internal headsup
        await LunaFirebaseMessaging().requestNotificationPermissions();
        LunaFirebaseFirestore().addDeviceToken();
        _notificationListener = LunaFirebaseMessaging().showNotificationOnMessageListener();
        // Initialize quick actions
        LunaQuickActions().initialize();
        // Check if the changelog needs to be shown, and show if true
        PackageInfo.fromPlatform().
        then((package) {
            if(AlertsDatabaseValue.CHANGELOG.data != package.buildNumber) LunaBottomModalSheet().showChangelog(
                LunaState.navigatorKey.currentContext,
                package.buildNumber,
            );
        })
        .catchError((error, stack) => LunaLogger().error('Failed to fetch package info', error, stack));
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
                    routes: LunaRouter().routes,
                    onGenerateRoute: LunaRouter.router.generator,
                    darkTheme: LunaTheme().activeTheme(),
                    theme: LunaTheme().activeTheme(),
                    title: Constants.APPLICATION_NAME,
                    navigatorKey: LunaState.navigatorKey,
                    navigatorObservers: [ SentryNavigatorObserver() ],
                );
            },
        ),
    );
}
