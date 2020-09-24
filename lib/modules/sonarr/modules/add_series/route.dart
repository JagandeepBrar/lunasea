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

    static String route({ String profile }) => [
        ROUTE_NAME,
        if(profile != null) '/$profile',
    ].join();

    static void defineRoutes(Router router) {
        router.define(
            ROUTE_NAME + '/:profile',
            handler: Handler(handlerFunc: (context, params) => _SonarrAddSeriesRoute(
                profile: params['profile'] != null && params['profile'].length != 0 ? params['profile'][0] : null,
            )),
            transitionType: LunaRouter.transitionType,
        );
        router.define(
            ROUTE_NAME,
            handler: Handler(handlerFunc: (context, params) => _SonarrAddSeriesRoute(
                profile: null,
            )),
            transitionType: LunaRouter.transitionType,
        );
    }
}

class _SonarrAddSeriesRoute extends StatefulWidget {
    final String profile;

    _SonarrAddSeriesRoute({
        Key key,
        @required this.profile,
    }): super(key: key);

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

    Widget get _appBar => LSAppBar(title: 'Add Series');
}
