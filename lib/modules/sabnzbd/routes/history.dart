import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:tuple/tuple.dart';
import 'package:lunasea/modules/sabnzbd.dart';

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
    final _scrollController = ScrollController();
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

    Widget get _searchBar => LSContainerRow(
        padding: EdgeInsets.zero,
        backgroundColor: Theme.of(context).primaryColor,
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
                return _listBody(_filtered);
            },
        );

    Widget _listBody(List filtered) {
        List<Widget> _children = filtered.length == 0
            ? [LSGenericMessage(text: 'No Results Found')]
            : List.generate(
                filtered.length,
                (index) => SABnzbdHistoryTile(
                    data: filtered[index],
                    refresh: () => _refresh(),
                ),
            );
        return LSListViewStickyHeader(
            controller: _scrollController,
            slivers: <Widget>[
                LSStickyHeader(
                    header: _searchBar,
                    children: _children,
                ),
            ],
        );
    }
    
    List<SABnzbdHistoryData> _filter(String filter) => _results.where(
        (entry) => filter == null || filter == ''
            ? entry != null
            : entry.name.toLowerCase().contains(filter.toLowerCase())
    ).toList();

    List<SABnzbdHistoryData> _hide(List<SABnzbdHistoryData> data) => data == null || data.length == 0
        ? data
        : data.where((entry) => entry.failed).toList();
}
