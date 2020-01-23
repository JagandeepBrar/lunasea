import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lunasea/logic/clients/nzbget.dart';
import 'package:lunasea/system/constants.dart';
import 'package:lunasea/system/flutter/reorderable_list.dart';
import 'package:lunasea/system/ui.dart';
import 'package:lunasea/system/ui/dialog.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class NZBGetQueue extends StatefulWidget {
    final GlobalKey<ScaffoldState> scaffoldKey;
    final GlobalKey<RefreshIndicatorState> refreshIndicatorKey;
    final Function refreshStatus;

    NZBGetQueue({
        Key key,
        @required this.scaffoldKey,
        @required this.refreshIndicatorKey,
        @required this.refreshStatus,
    }) : super(key: key);

    @override
    State<NZBGetQueue> createState() {
        return _State();
    }
}

class _State extends State<NZBGetQueue> with TickerProviderStateMixin {
    List<NZBGetQueueEntry> _entries = [];
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
            _createTimer();
        });
    }

    @override
    void dispose() {
        timer?.cancel();
        super.dispose();
    }

    void _createTimer() {
        timer = Timer.periodic(Duration(seconds: 1), (timer) {
            _refreshData();
        });
    }

    Future<void> _refreshData() async {
        List<dynamic> values = await NZBGetAPI.getStatusAndQueue();
        if(values != null) {
            widget.refreshStatus(values[0]);
            if(mounted) {
                setState(() {
                    _entries = values[1];
                    _connectionError = false;
                    _paused = values[0].paused;
                });
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
            floatingActionButton: _connectionError ?
                null :
                _buildFloatingActionButton(),
        );
    }

    FloatingActionButton _buildFloatingActionButton() {
        return FloatingActionButton(
            heroTag: null,
            tooltip: 'Start/Pause NZBGet',
            child: _paused ? Icon(
                Icons.play_arrow,
                color: Colors.white,
            ) : Icon(
                Icons.pause,
                color: Colors.white,
            ),
            onPressed: () async {
                if(_paused) {
                    if(await NZBGetAPI.resumeQueue() && mounted) {
                        setState(() {
                            _paused = false;
                        });
                    }
                } else {
                    if(await NZBGetAPI.pauseQueue() && mounted) {
                        setState(() {
                            _paused = true;
                        });
                    }
                }
            },
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
                    NZBGetQueueEntry entry = _entries[oIndex];
                    if(mounted) {
                        setState(() {
                            _entries.remove(entry);
                            _entries.insert(nIndex, entry);
                        });
                    }
                    if(!await NZBGetAPI.moveQueue(entry.id, (nIndex - oIndex))) {
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

    Widget _buildEntry(NZBGetQueueEntry entry) {
        return Card(
            key: Key(entry.id.toString()),
            child: ListTile(
                title: Elements.getTitle(entry.name, darken: entry.paused),
                subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                        Padding(
                            child: LinearPercentIndicator(
                                percent: entry.percentageDone/100,
                                padding: EdgeInsets.symmetric(horizontal: 2.0),
                                progressColor: entry.paused ? Color(Constants.ACCENT_COLOR).withOpacity(0.30) : Color(Constants.ACCENT_COLOR),
                                backgroundColor: entry.paused ? Color(Constants.ACCENT_COLOR).withOpacity(0.05) : Color(Constants.ACCENT_COLOR).withOpacity(0.15),
                                lineHeight: 4.0,
                            ),
                            padding: EdgeInsets.symmetric(vertical: 6.0),
                        ),
                        Elements.getSubtitle(entry.subtitle, darken: entry.paused),
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
            elevation: 4.0,
            margin: Elements.getCardMargin(),
        );
    }

    Future<void> _handlePopup(BuildContext context, NZBGetQueueEntry entry) async {
        List<dynamic> values = await NZBGetDialogs.showQueueSettingsPrompt(context, entry.name, entry.paused);
        if(values[0]) {
            switch(values[1]) {
                case 'status': {
                    if(entry.paused) {
                        if(await NZBGetAPI.resumeSingleJob(entry.id) && mounted) {
                            setState(() {
                                entry.status = 'QUEUED';
                            });
                            widget.refreshIndicatorKey?.currentState?.show();
                            Notifications.showSnackBar(widget.scaffoldKey, 'Job resumed');
                        } else {
                            Notifications.showSnackBar(widget.scaffoldKey, 'Failed to resume job');
                        }
                    } else {
                        if(await NZBGetAPI.pauseSingleJob(entry.id) && mounted) {
                            setState(() {
                                entry.status = 'PAUSED';
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
                    List<NZBGetCategoryEntry> categories = await NZBGetAPI.getCategories();
                    if(categories != null) {
                        values = await NZBGetDialogs.showCategoryPrompt(context, categories);
                        if(values[0]) {
                            if(await NZBGetAPI.setJobCategory(entry.id, values[1])) {
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
                    values = await NZBGetDialogs.showChangePriorityPrompt(context);
                    if(values[0]) {
                        if(await NZBGetAPI.setJobPriority(entry.id, values[1])) {
                            widget.refreshIndicatorKey?.currentState?.show();
                            Notifications.showSnackBar(widget.scaffoldKey, 'Updated priority');
                        } else {
                            Notifications.showSnackBar(widget.scaffoldKey, 'Failed to set priority');
                        }
                    }
                    break;
                }
                case 'delete': {
                    values = await NZBGetDialogs.showDeleteJobPrompt(context);
                    if(values[0]) {
                        if(await NZBGetAPI.deleteJob(entry.id)) {
                            widget.refreshIndicatorKey?.currentState?.show();
                            Notifications.showSnackBar(widget.scaffoldKey, 'Deleted job');
                        } else {
                            Notifications.showSnackBar(widget.scaffoldKey, 'Failed to delete job');
                        }
                    }
                    break;
                }
                case 'rename': {
                    values = await NZBGetDialogs.showRenameJobPrompt(context, entry.name);
                    if(values[0]) {
                        if(await NZBGetAPI.renameJob(entry.id, values[1]) && mounted) {
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
                    values = await NZBGetDialogs.showSetPasswordPrompt(context);
                    if(values[0]) {
                        if(await NZBGetAPI.setJobPassword(entry.id, values[1])) {
                            widget.refreshIndicatorKey?.currentState?.show();
                            Notifications.showSnackBar(widget.scaffoldKey, 'Password set');
                        } else {
                            Notifications.showSnackBar(widget.scaffoldKey, 'Failed to set password');
                        }
                    }
                    break;
                }
            }
            _refreshData();
        }
    }
}
