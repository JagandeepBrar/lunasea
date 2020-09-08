import 'package:flutter/material.dart';
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
