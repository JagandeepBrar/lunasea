import 'package:flutter/material.dart';

class NZBGetQueue extends StatefulWidget {
    final GlobalKey<ScaffoldState> scaffoldKey;
    final GlobalKey<RefreshIndicatorState> refreshIndicatorKey;
    final Function refreshStatus;

    NZBGetQueue({
        Key key,
        @required this.scaffoldKey,
        @required this.refreshIndicatorKey,
        @required this.refreshStatus,
    }) : super(key: key);

    @override
    State<NZBGetQueue> createState() {
        return _State();
    }
}

class _State extends State<NZBGetQueue> with TickerProviderStateMixin {
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            key: widget.scaffoldKey,
        );
    }
}
