import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/widgets.dart';

class LidarrAddSearch extends StatefulWidget {
    static const ROUTE_NAME = '/lidarr/add/search';

    @override
    State<LidarrAddSearch> createState() => _State();
}

class _State extends State<LidarrAddSearch> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();

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
                List _data;
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
                return LSListView(
                    children: <Widget>[
                        LidarrAddSearchBar(callback: _refresh),
                        ..._data,
                    ],
                    padBottom: true,
                );
            },
        ),
    );

    List get _loading => [
        LSDivider(),
        LSTypewriterMessage(text: 'Searching...'),
    ];

    List get _error => [
        LSDivider(),
        LSErrorMessage(
            onTapHandler: () => _refresh(),
        ),
    ];

    List get _assembleResults => _results.length > 0
        ? [
            LSDivider(),
            ...List.generate(
                _results.length,
                (index) => LidarrAddSearchResultTile(
                    data: _results[index],
                    alreadyAdded: _availableIDs.contains(_results[index].foreignArtistId),
                ),
            ),
        ]
        : [
            LSDivider(),
            LSGenericMessage(
                text: 'No Results Found',
                showButton: true,
                buttonText: 'Try Again',
                onTapHandler: _refresh,
            ),
        ];
}
