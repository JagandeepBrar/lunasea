import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import '../../sonarr.dart';

class SonarrAddSearch extends StatefulWidget {
    static const ROUTE_NAME = '/sonarr/add/search';

    @override
    State<SonarrAddSearch> createState() => _State();
}

class _State extends State<SonarrAddSearch> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();

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
                        SonarrAddSearchBar(callback: _refresh),
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
                (index) => SonarrAddSearchResultTile(
                    data: _results[index],
                    alreadyAdded: _availableIDs.contains(_results[index].tvdbId),
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