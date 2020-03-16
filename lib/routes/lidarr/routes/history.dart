import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/widgets/pages/lidarr.dart';
import 'package:lunasea/widgets/ui.dart';

class LidarrHistory extends StatefulWidget {
    static const ROUTE_NAME = '/lidarr/history';
    final GlobalKey<RefreshIndicatorState> refreshIndicatorKey;
    final Function refreshAllPages;

    LidarrHistory({
        Key key,
        @required this.refreshIndicatorKey,
        @required this.refreshAllPages,
    }) : super(key: key);

    @override
    State<LidarrHistory> createState() => _State();
}

class _State extends State<LidarrHistory> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    Future<List<LidarrHistoryData>> _future;
    List<LidarrHistoryData> _results = [];

    @override
    void initState() {
        super.initState();
        _refresh();
    }

    Future<void> _refresh() async {
        _results = [];
        final _api = LidarrAPI.from(Database.currentProfileObject);
        if(mounted) setState(() {
            _future = _api.getHistory();
        });
    }

    void _refreshAllPages() => widget.refreshAllPages();

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        body: _body,
    );

    Widget get _body => LSRefreshIndicator(
        refreshKey: widget.refreshIndicatorKey,
        onRefresh: _refresh,
        child: FutureBuilder(
            future: _future,
            builder: (context, snapshot) {
                switch(snapshot.connectionState) {
                    case ConnectionState.done: {
                        if(snapshot.hasError || snapshot.data == null) return LSErrorMessage(onTapHandler: () => _refresh());
                        _results = snapshot.data;
                        return _list;
                    }
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                    case ConnectionState.active:
                    default: return LSLoading();
                }
            },
        ),
    );

    Widget get _list => LSListViewBuilder(
        itemCount: _results.length,
        itemBuilder: (context, index) => LidarrHistoryTile(
            entry: _results[index],
            scaffoldKey: _scaffoldKey,
            refresh: () => _refreshAllPages(),
        ),
    );
}
