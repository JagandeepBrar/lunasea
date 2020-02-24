import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/widgets/ui.dart';

class SABnzbdQueue extends StatefulWidget {
    final GlobalKey<ScaffoldState> scaffoldKey;
    final GlobalKey<RefreshIndicatorState> refreshIndicatorKey;
    final SABnzbdAPI api = SABnzbdAPI.from(Database.currentProfileObject);
    final Function refreshStatus;

    SABnzbdQueue({
        Key key,
        @required this.scaffoldKey,
        @required this.refreshIndicatorKey,
        @required this.refreshStatus,
    }) : super(key: key);

    @override
    State<SABnzbdQueue> createState() {
        return _State();
    }
}

class _State extends State<SABnzbdQueue> {
    List<SABnzbdQueueEntry> _entries = []; 
    Timer timer;
    bool _connectionError = false;
    bool _paused = false;

    @override
    void initState() {
        super.initState();
        Future.delayed(Duration(milliseconds: 200)).then((_) {
            if(mounted) {
                widget.refreshIndicatorKey?.currentState?.show();
            }
        });
    }

    void _createTimer() {
        timer = Timer(Duration(seconds: 1), () {
            _refreshData();
        });
    }

    @override
    void dispose() {
        timer?.cancel();
        super.dispose();
    }

    Future<void> _refreshData() async {
        List<dynamic> values = await widget.api.getStatusAndQueue();
        if(values != null) {
            widget.refreshStatus(values[0]);
            if(mounted) {
                setState(() {
                    _entries = values[1];
                    _connectionError = false;
                    _paused = values[0].paused;
                });
                if(timer == null || !timer.isActive) _createTimer();
            }
        } else {
            widget.refreshStatus(null);
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
            key: widget.scaffoldKey,
            body: RefreshIndicator(
                key: widget.refreshIndicatorKey,
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
                widget.refreshIndicatorKey?.currentState?.show();
            });
        }
        if(_entries.length == 0) {
            return Notifications.centeredMessage('Empty Queue', showBtn: true, btnMessage: 'Refresh', onTapHandler: () async {
                widget.refreshIndicatorKey?.currentState?.show();
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
                    if(!await widget.api.moveQueue(entry.nzoId, nIndex)) {
                        Notifications.showSnackBar(widget.scaffoldKey, 'Failed to reorder queue');
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

    Widget _buildFloatingActionButton() {
        return InkWell(
            child: FloatingActionButton(
                heroTag: null,
                child: _paused ? Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                ) : Icon(
                    Icons.pause,
                    color: Colors.white,
                ),
                onPressed: () async {
                    if(_paused) {
                        if(await widget.api.resumeQueue() && mounted) {
                            setState(() {
                                _paused = false;
                            });
                        }
                    } else {
                        if(await widget.api.pauseQueue() && mounted) {
                            setState(() {
                                _paused = true;
                            });
                        }
                    }
                },
            ),
            borderRadius: BorderRadius.circular(28.0),
            onLongPress: () async {
                List<dynamic> _values = await SABnzbdDialogs.showPauseForPrompt(context);
                if(_values[0]) {
                    if(_values[1] == -1) {
                        _values = await SABnzbdDialogs.showCustomPauseForPrompt(context);
                        if(_values[0]) {
                            if(await widget.api.pauseQueueFor(_values[1]) && mounted) {
                                setState(() {
                                    _paused = true;
                                });
                                Notifications.showSnackBar(widget.scaffoldKey, 'Pausing queue for about ${(_values[1] as int)?.lsTime_durationString(multipler: 60)}');
                            } else {
                                Notifications.showSnackBar(widget.scaffoldKey, 'Failed to pause queue');
                            }
                        }
                    } else {
                        if(await widget.api.pauseQueueFor(_values[1]) && mounted) {
                            setState(() {
                                _paused = true;
                            });
                            Notifications.showSnackBar(widget.scaffoldKey, 'Pausing queue for ${(_values[1] as int)?.lsTime_durationString(multipler: 60)}');
                        } else {
                            Notifications.showSnackBar(widget.scaffoldKey, 'Failed to pause queue');
                        }
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
                                percent: min(1.0, max(0, entry.percentageDone/100)),
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
                        if(await widget.api.resumeSingleJob(entry.nzoId) && mounted) {
                            setState(() {
                                entry.status = 'Downloading';
                            });
                            widget.refreshIndicatorKey?.currentState?.show();
                            Notifications.showSnackBar(widget.scaffoldKey, 'Job resumed');
                        } else {
                            Notifications.showSnackBar(widget.scaffoldKey, 'Failed to resume job');
                        }
                    } else {
                        if(await widget.api.pauseSingleJob(entry.nzoId) && mounted) {
                            setState(() {
                                entry.status = 'Paused';
                            });
                            widget.refreshIndicatorKey?.currentState?.show();
                            Notifications.showSnackBar(widget.scaffoldKey, 'Job paused');
                        } else {
                            Notifications.showSnackBar(widget.scaffoldKey, 'Failed to pause job');
                        }
                    }
                    break;
                }
                case 'category': {
                    final List<SABnzbdCategoryEntry> categories = await widget.api.getCategories();
                    if(categories != null) {
                        values = await SABnzbdDialogs.showCategoryPrompt(context, categories);
                        if(values[0]) {
                            if(await widget.api.setCategory(entry.nzoId, values[1])) {
                                widget.refreshIndicatorKey?.currentState?.show();
                                Notifications.showSnackBar(widget.scaffoldKey, 'Updated category');
                            } else {
                                Notifications.showSnackBar(widget.scaffoldKey, 'Failed to set category');
                            }
                        }
                    }
                    break;
                }
                case 'priority': {
                    values = await SABnzbdDialogs.showChangePriorityPrompt(context);
                    if(values[0]) {
                        if(await widget.api.setJobPriority(entry.nzoId, values[1])) {
                            widget.refreshIndicatorKey?.currentState?.show();
                            Notifications.showSnackBar(widget.scaffoldKey, 'Updated priority');
                        } else {
                            Notifications.showSnackBar(widget.scaffoldKey, 'Failed to set priority');
                        }
                    }
                    break;
                }
                case 'delete': {
                    values = await SABnzbdDialogs.showDeleteJobPrompt(context);
                    if(values[0]) {
                        if(await widget.api.deleteJob(entry.nzoId)) {
                            widget.refreshIndicatorKey?.currentState?.show();
                            Notifications.showSnackBar(widget.scaffoldKey, 'Deleted job');
                        } else {
                            Notifications.showSnackBar(widget.scaffoldKey, 'Failed to delete job');
                        }
                    }
                    break;
                }
                case 'rename': {
                    values = await SABnzbdDialogs.showRenameJobPrompt(context, entry.name);
                    if(values[0]) {
                        if(await widget.api.renameJob(entry.nzoId, values[1]) && mounted) {
                            setState(() {
                                entry.name = values[1];
                            });
                            widget.refreshIndicatorKey?.currentState?.show();
                            Notifications.showSnackBar(widget.scaffoldKey, 'Renamed job');
                        } else {
                            Notifications.showSnackBar(widget.scaffoldKey, 'Failed to rename job');
                        }
                    }
                    break;
                }
                case 'password': {
                    values = await SABnzbdDialogs.showSetPasswordPrompt(context);
                    if(values[0]) {
                        if(await widget.api.setJobPassword(entry.nzoId, entry.name, values[1])) {
                            widget.refreshIndicatorKey?.currentState?.show();
                            Notifications.showSnackBar(widget.scaffoldKey, 'Password set');
                        } else {
                            Notifications.showSnackBar(widget.scaffoldKey, 'Failed to set password');
                        }
                    }
                }
            }
            _refreshData();
        }
    }
}