import 'package:flutter/material.dart';
import 'package:lunasea/widgets.dart';

class LSRefreshIndicator extends StatefulWidget {
    final Widget child;
    final Function onRefresh;
    
    LSRefreshIndicator({
        @required this.child,
        @required this.onRefresh,
    });

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<LSRefreshIndicator> {
    final _refreshKey = GlobalKey<RefreshIndicatorState>();

    @override
    Widget build(BuildContext context) {
        return RefreshIndicator(
            key: _refreshKey,
            backgroundColor: LSColors.secondary,
            onRefresh: widget.onRefresh,
            child: widget.child,
        );
    }
    
    void refresh() => _refreshKey?.currentState?.show();
}