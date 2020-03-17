import 'package:flutter/material.dart';

class RadarrMissing extends StatefulWidget {
    static const ROUTE_NAME = '/radarr/missing';
    final GlobalKey<RefreshIndicatorState> refreshIndicatorKey;
    final Function refreshAllPages;

    RadarrMissing({
        Key key,
        @required this.refreshIndicatorKey,
        @required this.refreshAllPages,
    }) : super(key: key);
    
    @override
    State<RadarrMissing> createState() => _State();
}

class _State extends State<RadarrMissing> {
    @override
    Widget build(BuildContext context) => Scaffold();
}
