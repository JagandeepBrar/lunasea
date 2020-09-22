import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lunasea/core.dart';

/// LunaSea Entry Point: Initialize & Run Application
/// Runs app in guarded zone to attempt to capture fatal (crashing) errors
void main() async {
    await _init();
    runZonedGuarded<void>(
        () => runApp(BIOS()),
        (Object error, StackTrace stack) => Logger.fatal(error, stack),
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
    LunaNetworking.initialize();
    Logger.initialize();
    LunaImageCache.initialize();
    LunaRouter.intialize();
    await InAppPurchases.initialize();
    await Database.initialize();
}

class BIOS extends StatefulWidget {
    static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<BIOS> {
    @override
    Widget build(BuildContext context) => Providers.providers(
        child: ValueListenableBuilder(
            valueListenable: Database.lunaSeaBox.listenable(keys: [LunaSeaDatabaseValue.THEME_AMOLED.key]),
            builder: (context, box, _) {
                return MaterialApp(
                    navigatorKey: BIOS.navigatorKey,
                    title: Constants.APPLICATION_NAME,
                    debugShowCheckedModeBanner: false,
                    routes: LunaRouter.routes,
                    darkTheme: Themes.getDarkTheme(),
                    theme: Themes.getDarkTheme(),
                );
            }
        ),
    );

    @override
    void dispose() {
        Database.deinitialize()
        .whenComplete(() => InAppPurchases.deinitialize())
        .whenComplete(() => super.dispose());
    }
}
