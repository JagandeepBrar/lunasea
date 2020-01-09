import 'package:flutter/material.dart';
import 'package:lunasea/logic/clients/sabnzbd.dart';
import 'package:lunasea/system/constants.dart';
import 'package:lunasea/system/functions.dart';
import 'package:lunasea/system/ui.dart';

class SABnzbdServerStatusStatistics extends StatefulWidget {
    @override
    State<SABnzbdServerStatusStatistics> createState() {
        return _State();
    }
}

class _State extends State<SABnzbdServerStatusStatistics> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    final _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
    SABnzbdStatisticsEntry _entry;
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
        _entry = await SABnzbdAPI.getStatistics();
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
                    _buildUptimeVersion(),
                    _buildFreeSpaceSpeedLimit(),
                    Elements.getHeader('Statistics'),
                    _buildDailyWeekly(),
                    _buildMonthlyTotal(),
                ],
                padding: Elements.getListViewPadding(extraBottom: true),
                physics: AlwaysScrollableScrollPhysics(),
            ),
        );
    }

    Widget _buildUptimeVersion() {
        return Padding(
            child: Row(
                children: <Widget>[
                    Expanded(
                        child: Card(
                            child: Padding(
                                child: Column(
                                    children: <Widget>[
                                        Elements.getTitle('Uptime'),
                                        Elements.getSubtitle(_entry.uptime ?? 'Unknown', preventOverflow: true),
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
                                        Elements.getTitle('Version'),
                                        Elements.getSubtitle('${_entry.version}' ?? 'Unknown', preventOverflow: true),
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


    Widget _buildFreeSpaceSpeedLimit() {
        return Padding(
            child: Row(
                children: <Widget>[
                    Expanded(
                        child: Card(
                            child: Padding(
                                child: Column(
                                    children: <Widget>[
                                        Elements.getTitle('Free Space'),
                                        Elements.getSubtitle('${_entry.freespace} GB' ?? 'Unknown', preventOverflow: true),
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
                                        Elements.getSubtitle('${_entry.speed}' ?? 'Unknown', preventOverflow: true),
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

    
    Widget _buildDailyWeekly() {
        return Padding(
            child: Row(
                children: <Widget>[
                    Expanded(
                        child: Card(
                            child: Padding(
                                child: Column(
                                    children: <Widget>[
                                        Elements.getTitle('Daily'),
                                        Elements.getSubtitle('${Functions.bytesToReadable(_entry?.dailyUsage)}' ?? 'Unknown', preventOverflow: true),
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
                                        Elements.getTitle('Weekly'),
                                        Elements.getSubtitle('${Functions.bytesToReadable(_entry?.weeklyUsage)}' ?? 'Unknown', preventOverflow: true),
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

    Widget _buildMonthlyTotal() {
        return Padding(
            child: Row(
                children: <Widget>[
                    Expanded(
                        child: Card(
                            child: Padding(
                                child: Column(
                                    children: <Widget>[
                                        Elements.getTitle('Monthly'),
                                        Elements.getSubtitle('${Functions.bytesToReadable(_entry?.monthlyUsage)}' ?? 'Unknown', preventOverflow: true),
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
                                        Elements.getTitle('Total'),
                                        Elements.getSubtitle('${Functions.bytesToReadable(_entry?.totalUsage)}' ?? 'Unknown', preventOverflow: true),
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
}
