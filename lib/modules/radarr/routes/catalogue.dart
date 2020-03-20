import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/widgets/ui.dart';
import '../../radarr.dart';

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

class _State extends State<RadarrCatalogue> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    Future<List<RadarrCatalogueData>> _future;
    List<RadarrCatalogueData> _results = [];

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
        Future.microtask(() => Provider.of<RadarrModel>(context, listen: false)?.searchFilter = '');
    }

    void _refreshState() => setState(() {});

    void _refreshAllPages() => widget.refreshAllPages();

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

    Widget get _searchSortBar => Row(
        children: <Widget>[
            RadarrCatalogueSearchBar(),
            RadarrCatalogueHideButton(),
            RadarrCatalogueSortButton(),
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
                //Filter and sort the results
                List<RadarrCatalogueData> _filtered = _sort(model, _filter(model.searchFilter));
                _filtered = model.hideUnmonitoredMovies ? _hide(_filtered) : _filtered;
                return LSListViewBuilder(
                    itemCount: _filtered.length == 0 ? 2 : _filtered.length+1,
                    itemBuilder: (context, index) {
                        if(index == 0) return _searchSortBar;
                        if(_filtered.length == 0) return LSGenericMessage(text: 'No Results Found');
                        return RadarrCatalogueTile(
                            data: _filtered[index-1],
                            scaffoldKey: _scaffoldKey,
                            refresh: () => _refreshAllPages(),
                            refreshState: () => _refreshState(),
                        );
                    },
                );
            },
        );
    
    List<RadarrCatalogueData> _filter(String filter) => _results.where(
        (entry) => filter == null || filter == ''
            ? entry != null
            : entry.title.toLowerCase().contains(filter.toLowerCase())
    ).toList();

    List<RadarrCatalogueData> _sort(RadarrModel model, List<RadarrCatalogueData> data) {
        if(data != null && data.length != 0) switch(model.sortType) {
            case 'size': model.sortAscending
                ? data.sort((a,b) => b.sizeOnDisk.compareTo(a.sizeOnDisk))
                : data.sort((a,b) => a.sizeOnDisk.compareTo(b.sizeOnDisk));
                break;
            case 'abc':
            default: model.sortAscending
                ? data.sort((a,b) => a.sortTitle.compareTo(b.sortTitle))
                : data.sort((a,b) => b.sortTitle.compareTo(a.sortTitle));
                break;
        }
        return data;
    }

    List<RadarrCatalogueData> _hide(List<RadarrCatalogueData> data) => data == null || data.length == 0
        ? data
        : data.where((entry) => entry.monitored).toList();
}
