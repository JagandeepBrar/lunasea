import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import '../../sonarr.dart';

class SonarrSearchResultsArguments {
    final int episodeID;
    final String title;

    SonarrSearchResultsArguments({
        @required this.episodeID,
        @required this.title,
    });
}

class SonarrSearchResults extends StatefulWidget {
    static const ROUTE_NAME = '/sonarr/search/results';

    @override
    State<SonarrSearchResults> createState() => _State();
}

class _State extends State<SonarrSearchResults> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();

    SonarrSearchResultsArguments _arguments;
    Future<List<SonarrReleaseData>> _future;
    List<SonarrReleaseData> _results;

    @override
    void initState() {
        super.initState();
        SchedulerBinding.instance.scheduleFrameCallback((_) {
            setState(() => _arguments = ModalRoute.of(context).settings.arguments);
            _refresh();
        });
    }

    Future<void> _refresh() async {
        _results = [];
        setState(() {
            _future = SonarrAPI.from(Database.currentProfileObject).getReleases(_arguments.episodeID);
        });
    }

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body,
    );

    Widget get _appBar => _arguments == null
        ? null
        : LSAppBar(title: _arguments.title);

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
            itemBuilder: (context, index) => SonarrSearchResultTile(data: _results[index]),
        );
}
