import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lunasea/core.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

/// LunaSea Entry Point: Initialize & Run Application
/// Runs app in guarded zone to attempt to capture fatal (crashing) errors
Future<void> main() async {
    await _init();
    await SentryFlutter.init(
        (opts) {
            opts.dsn = Constants.SENTRY_DSN;
            opts.useNativeBreadcrumbTracking();
        },
        appRunner: () => runApp(LunaBIOS()),
    );
}

Future<void> _init() async {
    WidgetsFlutterBinding.ensureInitialized();
    //Set system UI style (navbar, statusbar)
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.black,
        systemNavigationBarDividerColor: Colors.black,
        statusBarColor: Colors.transparent,
    ));
    //LunaSea initialization
    LunaLogger.initialize();
    LunaNetworking.initialize();
    LunaImageCache.initialize();
    LunaRouter.intialize();
    await LunaFirebase.initialize();
    await LunaInAppPurchases.initialize();
    await Database.initialize();
}

class LunaBIOS extends StatefulWidget {
    static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<LunaBIOS> {
    @override
    Widget build(BuildContext context) => LunaState.providers(
        child: ValueListenableBuilder(
            valueListenable: Database.lunaSeaBox.listenable(keys: [LunaSeaDatabaseValue.THEME_AMOLED.key]),
            builder: (context, box, _) {
                return MaterialApp(
                    routes: LunaRouter.routes,
                    onGenerateRoute: LunaRouter.router.generator,
                    darkTheme: LunaTheme.activeTheme(),
                    theme: LunaTheme.activeTheme(),
                    title: Constants.APPLICATION_NAME,
                    navigatorKey: LunaBIOS.navigatorKey,
                    navigatorObservers: [
                        SentryNavigatorObserver(),
                    ],
                );
            }
        ),
    );

    @override
    void dispose() {
        Database.deinitialize()
        .whenComplete(() => LunaInAppPurchases.deinitialize())
        .whenComplete(() => super.dispose());
    }
}
