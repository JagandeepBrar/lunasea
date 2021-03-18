import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class _SonarrAddSeriesArguments {
    final String query;

    _SonarrAddSeriesArguments(this.query);
}

class SonarrAddSeriesRouter extends SonarrPageRouter {
    SonarrAddSeriesRouter() : super('/sonarr/addseries');

    @override
    Future<void> navigateTo(BuildContext context, { @required String query }) async => LunaRouter.router.navigateTo(
        context,
        route(),
        routeSettings: RouteSettings(arguments: _SonarrAddSeriesArguments(query)),
    );

    @override
    void defineRoute(FluroRouter router) => super.noParameterRouteDefinition(router, _SonarrAddSeriesRoute());
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
        appBar: SonarrSeriesAddAppBar(),
        body: SonarrSeriesAddSearchResults(),
    );
}
