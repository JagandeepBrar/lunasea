import 'package:fluro_fork/fluro_fork.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrReleasesRouter {
    static const String ROUTE_NAME = '/sonarr/releases/:episodeid';

    static Future<void> navigateTo(BuildContext context, {
        @required int episodeId,
    }) async => SonarrRouter.router.navigateTo(
        context,
        route(episodeId: episodeId),
    );

    static String route({
        @required int episodeId,
    }) => ROUTE_NAME.replaceFirst(':episodeid', episodeId?.toString() ?? -1);

    static void defineRoutes(Router router) {
        router.define(
            ROUTE_NAME,
            handler: Handler(handlerFunc: (context, params) => _SonarrReleasesRoute(
                episodeId: int.tryParse(params['episodeid'][0]) ?? -1,
            )),
            transitionType: LunaRouter.transitionType,
        );
    }
}

class _SonarrReleasesRoute extends StatefulWidget {
    final int episodeId;

    _SonarrReleasesRoute({
        Key key,
        @required this.episodeId,
    }) : super(key: key);

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
