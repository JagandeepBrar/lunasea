import 'package:flutter/material.dart';

class RadarrUpcoming extends StatefulWidget {
    static const ROUTE_NAME = '/radarr/upcoming';
    final GlobalKey<RefreshIndicatorState> refreshIndicatorKey;
    final Function refreshAllPages;

    RadarrUpcoming({
        Key key,
        @required this.refreshIndicatorKey,
        @required this.refreshAllPages,
    }) : super(key: key);
    
    @override
    State<RadarrUpcoming> createState() => _State();
}

class _State extends State<RadarrUpcoming> {
    @override
    Widget build(BuildContext context) => Scaffold();
}
