import 'package:flutter/material.dart';

class NZBGetQueue extends StatelessWidget {
    final GlobalKey<ScaffoldState> scaffoldKey;
    final GlobalKey<RefreshIndicatorState> refreshIndicatorKey;

    NZBGetQueue({
        Key key,
        @required this.scaffoldKey,
        @required this.refreshIndicatorKey,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return _NZBGetQueueWidget(
            scaffoldKey: scaffoldKey,
            refreshIndicatorKey: refreshIndicatorKey,
        );
    }
}

class _NZBGetQueueWidget extends StatefulWidget {
    final GlobalKey<ScaffoldState> scaffoldKey;
    final GlobalKey<RefreshIndicatorState> refreshIndicatorKey;

    _NZBGetQueueWidget({
        Key key,
        @required this.scaffoldKey,
        @required this.refreshIndicatorKey,
    }) : super(key: key);

    @override
    State<StatefulWidget> createState() {
        return _NZBGetQueueState(
            scaffoldKey: scaffoldKey,
            refreshIndicatorKey: refreshIndicatorKey,
        );
    }
}

class _NZBGetQueueState extends State<StatefulWidget> with TickerProviderStateMixin {
    final GlobalKey<ScaffoldState> scaffoldKey;
    final GlobalKey<RefreshIndicatorState> refreshIndicatorKey;

    _NZBGetQueueState({
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
