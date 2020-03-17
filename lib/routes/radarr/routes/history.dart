import 'package:flutter/material.dart';

class RadarrHistory extends StatefulWidget {
    static const ROUTE_NAME = '/radarr/history';
    final GlobalKey<RefreshIndicatorState> refreshIndicatorKey;
    final Function refreshAllPages;

    RadarrHistory({
        Key key,
        @required this.refreshIndicatorKey,
        @required this.refreshAllPages,
    }) : super(key: key);
    
    @override
    State<RadarrHistory> createState() => _State();
}

class _State extends State<RadarrHistory> {
    @override
    Widget build(BuildContext context) => Scaffold();
}
