import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lunasea/core.dart';

void main() async {
    await _init();
    runZonedGuarded<Future<void>>(
        () async => runApp(_BIOS()),
        (Object error, StackTrace stack) => Logger.fatal(error, stack),
    );
}

Future<void> _init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await InAppPurchases.initialize();
    await Database.initialize();
    Logger.initialize();
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
