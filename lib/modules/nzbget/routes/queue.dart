import 'package:flutter/material.dart';

class NZBGetQueue extends StatefulWidget {
    static const ROUTE_NAME = '/nzbget/queue';
    final GlobalKey<RefreshIndicatorState> refreshIndicatorKey;

    NZBGetQueue({
        Key key,
        @required this.refreshIndicatorKey,
    }) : super(key: key);
    
    @override
    State<NZBGetQueue> createState() => _State();
}

class _State extends State<NZBGetQueue> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
    );
}
