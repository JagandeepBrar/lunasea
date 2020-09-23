import 'package:fluro_fork/fluro_fork.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/ombi.dart';

class OmbiHomeRouter {
    static const ROUTE_NAME = '/tautulli';

    static Future<void> navigateTo(BuildContext context) async => OmbiRouter.router.navigateTo(
        context,
        route(),
    );

    static String route({ String profile }) => [
        ROUTE_NAME,
        if(profile != null) '/$profile',
    ].join();

    static void defineRoutes(Router router) {
        /// With profile defined
        router.define(
            ROUTE_NAME + '/:profile',
            handler: Handler(handlerFunc: (context, params) => _OmbiHomeRoute(
                profile: params['profile'] != null && params['profile'].length != 0
                    ? params['profile'][0]
                    : null,
            )),
            transitionType: LunaRouter.transitionType,
        );
        /// Without profile defined
        router.define(
            ROUTE_NAME,
            handler: Handler(handlerFunc: (context, params) => _OmbiHomeRoute(
                profile: null,
            )),
            transitionType: LunaRouter.transitionType,
        );
    }

    OmbiHomeRouter._();
}

class _OmbiHomeRoute extends StatefulWidget {
    final String profile;

    _OmbiHomeRoute({
        Key key,
        @required this.profile,
    }) : super(key: key);

    @override
    State<_OmbiHomeRoute> createState() => _State();
}

class _State extends State<_OmbiHomeRoute> {
    @override
    Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [ LunaSeaDatabaseValue.ENABLED_PROFILE.key ]),
        builder: (context, box, _) => Scaffold(
            key: Provider.of<OmbiState>(context, listen: false).rootScaffoldKey,
            drawer: _drawer,
        ),
    );

    Widget get _drawer => LSDrawer(page: 'ombi');
}
