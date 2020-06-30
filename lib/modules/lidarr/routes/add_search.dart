import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/lidarr.dart';

class LidarrAddSearch extends StatefulWidget {
    static const ROUTE_NAME = '/lidarr/add/search';

    @override
    State<LidarrAddSearch> createState() => _State();
}

class _State extends State<LidarrAddSearch> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();
    final _scrollController = ScrollController();
    Future<List<LidarrSearchData>> _future;
    List<LidarrSearchData> _results;
    List<String> _availableIDs = [];

    @override
    void initState() {
        super.initState();
        _fetchAvailableArtists();
    }

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        body: _body,
        appBar: _appBar,
    );

    Future<void> _refresh() async {
        final _model = Provider.of<LidarrModel>(context, listen: false);
        final _api = LidarrAPI.from(Database.currentProfileObject);
        setState(() {
            _future = _api.searchArtists(_model.addSearchQuery);
        });
    }

    Future<void> _fetchAvailableArtists() async {
        await LidarrAPI.from(Database.currentProfileObject).getAllArtistIDs()
        .then((data) => _availableIDs = data)
        .catchError((_) => _availableIDs = []);
    }

    Widget get _appBar => LSAppBar(title: 'Add Artist');

    Widget get _body => LSRefreshIndicator(
        refreshKey: _refreshKey,
        onRefresh: () => _refresh(),
        child: FutureBuilder(
            future: _future,
            builder: (context, snapshot) {
                List<Widget> _data = [];
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
            )
        ],
    );

    Widget get _searchBar => LSContainerRow(
        padding: EdgeInsets.zero,
        backgroundColor: Theme.of(context).primaryColor,
        children: [
            LidarrAddSearchBar(callback: _refresh),
        ],
    );

    List<Widget> get _loading => [LSTypewriterMessage(text: 'Searching...')];

    List<Widget> get _error => [LSErrorMessage(onTapHandler: () => _refresh(), hideButton: true)];

    List<Widget> get _assembleResults => _results.length > 0
        ? List.generate(
            _results.length,
            (index) => LidarrAddSearchResultTile(
                data: _results[index],
                alreadyAdded: _availableIDs.contains(_results[index].foreignArtistId),
            ),
        )
        : [LSGenericMessage(text: 'No Results Found')];
}
