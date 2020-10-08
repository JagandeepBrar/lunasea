import 'package:fluro_fork/fluro_fork.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliSearchRouter {
    static const String ROUTE_NAME = '/tautulli/search/library';

    static Future<void> navigateTo({
        @required BuildContext context,
    }) async => LunaRouter.router.navigateTo(
        context,
        route(),
    );

    static String route() => ROUTE_NAME;

    static void defineRoutes(Router router) {
        router.define(
            ROUTE_NAME,
            handler: Handler(handlerFunc: (context, params) => _TautulliSearchRoute()),
            transitionType: LunaRouter.transitionType,
        );
    }

    TautulliSearchRouter._();
}

class _TautulliSearchRoute extends StatefulWidget {
    @override
    State<_TautulliSearchRoute> createState() => _State();
}

class _State extends State<_TautulliSearchRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: TautulliSearchAppBar(context: context),
        body: TautulliSearchSearchResults(),
    );
}