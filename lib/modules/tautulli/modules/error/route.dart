import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliErrorRoute extends StatefulWidget {
    static const String ROUTE_NAME = '/tautulli/error';

    @override
    State<TautulliErrorRoute> createState() => _State();

    static String route() => ROUTE_NAME;
}

class _State extends State<TautulliErrorRoute> {
    @override
    Widget build(BuildContext context) => Scaffold(
        appBar: LSAppBar(title: 'Tautulli'),
        body: LSUnknownRoute(
            router: TautulliRouter.router,
            route: TautulliRoute.route(),
            module: 'Tautulli',
        ),
    );
}
