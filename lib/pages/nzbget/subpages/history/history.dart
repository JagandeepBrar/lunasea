import 'package:flutter/material.dart';

class NZBGetHistory extends StatefulWidget {
    final GlobalKey<ScaffoldState> scaffoldKey;
    final GlobalKey<RefreshIndicatorState> refreshIndicatorKey;

    NZBGetHistory({
        Key key,
        @required this.scaffoldKey,
        @required this.refreshIndicatorKey,
    }) : super(key: key);

    @override
    State<NZBGetHistory> createState() {
        return _State();
    }
}

class _State extends State<NZBGetHistory> with TickerProviderStateMixin {
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            key: widget.scaffoldKey,
        );
    }
}
