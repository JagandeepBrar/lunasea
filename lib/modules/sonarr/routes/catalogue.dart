import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrCatalogue extends StatefulWidget {
    static const ROUTE_NAME = '/sonarr/catalogue';
    final GlobalKey<RefreshIndicatorState> refreshIndicatorKey;
    final Function refreshAllPages;

    SonarrCatalogue({
        Key key,
        @required this.refreshIndicatorKey,
        @required this.refreshAllPages,
    }) : super(key: key);

    @override
    State<SonarrCatalogue> createState() => _State();
}

class _State extends State<SonarrCatalogue> with AutomaticKeepAliveClientMixin {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    final _scrollController = ScrollController();
    Future<List<SonarrCatalogueData>> _future;
    List<SonarrCatalogueData> _results = [];

    @override
    bool get wantKeepAlive => true;

    @override
    void initState() {
        super.initState();
        _refresh();
    }

    Future<void> _refresh() async {
        if(mounted) setState(() => _results = []);
        final _api = SonarrAPI.from(Database.currentProfileObject);
        if(mounted) setState(() => { _future = _api.getAllSeries() });
        //Clear the search filter using a microtask
        Future.microtask(() => Provider.of<SonarrModel>(context, listen: false)?.searchCatalogueFilter = '');
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

    Widget get _searchSortBar => LSContainerRow(
        padding: EdgeInsets.zero,
        backgroundColor: Theme.of(context).primaryColor,
        children: <Widget>[
            SonarrCatalogueSearchBar(),
            SonarrCatalogueHideButton(controller: _scrollController),
            SonarrCatalogueSortButton(controller: _scrollController),
        ],
    );

    Widget get _list => _results.length == 0
        ? LSGenericMessage(
            text: 'No Series Found',
            showButton: true,
            buttonText: 'Refresh',
            onTapHandler: () => _refresh(),
        )
        : Consumer<SonarrModel>(
            builder: (context, model, widget) {
                List<SonarrCatalogueData> _filtered = _sort(model, _filter(model.searchCatalogueFilter));
                _filtered = model.hideUnmonitoredSeries ? _hide(_filtered) : _filtered;
                return _listBody(_filtered);
            }
        );

    Widget _listBody(List filtered) {
        List<Widget> _children = filtered.length == 0
            ? [LSGenericMessage(text: 'No Results Found')]
            : List.generate(
                filtered.length,
                (index) => SonarrCatalogueTile(
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

    List<SonarrCatalogueData> _filter(String filter) => _results.where(
        (entry) => filter == null || filter == ''
            ? entry != null
            : entry.title.toLowerCase().contains(filter.toLowerCase())
    ).toList();

    List<SonarrCatalogueData> _sort(SonarrModel model, List<SonarrCatalogueData> data) {
        if(data != null && data.length != 0) return model.sortCatalogueType.sort(data, model.sortCatalogueAscending);
        return data;
    }

    List<SonarrCatalogueData> _hide(List<SonarrCatalogueData> data) => data == null || data.length == 0
        ? data
        : data.where((entry) => entry.monitored).toList();
}