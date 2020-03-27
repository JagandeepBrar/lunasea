import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:tuple/tuple.dart';
import '../../sabnzbd.dart';

class SABnzbdHistory extends StatefulWidget {
    static const ROUTE_NAME = '/sabnzbd/history';
    final GlobalKey<RefreshIndicatorState> refreshIndicatorKey;

    SABnzbdHistory({
        Key key,
        @required this.refreshIndicatorKey,
    }) : super(key: key);
    
    @override
    State<SABnzbdHistory> createState() => _State();
}

class _State extends State<SABnzbdHistory> with AutomaticKeepAliveClientMixin {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    Future<List<SABnzbdHistoryData>> _future;
    List<SABnzbdHistoryData> _results = [];

    @override
    bool get wantKeepAlive => true;

    @override
    void initState() {
        super.initState();
        _refresh();
    }

    Future<void> _refresh() async {
        _results = [];
        final _api = SABnzbdAPI.from(Database.currentProfileObject);
        if(mounted) setState(() { _future = _api.getHistory(); });
        Future.microtask(() => Provider.of<SABnzbdModel>(context, listen: false)?.historySearchFilter = '');
    }

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

    Widget get _searchBar => Row(
        children: <Widget>[
            SABnzbdHistorySearchBar(),
            SABnzbdHistoryHideButton(),
        ],
    );

    Widget get _list => _results.length == 0
        ? LSGenericMessage(
            text: 'No History Found',
            showButton: true,
            buttonText: 'Refresh',
            onTapHandler: () => _refresh(),
        )
        : Selector<SABnzbdModel, Tuple2<String, bool>>(
            selector: (_, model) => Tuple2(model.historySearchFilter, model.historyHideFailed),
            builder: (context, data, _) {
                List<SABnzbdHistoryData> _filtered = _filter(data.item1);
                _filtered = data.item2 ? _hide(_filtered) : _filtered;
                return LSListViewBuilder(
                    itemCount: _filtered.length == 0 ? 2 : _filtered.length+1,
                    itemBuilder: (context, index) {
                        if(index == 0) return _searchBar;
                        if(_filtered.length == 0) return LSGenericMessage(text: 'No Results Found');
                        return SABnzbdHistoryTile(
                            data: _filtered[index-1],
                            refresh: () => _refresh(),
                        );
                    },
                    customPadding: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 92.0),
                );
            },
        );
    
    List<SABnzbdHistoryData> _filter(String filter) => _results.where(
        (entry) => filter == null || filter == ''
            ? entry != null
            : entry.name.toLowerCase().contains(filter.toLowerCase())
    ).toList();

    List<SABnzbdHistoryData> _hide(List<SABnzbdHistoryData> data) => data == null || data.length == 0
        ? data
        : data.where((entry) => entry.failed).toList();
}
