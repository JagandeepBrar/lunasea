import 'package:flutter/material.dart';

class RadarrCatalogue extends StatefulWidget {
    static const ROUTE_NAME = '/radarr/catalogue';
    final GlobalKey<RefreshIndicatorState> refreshIndicatorKey;
    final Function refreshAllPages;

    RadarrCatalogue({
        Key key,
        @required this.refreshIndicatorKey,
        @required this.refreshAllPages,
    }) : super(key: key);

    @override
    State<RadarrCatalogue> createState() => _State();
}

class _State extends State<RadarrCatalogue> {
    @override
    Widget build(BuildContext context) => Scaffold();
}
