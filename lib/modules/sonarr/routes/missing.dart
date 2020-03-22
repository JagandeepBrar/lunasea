import 'package:flutter/material.dart';

class SonarrMissing extends StatefulWidget {
    static const ROUTE_NAME = '/sonarr/catalogue';
    final GlobalKey<RefreshIndicatorState> refreshIndicatorKey;
    final Function refreshAllPages;

    SonarrMissing({
        Key key,
        @required this.refreshIndicatorKey,
        @required this.refreshAllPages,
    }) : super(key: key);

    @override
    State<SonarrMissing> createState() => _State();
}

class _State extends State<SonarrMissing> with TickerProviderStateMixin {
    final _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        body: Text('missing'),
    );
}