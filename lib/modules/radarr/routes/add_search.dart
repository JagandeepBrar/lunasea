import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import '../../radarr.dart';

class RadarrAddSearch extends StatefulWidget {
    static const ROUTE_NAME = '/radarr/add/search';

    @override
    State<RadarrAddSearch> createState() => _State();
}

class _State extends State<RadarrAddSearch> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();

    Future<List<RadarrSearchData>> _future;
    List<RadarrSearchData> _results;
    List<int> _availableIDs = [];

    @override
    void initState() {
        super.initState();
        _fetchAvailableMovies();
    }

    Future<void> _fetchAvailableMovies() async {
        await RadarrAPI.from(Database.currentProfileObject).getAllMovieIDs()
        .then((data) => _availableIDs = data)
        .catchError((_) => _availableIDs = []);
    }

    Future<void> _refresh() async {
        final _model = Provider.of<RadarrModel>(context, listen: false);
        final _api = RadarrAPI.from(Database.currentProfileObject);
        setState(() {
            _future = _api.searchMovies(_model.addSearchQuery);
        });
    }

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body,
    );

    Widget get _appBar => LSAppBar(title: 'Add Movie');

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
                        RadarrAddSearchBar(callback: _refresh),
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
                (index) => RadarrAddSearchResultTile(
                    data: _results[index],
                    alreadyAdded: _availableIDs.contains(_results[index].tmdbId),
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
