import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lunasea/core.dart';

/// LunaSea Entry Point: Initialize & Run Application
/// Runs app in guarded zone to attempt to capture fatal (crashing) errors
void main() async {
    await _init();
    runZonedGuarded<void>(
        () => runApp(_BIOS()),
        (Object error, StackTrace stack) => Logger.fatal(error, stack),
    );
}

Future<void> _init() async {
    WidgetsFlutterBinding.ensureInitialized();
    //LunaSea initialization
    await InAppPurchases.initialize();
    await Database.initialize();
    Logger.initialize();
    //Set system UI style (navbar, statusbar)
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.black,
        systemNavigationBarDividerColor: Colors.black,
        statusBarColor: Colors.transparent,
    ));
}

class _BIOS extends StatefulWidget {
    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<_BIOS> {
    @override
    Widget build(BuildContext context) => Providers.providers(
        child: ValueListenableBuilder(
            valueListenable: Database.lunaSeaBox.listenable(keys: [LunaSeaDatabaseValue.THEME_AMOLED.key]),
            builder: (context, box, _) {
                return MaterialApp(
                    title: 'LunaSea',
                    debugShowCheckedModeBanner: false,
                    routes: Routes.getRoutes(),
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
