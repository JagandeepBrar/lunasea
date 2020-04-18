import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

void main() async {
    Logger.initialize();
    await Database.initialize();
    runZonedGuarded<Future<void>>(
        () async => runApp(_BIOS()),
        (Object error, StackTrace stack) => Logger.fatal(error, stack),
    );
}

class _BIOS extends StatelessWidget {
    @override
    Widget build(BuildContext context) => Providers.providers(
        child: ValueListenableBuilder(
            valueListenable: Database.lunaSeaBox.listenable(keys: [LunaSeaDatabaseValue.THEME_AMOLED.key]),
            builder: (context, box, _) => MaterialApp(
                title: 'LunaSea',
                debugShowCheckedModeBanner: false,
                routes: Routes.getRoutes(),
                darkTheme: Themes.getDarkTheme(),
                theme: Themes.getDarkTheme(),
            ),
        ),
    );
}
