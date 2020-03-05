import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/routes.dart';

void main() async {
    await Database.initialize();
    Logger.initialize();
    runZoned<Future<void>>(
        () async => runApp(_BIOS()),
        onError: (Object error, StackTrace stack) => Logger.fatal(error, stack),
    );
}

class _BIOS extends StatelessWidget {
    @override
    Widget build(BuildContext context) => providers(
        child: MaterialApp(
            title: 'LunaSea',
            debugShowCheckedModeBanner: false,
            routes: Routes.getRoutes(),
            theme: Themes.getDefaultTheme(),
        ),
    );
}
