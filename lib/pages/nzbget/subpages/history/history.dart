import 'package:flutter/material.dart';

class NZBGetHistory extends StatelessWidget {
    final GlobalKey<ScaffoldState> scaffoldKey;
    final GlobalKey<RefreshIndicatorState> refreshIndicatorKey;

    NZBGetHistory({
        Key key,
        @required this.scaffoldKey,
        @required this.refreshIndicatorKey,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return _NZBGetHistoryWidget(
            scaffoldKey: scaffoldKey,
            refreshIndicatorKey: refreshIndicatorKey,
        );
    }
}

class _NZBGetHistoryWidget extends StatefulWidget {
    final GlobalKey<ScaffoldState> scaffoldKey;
    final GlobalKey<RefreshIndicatorState> refreshIndicatorKey;

    _NZBGetHistoryWidget({
        Key key,
        @required this.scaffoldKey,
        @required this.refreshIndicatorKey,
    }) : super(key: key);

    @override
    State<StatefulWidget> createState() {
        return _NZBGetHistoryState(
            scaffoldKey: scaffoldKey,
            refreshIndicatorKey: refreshIndicatorKey,
        );
    }
}

class _NZBGetHistoryState extends State<StatefulWidget> with TickerProviderStateMixin {
    final GlobalKey<ScaffoldState> scaffoldKey;
    final GlobalKey<RefreshIndicatorState> refreshIndicatorKey;

    _NZBGetHistoryState({
        Key key,
        @required this.scaffoldKey,
        @required this.refreshIndicatorKey,
    });

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            key: scaffoldKey,
        );
    }
}
