import 'package:fluro_fork/fluro_fork.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliLogsRouter {
    static const String ROUTE_NAME = '/tautulli/logs/list';

    static Future<void> navigateTo(BuildContext context) async => TautulliRouter.router.navigateTo(
        context,
        route(),
    );

    static String route({ String profile }) => [
        ROUTE_NAME,
        if(profile != null) '/$profile',
    ].join();

    static void defineRoutes(Router router) {
        router.define(
            ROUTE_NAME,
            handler: Handler(handlerFunc: (context, params) => _TautulliLogsRoute(
                profile: null,
            )),
            transitionType: LunaRouter.transitionType,
        );
        router.define(
            ROUTE_NAME + '/:profile',
            handler: Handler(handlerFunc: (context, params) => _TautulliLogsRoute(
                profile: params['profile'] != null && params['profile'].length != 0 ? params['profile'][0] : null,
            )),
            transitionType: LunaRouter.transitionType,
        );
    }

    TautulliLogsRouter._();
}

class _TautulliLogsRoute extends StatefulWidget {
    final String profile;

    _TautulliLogsRoute({
        Key key,
        @required this.profile,
    }) : super(key: key);

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<_TautulliLogsRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    
    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body,
    );

    Widget get _appBar => LSAppBar(title: 'Tautulli Logs');

    Widget get _body => LSListView(
        children: [
            TautulliLogsLoginsTile(),
            TautulliLogsNewslettersTile(),
            TautulliLogsNotificationsTile(),
            TautulliLogsPlexMediaScannerTile(),
            TautulliLogsPlexMediaServerTile(),
            TautulliLogsTautulliTile(),
        ],
    );
}
