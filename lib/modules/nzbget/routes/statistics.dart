import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/nzbget.dart';

class NZBGetStatistics extends StatefulWidget {
    static const ROUTE_NAME = '/nzbget/statistics';
    
    @override
    State<NZBGetStatistics> createState() => _State();
}

class _State extends State<NZBGetStatistics> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    final _refreshKey = GlobalKey<RefreshIndicatorState>();

    Future<bool> _future;
    NZBGetStatisticsData _statistics;
    List<NZBGetLogData> _logs = [];

    @override
    void initState() {
        super.initState();
        _refresh();
    }

    Future<void> _refresh() async {
        if(mounted) setState(() {
            _future = _fetch();
        });
    }

    Future<bool> _fetch() async {
        final _api = NZBGetAPI.from(Database.currentProfileObject);
        return _fetchStatistics(_api)
        .then((_) => _fetchLogs(_api))
        .then((_) => true)
        .catchError((error) => Future.error(error));
    }

    Future<void> _fetchStatistics(NZBGetAPI api) async {
        return await api.getStatistics()
        .then((stats) => { _statistics = stats })
        .catchError((error) => Future.error(error));
    }

    Future<void> _fetchLogs(NZBGetAPI api) async {
        return await api.getLogs()
        .then((logs) => { _logs = logs })
        .catchError((error) => Future.error(error));
    }

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body,
    );

    Widget get _appBar => LSAppBar(title: 'Server Statistics');

    Widget get _body => LSRefreshIndicator(
        refreshKey: _refreshKey,
        onRefresh: _refresh,
        child: FutureBuilder(
            future: _future,
            builder: (context, snapshot) {
                switch(snapshot.connectionState) {
                    case ConnectionState.done: {
                        if(snapshot.hasError || snapshot.data == null) return LSErrorMessage(onTapHandler: () => _refresh());
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

    Widget get _list => LSListView(
        children: <Widget>[
            ..._statusBlock,
            ..._statisticsBlock,
            ..._logsBlock,
        ],
    );

    List<Widget> get _statusBlock => [
        LSHeader(text: 'Status'),
        LSContainerRow(
            children: <Widget>[
                Expanded(
                    child: LSCardTile(
                        title: LSTitle(
                            text: 'Server',
                            centerText: true,
                        ),
                        subtitle: LSSubtitle(
                            text: _statistics.serverPaused ? 'Paused' : 'Active',
                            centerText: true,
                        ),
                        reducedMargin: true,
                    ),
                ),
                Expanded(
                    child: LSCardTile(
                        title: LSTitle(
                            text: 'Post',
                            centerText: true,
                        ),
                        subtitle: LSSubtitle(
                            text: _statistics.postPaused ? 'Paused' : 'Active',
                            centerText: true,
                        ),
                        reducedMargin: true,
                    ),
                ),
                Expanded(
                    child: LSCardTile(
                        title: LSTitle(
                            text: 'Scan',
                            centerText: true,
                        ),
                        subtitle: LSSubtitle(
                            text: _statistics.scanPaused ? 'Paused' : 'Active',
                            centerText: true,
                        ),
                        reducedMargin: true,
                    ),
                ),
            ],
        )
    ];

    List<Widget> get _statisticsBlock => [
        LSHeader(text: 'Statistics'),
        LSContainerRow(
            children: <Widget>[
                Expanded(
                    child: LSCardTile(
                        title: LSTitle(
                            text: 'Uptime',
                            centerText: true,
                        ),
                        subtitle: LSSubtitle(
                            text: _statistics.uptimeString,
                            centerText: true,
                        ),
                        reducedMargin: true,
                    ),
                ),
                Expanded(
                    child: LSCardTile(
                        title: LSTitle(
                            text: 'Speed Limit',
                            centerText: true,
                        ),
                        subtitle: LSSubtitle(
                            text: _statistics.speedLimitString,
                            centerText: true,
                        ),
                        reducedMargin: true,
                    ),
                ),
            ],
        ),
        LSContainerRow(
            children: <Widget>[
                Expanded(
                    child: LSCardTile(
                        title: LSTitle(
                            text: 'Free Space',
                            centerText: true,
                        ),
                        subtitle: LSSubtitle(
                            text: _statistics.freeSpaceString,
                            centerText: true,
                        ),
                        reducedMargin: true,
                    ),
                ),
                Expanded(
                    child: LSCardTile(
                        title: LSTitle(
                            text: 'Downloaded',
                            centerText: true,
                        ),
                        subtitle: LSSubtitle(
                            text: _statistics.downloadedString,
                            centerText: true,
                        ),
                        reducedMargin: true,
                    ),
                ),
            ],
        ),
    ];

    List<Widget> get _logsBlock => [
        LSHeader(text: 'Logs'),
        for(var entry in _logs) NZBGetLogTile(
            data: entry,
        ),
    ];
}
