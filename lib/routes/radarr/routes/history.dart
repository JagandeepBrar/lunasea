import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/widgets/pages/radarr.dart';
import 'package:lunasea/widgets/ui.dart';

class RadarrHistory extends StatefulWidget {
    static const ROUTE_NAME = '/radarr/history';
    final GlobalKey<RefreshIndicatorState> refreshIndicatorKey;
    final Function refreshAllPages;

    RadarrHistory({
        Key key,
        @required this.refreshIndicatorKey,
        @required this.refreshAllPages,
    }) : super(key: key);
    
    @override
    State<RadarrHistory> createState() => _State();
}

class _State extends State<RadarrHistory> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    Future<List<RadarrHistoryData>> _future;
    List<RadarrHistoryData> _results = [];

    @override
    void initState() {
        super.initState();
        _refresh();
    }

    void _refreshAllPages() => widget.refreshAllPages();

    Future<void> _refresh() async {
        final _api = RadarrAPI.from(Database.currentProfileObject);
        if(mounted) setState(() {
            _future = _api.getHistory();
        });
    }

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        body: _body,
    );

    Widget get _body => LSRefreshIndicator(
        refreshKey: widget.refreshIndicatorKey,
        onRefresh: () => _refresh(),
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

    Widget get _list => _results.length == 0
        ? LSGenericMessage(
            text: 'No History Found',
            showButton: true,
            buttonText: 'Refresh',
            onTapHandler: () => _refresh(),
        )
        : LSListViewBuilder(
            itemCount: _results.length,
            itemBuilder: (context, index) => RadarrHistoryTile(
                data: _results[index],
                scaffoldKey: _scaffoldKey,
                refresh: () => _refreshAllPages(),
            ),
        );
}
