import 'package:fluro_fork/fluro_fork.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeriesDetailsRouter {
    static const String ROUTE_NAME = '/sonarr/series/details/:seriesid';

    static Future<void> navigateTo(BuildContext context, {
        @required int seriesId,
    }) async => SonarrRouter.router.navigateTo(
        context,
        route(seriesId: seriesId),
    );

    static String route({
        String profile,
        @required int seriesId,
    }) => [
        ROUTE_NAME.replaceFirst(':seriesid', seriesId?.toString() ?? '-1'),
        if(profile != null) '/$profile',
    ].join();

    static void defineRoutes(Router router) {
        router.define(
            ROUTE_NAME + '/:profile',
            handler: Handler(handlerFunc: (context, params) => _SonarrSeriesDetailsRoute(
                profile: params['profile'] != null && params['profile'].length != 0 ? params['profile'][0] : null,
                seriesId: int.tryParse(params['seriesid'][0]) ?? -1,
            )),
            transitionType: LunaRouter.transitionType,
        );
        router.define(
            ROUTE_NAME,
            handler: Handler(handlerFunc: (context, params) => _SonarrSeriesDetailsRoute(
                profile: null,
                seriesId: int.tryParse(params['seriesid'][0]) ?? -1,
            )),
            transitionType: LunaRouter.transitionType,
        );
    }
}

class _SonarrSeriesDetailsRoute extends StatefulWidget {
    final String profile;
    final int seriesId;

    _SonarrSeriesDetailsRoute({
        Key key,
        @required this.profile,
        @required this.seriesId,
    }): super(key: key);

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<_SonarrSeriesDetailsRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    void initState() {
        super.initState();
        //_pageController = PageController(initialPage: SonarrDatabaseValue.NAVIGATION_INDEX_SERIES_DETAILS.data);
        SchedulerBinding.instance.scheduleFrameCallback((_) => _refresh());
    }

    Future<void> _refresh() async => {};

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
    );
}
