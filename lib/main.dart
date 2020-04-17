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
        child: MaterialApp(
            title: 'LunaSea',
            debugShowCheckedModeBanner: false,
            routes: Routes.getRoutes(),
            theme: Themes.getDefaultTheme(),
        ),
    );
}
