import 'package:fluro_fork/fluro_fork.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrAddSeriesRouter {
    static const String ROUTE_NAME = '/sonarr/add/series';

    static Future<void> navigateTo(BuildContext context) async => SonarrRouter.router.navigateTo(
        context,
        route(),
    );

    static String route() => ROUTE_NAME;

    static void defineRoutes(Router router) {
        router.define(
            ROUTE_NAME,
            handler: Handler(handlerFunc: (context, params) => _SonarrAddSeriesRoute()),
            transitionType: LunaRouter.transitionType,
        );
    }
}

class _SonarrAddSeriesRoute extends StatefulWidget {
    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<_SonarrAddSeriesRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
    );

    Widget get _appBar => LunaAppBar(
        context: context,
        title: 'Add Series',
        popUntil: '/sonarr',
    );
}
