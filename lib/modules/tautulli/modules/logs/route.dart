import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliLogsRoute extends StatefulWidget {
    static const ROUTE_NAME = '/tautulli/logs';

    TautulliLogsRoute({
        Key key,
    }) : super(key: key);

    @override
    State<StatefulWidget> createState() => _State();
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
            TautulliLogsTautulliTile(),
            TautulliLogsPlexMediaServerTile(),
            TautulliLogsPlexMediaScannerTile(),
            TautulliLogsNewslettersTile(),
            TautulliLogsNotificationsTile(),
            TautulliLogsLoginsTile(),
        ],
    );
}
