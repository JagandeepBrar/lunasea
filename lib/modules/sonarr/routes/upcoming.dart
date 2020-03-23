import 'package:flutter/material.dart';

class SonarrUpcoming extends StatefulWidget {
    static const ROUTE_NAME = '/sonarr/upcoming';
    final GlobalKey<RefreshIndicatorState> refreshIndicatorKey;
    final Function refreshAllPages;

    SonarrUpcoming({
        Key key,
        @required this.refreshIndicatorKey,
        @required this.refreshAllPages,
    }) : super(key: key);

    @override
    State<SonarrUpcoming> createState() => _State();
}

class _State extends State<SonarrUpcoming> with TickerProviderStateMixin {
    final _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        body: Text('upcoming'),
    );
}