import 'package:fluro_fork/fluro_fork.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeriesEditRouter {
    static const String ROUTE_NAME = '/sonarr/series/edit/:seriesid';

    static Future<void> navigateTo(BuildContext context, {
        @required int seriesId,
    }) async => SonarrRouter.router.navigateTo(
        context,
        route(seriesId: seriesId),
    );

    static String route({ @required int seriesId }) => ROUTE_NAME
        .replaceFirst(':seriesid', seriesId?.toString() ?? '-1');

    static void defineRoutes(Router router) {
        router.define(
            ROUTE_NAME,
            handler: Handler(handlerFunc: (context, params) => _SonarrSeriesEditRoute(
                seriesId: int.tryParse(params['seriesid'][0]) ?? -1,
            )),
            transitionType: LunaRouter.transitionType,
        );
    }
}

class _SonarrSeriesEditRoute extends StatefulWidget {
    final int seriesId;

    _SonarrSeriesEditRoute({
        Key key,
        @required this.seriesId,
    }) : super(key: key);

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<_SonarrSeriesEditRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
    );

    Widget get _appBar => LunaAppBar(
        context: context,
        title: 'Edit Series',
        popUntil: '/sonarr',
    );
}
