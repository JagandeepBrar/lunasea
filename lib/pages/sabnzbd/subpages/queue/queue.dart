import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lunasea/logic/clients/sabnzbd.dart';
import 'package:lunasea/logic/clients/sabnzbd/entry.dart';
import 'package:lunasea/system/constants.dart';
import 'package:lunasea/system/flutter/reorderable_list.dart';
import 'package:lunasea/system/ui.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class SABnzbdQueue extends StatelessWidget {
    final GlobalKey<ScaffoldState> scaffoldKey;
    final GlobalKey<RefreshIndicatorState> refreshIndicatorKey;
    final Function refreshStatus;

    SABnzbdQueue({
        Key key,
        @required this.scaffoldKey,
        @required this.refreshIndicatorKey,
        @required this.refreshStatus,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return _SABnzbdQueueWidget(
            scaffoldKey: scaffoldKey,
            refreshIndicatorKey: refreshIndicatorKey,
            refreshStatus: refreshStatus,
        );
    }
}

class _SABnzbdQueueWidget extends StatefulWidget {
    final GlobalKey<ScaffoldState> scaffoldKey;
    final GlobalKey<RefreshIndicatorState> refreshIndicatorKey;
    final Function refreshStatus;

    _SABnzbdQueueWidget({
        Key key,
        @required this.scaffoldKey,
        @required this.refreshIndicatorKey,
        @required this.refreshStatus,
    }) : super(key: key);

    @override
    State<StatefulWidget> createState() {
        return _SABnzbdQueueState(
            scaffoldKey: scaffoldKey,
            refreshIndicatorKey: refreshIndicatorKey,
            refreshStatus: refreshStatus,
        );
    }
}

class _SABnzbdQueueState extends State<StatefulWidget> {
    final GlobalKey<ScaffoldState> scaffoldKey;
    final GlobalKey<RefreshIndicatorState> refreshIndicatorKey;
    final Function refreshStatus;
    List<SABnzbdQueueEntry> _entries = []; 
    Timer timer;
    bool _connectionError = false;
    bool _paused = false;

    _SABnzbdQueueState({
        Key key,
        @required this.scaffoldKey,
        @required this.refreshIndicatorKey,
        @required this.refreshStatus,
    });

    @override
    void initState() {
        super.initState();
        Future.delayed(Duration(milliseconds: 200)).then((_) {
            if(mounted) {
                refreshIndicatorKey?.currentState?.show();
            }
            _createTimer();
        });
    }

    void _createTimer() {
        timer = Timer.periodic(Duration(seconds: 1), (timer) {
            _refreshData();
        });
    }

    @override
    void dispose() {
        timer?.cancel();
        super.dispose();
    }

    Future<void> _refreshData() async {
        List<dynamic> values = await SABnzbdAPI.getStatusAndQueue();
        if(values != null) {
            refreshStatus(values[0]);
            if(mounted) {
                setState(() {
                    _entries = values[1];
                    _connectionError = false;
                    _paused = values[0].paused;
                });
            }
        } else {
            refreshStatus(null);
            if(mounted) {
                setState(() {
                    _connectionError = true;
                    _paused = true;
                });
            }
        }
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            key: scaffoldKey,
            body: RefreshIndicator(
                key: refreshIndicatorKey,
                backgroundColor: Color(Constants.SECONDARY_COLOR),
                onRefresh: _refreshData,
                child: _buildList(),
            ),
            floatingActionButton: _connectionError || _entries == null ?
                Container() :
                _buildFloatingActionButton(),
        );
    }

    Widget _buildList() {
        if(_connectionError || _entries == null) {
            return Notifications.centeredMessage('Connection Error', showBtn: true, btnMessage: 'Refresh', onTapHandler: () async {
                refreshIndicatorKey?.currentState?.show();
            });
        }
        if(_entries.length == 0) {
            return Notifications.centeredMessage('Empty Queue', showBtn: true, btnMessage: 'Refresh', onTapHandler: () async {
                refreshIndicatorKey?.currentState?.show();
            });
        }
        return Scrollbar(
            child: ModdedReorderableListView(
                onReorder: (oIndex, nIndex) async {
                    if (oIndex > _entries.length) oIndex = _entries.length;
                    if (oIndex < nIndex) nIndex--;
                    SABnzbdQueueEntry entry = _entries[oIndex];
                    if(mounted) {
                        setState(() {  
                            _entries.remove(entry);
                            _entries.insert(nIndex, entry);
                        });
                    }
                    if(!await SABnzbdAPI.moveQueue(entry.nzoId, nIndex)) {
                        Notifications.showSnackBar(scaffoldKey, 'Failed to reorder queue');
                        if(mounted) {
                            setState(() {  
                                _entries.remove(entry);
                                _entries.insert(oIndex, entry);
                            });
                        }
                    }
                },
                children: List.generate(
                    _entries.length,
                    (index) => _buildEntry(_entries[index])
                ),
                padding: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 0.0),
            ),
        );
    }

    FloatingActionButton _buildFloatingActionButton() {
        return FloatingActionButton(
            heroTag: null,
            tooltip: 'Start/Pause SABnzbd',
            child: _paused ? Icon(
                Icons.play_arrow,
                color: Colors.white,
            ) : Icon(
                Icons.pause,
                color: Colors.white,
            ),
            onPressed: () async {
                if(_paused) {
                    if(await SABnzbdAPI.resumeQueue()) {
                        setState(() {
                            _paused = false;
                        });
                    }
                } else {
                    if(await SABnzbdAPI.pauseQueue()) {
                        setState(() {
                            _paused = true;
                        });
                    }
                }
            },
        );
    }

    Widget _buildEntry(SABnzbdQueueEntry entry) {
        return Card(
            key: Key(entry.nzoId),
            child: ListTile(
                title: Elements.getTitle(entry.name, darken: entry.isPaused),
                subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                        Padding(
                            child: LinearPercentIndicator(
                                percent: entry.percentageDone/100,
                                padding: EdgeInsets.symmetric(horizontal: 2.0),
                                progressColor: entry.isPaused ? Color(Constants.ACCENT_COLOR).withOpacity(0.30) : Color(Constants.ACCENT_COLOR),
                                backgroundColor: entry.isPaused ? Color(Constants.ACCENT_COLOR).withOpacity(0.05) : Color(Constants.ACCENT_COLOR).withOpacity(0.15),
                                lineHeight: 4.0,
                            ),
                            padding: EdgeInsets.symmetric(vertical: 6.0),
                        ),
                        Elements.getSubtitle(entry.subtitle, darken: entry.isPaused),
                    ],
                ),
                trailing: IconButton(
                    icon: Elements.getIcon(Icons.more_vert),
                    onPressed: () async {
                        _handlePopup(context, entry);
                    },
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 12.0),
            ),
            margin: Elements.getCardMargin(),
            elevation: 4.0,
        );
    }

    Future<void> _handlePopup(BuildContext context, SABnzbdQueueEntry entry) async {
        List<dynamic> values = await SABnzbdDialogs.showQueueSettingsPrompt(context, entry.name, entry.isPaused);
        if(values[0]) {
            switch(values[1]) {
                case 'status': {
                    if(entry.isPaused) {
                        if(await SABnzbdAPI.resumeSingleJob(entry.nzoId)) {
                            setState(() {
                                entry.status = 'Downloading';
                            });
                            refreshIndicatorKey?.currentState?.show();
                            Notifications.showSnackBar(scaffoldKey, 'Job resumed');
                        } else {
                            Notifications.showSnackBar(scaffoldKey, 'Failed to resume job');
                        }
                    } else {
                        if(await SABnzbdAPI.pauseSingleJob(entry.nzoId)) {
                            setState(() {
                                entry.status = 'Paused';
                            });
                            refreshIndicatorKey?.currentState?.show();
                            Notifications.showSnackBar(scaffoldKey, 'Job paused');
                        } else {
                            Notifications.showSnackBar(scaffoldKey, 'Failed to pause job');
                        }
                    }
                    break;
                }
                case 'category': {
                    final List<SABnzbdCategoryEntry> categories = await SABnzbdAPI.getCategories();
                    values = await SABnzbdDialogs.showCategoryPrompt(context, categories);
                    if(values[0]) {
                        if(await SABnzbdAPI.setCategory(entry.nzoId, values[1])) {
                            refreshIndicatorKey?.currentState?.show();
                            Notifications.showSnackBar(scaffoldKey, 'Updated category');
                        } else {
                            Notifications.showSnackBar(scaffoldKey, 'Failed to set category');
                        }
                    }
                    break;
                }
                case 'priority': {
                    values = await SABnzbdDialogs.showChangePriorityPrompt(context);
                    if(values[0]) {
                        if(await SABnzbdAPI.setJobPriority(entry.nzoId, values[1])) {
                            refreshIndicatorKey?.currentState?.show();
                            Notifications.showSnackBar(scaffoldKey, 'Updated priority');
                        } else {
                            Notifications.showSnackBar(scaffoldKey, 'Failed to set priority');
                        }
                    }
                    break;
                }
                case 'delete': {
                    values = await SABnzbdDialogs.showDeleteJobPrompt(context);
                    if(values[0]) {
                        if(await SABnzbdAPI.deleteJob(entry.nzoId)) {
                            refreshIndicatorKey?.currentState?.show();
                            Notifications.showSnackBar(scaffoldKey, 'Deleted job');
                        } else {
                            Notifications.showSnackBar(scaffoldKey, 'Failed to delete job');
                        }
                    }
                    break;
                }
                case 'rename': {
                    values = await SABnzbdDialogs.showRenameJobPrompt(context, entry.name);
                    if(values[0]) {
                        if(await SABnzbdAPI.renameJob(entry.nzoId, values[1])) {
                            setState(() {
                                entry.name = values[1];
                            });
                            refreshIndicatorKey?.currentState?.show();
                            Notifications.showSnackBar(scaffoldKey, 'Renamed job');
                        } else {
                            Notifications.showSnackBar(scaffoldKey, 'Failed to rename job');
                        }
                    }
                    break;
                }
                case 'password': {
                    values = await SABnzbdDialogs.showSetPasswordPrompt(context);
                    if(values[0]) {
                        if(await SABnzbdAPI.setJobPassword(entry.nzoId, entry.name, values[1])) {
                            refreshIndicatorKey?.currentState?.show();
                            Notifications.showSnackBar(scaffoldKey, 'Password set');
                        } else {
                            Notifications.showSnackBar(scaffoldKey, 'Failed to set password');
                        }
                    }
                }
            }
            _refreshData();
        }
    }
}