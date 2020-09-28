import 'package:fluro_fork/fluro_fork.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrQueueRouter {
    static const String ROUTE_NAME = '/sonarr/queue/list';

    static Future<void> navigateTo(BuildContext context) async => SonarrRouter.router.navigateTo(
        context,
        route(),
    );

    static String route() => ROUTE_NAME;

    static void defineRoutes(Router router) {
        router.define(
            ROUTE_NAME,
            handler: Handler(handlerFunc: (context, params) => _SonarrQueueRoute()),
            transitionType: LunaRouter.transitionType,
        );
    }
}

class _SonarrQueueRoute extends StatefulWidget {
    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<_SonarrQueueRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
    );

    Widget get _appBar => LunaAppBar(
        context: context,
        title: 'Queue',
        popUntil: '/sonarr',
    );
}
