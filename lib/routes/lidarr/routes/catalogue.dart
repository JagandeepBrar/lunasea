import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/widgets/ui.dart';
import 'package:lunasea/widgets/pages/lidarr.dart';

class LidarrCatalogue extends StatefulWidget {
    static const ROUTE_NAME = '/lidarr/catalogue';
    final GlobalKey<RefreshIndicatorState> refreshIndicatorKey;

    LidarrCatalogue({
        Key key,
        @required this.refreshIndicatorKey,
    }) : super(key: key);

    @override
    State<LidarrCatalogue> createState() => _State();
}

class _State extends State<LidarrCatalogue> with TickerProviderStateMixin {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    Future<List<LidarrCatalogueEntry>> _future;
    List<LidarrCatalogueEntry> _results = [];

    @override
    void initState() {
        super.initState();
        _refresh();
    }

    Future<void> _refresh() async {
        if(mounted) setState(() => _results = []);
        final _api = LidarrAPI.from(Database.currentProfileObject);
        if(mounted) setState(() => { _future = _api.getAllArtists() });
        //Clear the search filter using a microtask
        Future.microtask(() => Provider.of<LidarrModel>(context, listen: false)?.searchFilter = '');
    }

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

    Widget get _searchSortBar => Row(
        children: <Widget>[
            LidarrCatalogueSearchBar(),
            LidarrCatalogueHideButton(),
            LidarrCatalogueSortButton(),
        ],
    );

    Widget get _list => _results.length == 0
        ? LSGenericMessage(
            text: 'No Artists Found',
            showButton: true,
            buttonText: 'Refresh',
            onTapHandler: () => _refresh(),
        )
        : Consumer<LidarrModel>(
        builder: (context, model, widget) {
            //Filter and sort the results
            List<LidarrCatalogueEntry> _filtered = _sort(model, _filter(model.searchFilter));
            _filtered = model.hideUnmonitored ? _hide(_filtered) : _filtered;
            return LSListViewBuilder(
                itemCount: _filtered.length == 0 ? 2 : _filtered.length+1,
                itemBuilder: (context, index) {
                    if(index == 0) return _searchSortBar;
                    if(_filtered.length == 0) return LSGenericMessage(text: 'No Results Found');
                    return LidarrCatalogueTile(
                        entry: _filtered[index-1],
                        scaffoldKey: _scaffoldKey,
                        refresh: () => _refresh(),
                    );
                },
            );
        }
    );

    List<LidarrCatalogueEntry> _filter(String filter) => _results.where(
        (entry) => filter == null || filter == ''
            ? entry != null
            : entry.title.toLowerCase().contains(filter.toLowerCase())
    ).toList();

    List<LidarrCatalogueEntry> _sort(LidarrModel model, List<LidarrCatalogueEntry> data) {
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

    List<LidarrCatalogueEntry> _hide(List<LidarrCatalogueEntry> data) => data == null || data.length == 0
        ? data
        : data.where(
            (entry) => entry.monitored,
        ).toList();
}
