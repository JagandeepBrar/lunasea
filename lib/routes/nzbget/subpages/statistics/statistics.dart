import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/widgets/ui.dart';

class NZBGetStatistics extends StatefulWidget {
    @override
    State<NZBGetStatistics> createState() {
        return _State();
    }
}

class _State extends State<NZBGetStatistics> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    final _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
    NZBGetStatisticsEntry _entry;
    List<NZBGetLogEntry> _logs;
    bool _loading = true;

    @override
    void initState() {
        super.initState();
        Future.delayed(Duration(milliseconds: 200)).then((_) {
            if(mounted) {
                _refreshIndicatorKey?.currentState?.show();
            } 
        });
    }

    Future<void> _refreshData() async {
        if(mounted) {
            setState(() {
                _loading = true;
            });
        }
        _entry = await NZBGetAPI.getStatistics();
        _logs = await NZBGetAPI.getLogs();
        if(mounted) {
            setState(() {
                _loading = false;
            });
        }
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            key: _scaffoldKey,
            appBar: Navigation.getAppBar('Server Statistics', context),
            body: _buildBody(),
        );
    }

    Widget _buildBody() {
        return RefreshIndicator(
            key: _refreshIndicatorKey,
            backgroundColor: Color(Constants.SECONDARY_COLOR),
            onRefresh: _refreshData,
            child: _loading ? 
                Notifications.centeredMessage('Loading...') :
                _entry == null ? 
                    Notifications.centeredMessage('Connection Error', showBtn: true, btnMessage: 'Refresh', onTapHandler: () {_refreshIndicatorKey?.currentState?.show();}) : 
                    _buildList(),
        );
    }

    Widget _buildList() {
        return Scrollbar(
            child: ListView(
                children: <Widget>[
                    Elements.getHeader('Status'),
                    _buildStatus(),
                    Elements.getHeader('Statistics'),
                    _buildUptimeSpeedLimit(),
                    _buildFreeSpaceDownloaded(),
                    Elements.getHeader('Logs'),
                    ..._buildLogs(),
                ],
                padding: Elements.getListViewPadding(extraBottom: true),
                physics: AlwaysScrollableScrollPhysics(),
            ),
        );
    }

    Widget _buildStatus() {
        return Padding(
            child: Row(
                children: <Widget>[
                    Expanded(
                        child: Card(
                            child: Padding(
                                child: Column(
                                    children: <Widget>[
                                        Elements.getTitle('Server'),
                                        Elements.getSubtitle(_entry.serverPaused ? 'Paused' : 'Active', preventOverflow: true),
                                    ],
                                ),
                                padding: EdgeInsets.all(16.0),
                            ),
                            margin: EdgeInsets.all(6.0),
                            elevation: 4.0,
                        ),
                    ),
                    Expanded(
                        child: Card(
                            child: Padding(
                                child: Column(
                                    children: <Widget>[
                                        Elements.getTitle('Post'),
                                        Elements.getSubtitle(_entry.postPaused ? 'Paused' : 'Active', preventOverflow: true),
                                    ],
                                ),
                                padding: EdgeInsets.all(16.0),
                            ),
                            margin: EdgeInsets.all(6.0),
                            elevation: 4.0,
                        ),
                    ),
                    Expanded(
                        child: Card(
                            child: Padding(
                                child: Column(
                                    children: <Widget>[
                                        Elements.getTitle('Scan'),
                                        Elements.getSubtitle(_entry.scanPaused ? 'Paused' : 'Active', preventOverflow: true),
                                    ],
                                ),
                                padding: EdgeInsets.all(16.0),
                            ),
                            margin: EdgeInsets.all(6.0),
                            elevation: 4.0,
                        ),
                    ),
                ],
            ),
            padding: EdgeInsets.symmetric(horizontal: 6.0),
        );
    }
    
    Widget _buildFreeSpaceDownloaded() {
        return Padding(
            child: Row(
                children: <Widget>[
                    Expanded(
                        child: Card(
                            child: Padding(
                                child: Column(
                                    children: <Widget>[
                                        Elements.getTitle('Free Space'),
                                        Elements.getSubtitle(_entry.freeSpaceString ?? 'Unknown', preventOverflow: true),
                                    ],
                                ),
                                padding: EdgeInsets.all(16.0),
                            ),
                            margin: EdgeInsets.all(6.0),
                            elevation: 4.0,
                        ),
                    ),
                    Expanded(
                        child: Card(
                            child: Padding(
                                child: Column(
                                    children: <Widget>[
                                        Elements.getTitle('Downloaded'),
                                        Elements.getSubtitle(_entry.downloadedString ?? 'Unknown', preventOverflow: true),
                                    ],
                                ),
                                padding: EdgeInsets.all(16.0),
                            ),
                            margin: EdgeInsets.all(6.0),
                            elevation: 4.0,
                        ),
                    ),
                ],
            ),
            padding: EdgeInsets.symmetric(horizontal: 6.0),
        );
    }

    Widget _buildUptimeSpeedLimit() {
        return Padding(
            child: Row(
                children: <Widget>[
                    Expanded(
                        child: Card(
                            child: Padding(
                                child: Column(
                                    children: <Widget>[
                                        Elements.getTitle('Uptime'),
                                        Elements.getSubtitle(_entry.uptimeString ?? 'Unknown', preventOverflow: true),
                                    ],
                                ),
                                padding: EdgeInsets.all(16.0),
                            ),
                            margin: EdgeInsets.all(6.0),
                            elevation: 4.0,
                        ),
                    ),
                    Expanded(
                        child: Card(
                            child: Padding(
                                child: Column(
                                    children: <Widget>[
                                        Elements.getTitle('Speed Limit'),
                                        Elements.getSubtitle(_entry.speedLimitString ?? 'Unknown', preventOverflow: true),
                                    ],
                                ),
                                padding: EdgeInsets.all(16.0),
                            ),
                            margin: EdgeInsets.all(6.0),
                            elevation: 4.0,
                        ),
                    ),
                ],
            ),
            padding: EdgeInsets.symmetric(horizontal: 6.0),
        );
    }

    List<Widget> _buildLogs() {
        if(_logs == null || _logs.length == 0) {
            return([
                Notifications.centeredMessage('No Logs Found'),
            ]);
        }
        return _logs.map((entry) => Card(
            child: ListTile(
                title: Elements.getTitle(entry.text),
                subtitle: Elements.getSubtitle(entry.timestamp, preventOverflow: false),
                trailing: IconButton(
                    icon: Elements.getIcon(Icons.arrow_forward_ios),
                    onPressed: null,
                ),
                onTap: () async {
                    await SystemDialogs.showTextPreviewPrompt(context, 'Log Entry', entry.text);
                },
            ),
            margin: Elements.getCardMargin(),
            elevation: 4.0,
        )).toList();
    }
}
