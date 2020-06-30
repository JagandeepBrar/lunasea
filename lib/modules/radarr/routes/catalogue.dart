import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrCatalogue extends StatefulWidget {
    static const ROUTE_NAME = '/radarr/catalogue';
    final GlobalKey<RefreshIndicatorState> refreshIndicatorKey;
    final Function refreshAllPages;

    RadarrCatalogue({
        Key key,
        @required this.refreshIndicatorKey,
        @required this.refreshAllPages,
    }) : super(key: key);

    @override
    State<RadarrCatalogue> createState() => _State();
}

class _State extends State<RadarrCatalogue> with AutomaticKeepAliveClientMixin {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    final _scrollController = ScrollController();
    Future<List<RadarrCatalogueData>> _future;
    List<RadarrCatalogueData> _results = [];

    @override
    bool get wantKeepAlive => true;

    @override
    void initState() {
        super.initState();
        _refresh();
    }

    Future<void> _refresh() async {
        if(mounted) setState(() => _results = []);
        final _api = RadarrAPI.from(Database.currentProfileObject);
        if(mounted) setState(() => { _future = _api.getAllMovies() });
        //Clear the search filter using a microtask
        Future.microtask(() => Provider.of<RadarrModel>(context, listen: false)?.searchCatalogueFilter = '');
    }

    void _refreshState() => setState(() {});

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

    Widget get _searchSortBar => LSContainerRow(
        padding: EdgeInsets.zero,
        backgroundColor: Theme.of(context).primaryColor,
        children: <Widget>[
            RadarrCatalogueSearchBar(),
            RadarrCatalogueHideButton(controller: _scrollController),
            RadarrCatalogueSortButton(controller: _scrollController),
        ],
    );

    Widget get _list => _results.length == 0
        ? LSGenericMessage(
            text: 'No Movies Found',
            showButton: true,
            buttonText: 'Refresh',
            onTapHandler: () => _refresh(),
        )
        : Consumer<RadarrModel>(
            builder: (context, model, widget) {
                List<RadarrCatalogueData> _filtered = _sort(model, _filter(model.searchCatalogueFilter));
                _filtered = model.hideUnmonitoredMovies ? _hide(_filtered) : _filtered;
                return _listBody(_filtered);
            },
        );

    Widget _listBody(List filtered) {
        List<Widget> _children = filtered.length == 0
            ? [LSGenericMessage(text: 'No Results Found')]
            : List.generate(
                filtered.length,
                (index) => RadarrCatalogueTile(
                    data: filtered[index],
                    scaffoldKey: _scaffoldKey,
                    refresh: () => _refreshAllPages(),
                    refreshState: () => _refreshState(),
                ),
            );
        return LSListViewStickyHeader(
            controller: _scrollController,
            slivers: <Widget>[
                LSStickyHeader(
                    header: _searchSortBar,
                    children: _children,
                ),
            ],
        );
    }
    
    List<RadarrCatalogueData> _filter(String filter) => _results.where(
        (entry) => filter == null || filter == ''
            ? entry != null
            : entry.title.toLowerCase().contains(filter.toLowerCase())
    ).toList();

    List<RadarrCatalogueData> _sort(RadarrModel model, List<RadarrCatalogueData> data) {
        if(data != null && data.length != 0) return model.sortCatalogueType.sort(data, model.sortCatalogueAscending);
        return data;
    }

    List<RadarrCatalogueData> _hide(List<RadarrCatalogueData> data) => data == null || data.length == 0
        ? data
        : data.where((entry) => entry.monitored).toList();
}
