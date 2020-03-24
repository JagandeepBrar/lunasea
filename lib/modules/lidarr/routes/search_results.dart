import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import '../../lidarr.dart';

class LidarrSearchResultsArguments {
    int albumID;
    String title;

    LidarrSearchResultsArguments({
        @required this.albumID,
        @required this.title,
    });
}

class LidarrSearchResults extends StatefulWidget {
    static const ROUTE_NAME = '/lidarr/search/results';

    @override
    State<LidarrSearchResults> createState() => _State();
}

class _State extends State<LidarrSearchResults> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();

    LidarrSearchResultsArguments _arguments;
    Future<List<LidarrReleaseData>> _future;
    List<LidarrReleaseData> _results;

    @override
    void initState() {
        super.initState();
        SchedulerBinding.instance.scheduleFrameCallback((_) {
            _arguments = ModalRoute.of(context).settings.arguments;
            _refresh();
        });
    }

    Future<void> _refresh() async {
        _results = [];
        setState(() {
            _future = LidarrAPI.from(Database.currentProfileObject).getReleases(_arguments.albumID);
        });
    }

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        body: _body,
        appBar: _appBar,
    );

    Widget get _appBar => LSAppBar(title: _arguments == null ? 'Search Results' : _arguments.title);
    
    Widget get _body => _arguments == null
        ? null
        : LSRefreshIndicator(
            refreshKey: _refreshKey,
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
                        default: return LSTypewriterMessage(text: 'Searching...');
                    }
                },
            ),
        );

    Widget get _list => _results.length == 0
        ? LSGenericMessage(
            text: 'No Results Found',
            showButton: true,
            buttonText: 'Refresh',
            onTapHandler: () => _refresh(),
        )
        : LSListViewBuilder(
            itemCount: _results.length,
            itemBuilder: (context, index) => LidarrSearchResultTile(data: _results[index]),
            padBottom: true,
    );
}
