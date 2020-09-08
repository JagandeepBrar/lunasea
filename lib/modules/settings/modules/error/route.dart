import 'package:fluro_fork/fluro_fork.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsErrorRoute extends StatefulWidget {
    static const String ROUTE_NAME = '/settings/error';
    static String route() => ROUTE_NAME;

    static Handler defineRoute(Router router) => router.notFoundHandler = Handler(handlerFunc: (context, params) => SettingsErrorRoute());

    @override
    State<SettingsErrorRoute> createState() => _State();
}

class _State extends State<SettingsErrorRoute> {
    @override
    Widget build(BuildContext context) => Scaffold(
        appBar: LSAppBar(title: 'Settings'),
        body: LSUnknownRoute(
            router: SettingsRouter.router,
            route: SettingsRoute.route(),
            module: 'Settings',
        ),
    );
}
