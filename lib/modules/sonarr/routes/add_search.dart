import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrAddSearch extends StatefulWidget {
    static const ROUTE_NAME = '/sonarr/add/search';

    @override
    State<SonarrAddSearch> createState() => _State();
}

class _State extends State<SonarrAddSearch> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();
    final _scrollController = ScrollController();
    Future<List<SonarrSearchData>> _future;
    List<SonarrSearchData> _results;
    List<int> _availableIDs = [];

    @override
    void initState() {
        super.initState();
        _fetchAvailableSeries();
    }

    Future<void> _refresh() async {
        final _model = Provider.of<SonarrModel>(context, listen: false);
        final _api = SonarrAPI.from(Database.currentProfileObject);
        setState(() {
            _future = _api.searchSeries(_model.addSearchQuery);
        });
    }

    Future<void> _fetchAvailableSeries() async {
        await SonarrAPI.from(Database.currentProfileObject).getAllSeriesIDs()
        .then((data) => _availableIDs = data)
        .catchError((_) => _availableIDs = []);
    }

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body,
    );

    Widget get _appBar => LSAppBar(title: 'Add Series');

    Widget get _body => LSRefreshIndicator(
        refreshKey: _refreshKey,
        onRefresh: _refresh,
        child: FutureBuilder(
            future: _future,
            builder: (context, snapshot) {
                List<Widget> _data;
                switch(snapshot.connectionState) {
                    case ConnectionState.done: {
                        if(snapshot.hasError || snapshot.data == null) {
                            _data = _error;
                        } else {
                            _results = snapshot.data;
                            _data = _assembleResults;
                        }
                        break;
                    }
                    case ConnectionState.none: _data = []; break;
                    case ConnectionState.waiting:
                    case ConnectionState.active:
                    default: _data = _loading; break;
                }
                return _list(_data);
            },
        ),
    );

    Widget _list(List<Widget> data) => LSListViewStickyHeader(
        controller: _scrollController,
        slivers: <Widget>[
            LSStickyHeader(
                header: _searchBar,
                children: data,
            ),
        ],
    );

    Widget get _searchBar => LSContainerRow(
        padding: EdgeInsets.zero,
        backgroundColor: Theme.of(context).primaryColor,
        children: [
            SonarrAddSearchBar(callback: _refresh),
        ],
    );

    List<Widget> get _loading => [LSTypewriterMessage(text: 'Searching...')];

    List<Widget> get _error => [LSErrorMessage(onTapHandler: () => _refresh(), hideButton: true)];

    List<Widget> get _assembleResults => _results.length > 0
        ? List.generate(
            _results.length,
            (index) => SonarrAddSearchResultTile(
                data: _results[index],
                alreadyAdded: _availableIDs.contains(_results[index].tvdbId),
            ),
        )
        : [LSGenericMessage(text: 'No Results Found')];
}