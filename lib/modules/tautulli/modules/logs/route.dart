import 'package:fluro_fork/fluro_fork.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliLogsRoute extends StatefulWidget {
    static const String ROUTE_NAME = '/tautulli/logs/:profile';

    TautulliLogsRoute({
        Key key,
    }) : super(key: key);

    @override
    State<StatefulWidget> createState() => _State();

    static String route({ String profile }) {
        if(profile == null) return '/tautulli/logs/${LunaSeaDatabaseValue.ENABLED_PROFILE.data}';
        return '/tautulli/logs/$profile';
    }

    static void defineRoute(Router router) => router.define(
        TautulliLogsRoute.ROUTE_NAME,
        handler: Handler(handlerFunc: (context, params) => TautulliLogsRoute()),
        transitionType: LunaRouter.transitionType,
    );
}

class _State extends State<TautulliLogsRoute> {
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
