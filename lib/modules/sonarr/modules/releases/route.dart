import 'package:fluro_fork/fluro_fork.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrReleasesRouter {
    static const String ROUTE_NAME = '/sonarr/releases/list';

    static Future<void> navigateTo(BuildContext context) async => SonarrRouter.router.navigateTo(
        context,
        route(),
    );

    static String route() => ROUTE_NAME;

    static void defineRoutes(Router router) {
        router.define(
            ROUTE_NAME,
            handler: Handler(handlerFunc: (context, params) => _SonarrReleasesRoute()),
            transitionType: LunaRouter.transitionType,
        );
    }
}

class _SonarrReleasesRoute extends StatefulWidget {
    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<_SonarrReleasesRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
    );

    Widget get _appBar => LunaAppBar(
        context: context,
        title: 'Releases',
        popUntil: '/sonarr',
    );
}
