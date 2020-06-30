import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrUpcoming extends StatefulWidget {
    static const ROUTE_NAME = '/radarr/upcoming';
    final GlobalKey<RefreshIndicatorState> refreshIndicatorKey;
    final Function refreshAllPages;

    RadarrUpcoming({
        Key key,
        @required this.refreshIndicatorKey,
        @required this.refreshAllPages,
    }) : super(key: key);
    
    @override
    State<RadarrUpcoming> createState() => _State();
}

class _State extends State<RadarrUpcoming> with AutomaticKeepAliveClientMixin {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    Future<List<RadarrMissingData>> _future;
    List<RadarrMissingData> _results = [];

    @override
    bool get wantKeepAlive => true;

    @override
    void initState() {
        super.initState();
        _refresh();
    }

    Future<void> _refresh() async {
        _results = [];
        final _api = RadarrAPI.from(Database.currentProfileObject);
        if(mounted) setState(() {
            _future = _api.getUpcoming();
        });
    }

    void _refreshAllPages() => widget.refreshAllPages();

    @override
    Widget build(BuildContext context) {
        super.build(context);
        return Scaffold(
            key: _scaffoldKey,
            body: _body,
        );
    }

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

    Widget get _list => _results.length == 0
        ? LSGenericMessage(
            text: 'No Upcoming Movies',
            showButton: true,
            buttonText: 'Refresh',
            onTapHandler: () => widget.refreshIndicatorKey?.currentState?.show(),
        )
        : LSListViewBuilder(
            itemCount: _results.length,
            itemBuilder: (context, index) => RadarrUpcomingTile(
                scaffoldKey: _scaffoldKey,
                data: _results[index],
                refresh: () => _refreshAllPages(),
            ),
        );
}
