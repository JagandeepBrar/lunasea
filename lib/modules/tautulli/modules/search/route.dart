import 'package:fluro_fork/fluro_fork.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliSearchRouter {
    static const String ROUTE_NAME = '/tautulli/search/library';

    static Future<void> navigateTo({
        @required BuildContext context,
    }) async => TautulliRouter.router.navigateTo(
        context,
        route(),
    );

    static String route({
        String profile,
    }) => [
        ROUTE_NAME,
        if(profile != null) '/$profile',
    ].join();

    static void defineRoutes(Router router) {
        router.define(
            ROUTE_NAME,
            handler: Handler(handlerFunc: (context, params) => _TautulliSearchRoute(profile: null)),
            transitionType: LunaRouter.transitionType,
        );
        router.define(
            ROUTE_NAME + '/:profile',
            handler: Handler(handlerFunc: (context, params) => _TautulliSearchRoute(
                profile: params['profile'] != null && params['profile'].length != 0
                    ? params['profile'][0]
                    : null,
            )),
            transitionType: LunaRouter.transitionType,
        );
    }

    TautulliSearchRouter._();
}

class _TautulliSearchRoute extends StatefulWidget {
    final String profile;

    _TautulliSearchRoute({
        @required this.profile,
        Key key,
    }) : super(key: key);

    @override
    State<_TautulliSearchRoute> createState() => _State();
}

class _State extends State<_TautulliSearchRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: TautulliSearchAppBar(),
        body: TautulliSearchSearchResults(),
    );
}