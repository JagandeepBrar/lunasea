import 'package:flutter/material.dart';

class SonarrHistory extends StatefulWidget {
    static const ROUTE_NAME = '/sonarr/catalogue';
    final GlobalKey<RefreshIndicatorState> refreshIndicatorKey;
    final Function refreshAllPages;

    SonarrHistory({
        Key key,
        @required this.refreshIndicatorKey,
        @required this.refreshAllPages,
    }) : super(key: key);

    @override
    State<SonarrHistory> createState() => _State();
}

class _State extends State<SonarrHistory> with TickerProviderStateMixin {
    final _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        body: Text('history'),
    );
}