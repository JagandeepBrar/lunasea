import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LSRefreshIndicator extends StatefulWidget {
    final Widget child;
    final Function onRefresh;
    final GlobalKey<RefreshIndicatorState> refreshKey;
    
    LSRefreshIndicator({
        @required this.child,
        @required this.onRefresh,
        @required this.refreshKey,
    });

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<LSRefreshIndicator> {
    @override
    Widget build(BuildContext context) {
        return RefreshIndicator(
            key: widget.refreshKey,
            backgroundColor: LSColors.secondary,
            onRefresh: widget.onRefresh,
            child: widget.child,
        );
    }
}