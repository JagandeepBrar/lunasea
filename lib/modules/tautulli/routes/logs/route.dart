import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliLogsRouter extends TautulliPageRouter {
    TautulliLogsRouter() : super('/tautulli/logs');

    @override
    void defineRoute(FluroRouter router) => super.noParameterRouteDefinition(router, _TautulliLogsRoute());
}

class _TautulliLogsRoute extends StatefulWidget {
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

    Widget get _appBar => LunaAppBar(title: 'Logs');

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
