import 'package:flutter/material.dart';
import 'package:lunasea/logic/clients/sabnzbd.dart';
import 'package:lunasea/logic/clients/sabnzbd/entry.dart';
import 'package:lunasea/pages/sabnzbd/subpages/history/details/details.dart';
import 'package:lunasea/system/constants.dart';
import 'package:lunasea/system/ui.dart';

class SABnzbdHistory extends StatelessWidget {
    final GlobalKey<ScaffoldState> scaffoldKey;
    final GlobalKey<RefreshIndicatorState> refreshIndicatorKey;

    SABnzbdHistory({
        Key key,
        @required this.scaffoldKey,
        @required this.refreshIndicatorKey,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return _SABnzbdHistoryWidget(
            scaffoldKey: scaffoldKey,
            refreshIndicatorKey: refreshIndicatorKey,
        );
    }
}

class _SABnzbdHistoryWidget extends StatefulWidget {
    final GlobalKey<ScaffoldState> scaffoldKey;
    final GlobalKey<RefreshIndicatorState> refreshIndicatorKey;

    _SABnzbdHistoryWidget({
        Key key,
        @required this.scaffoldKey,
        @required this.refreshIndicatorKey,
    }) : super(key: key);

    @override
    State<StatefulWidget> createState() {
        return _SABnzbdHistoryState(
            scaffoldKey: scaffoldKey,
            refreshIndicatorKey: refreshIndicatorKey,
        );
    }
}

class _SABnzbdHistoryState extends State<StatefulWidget> {
    final GlobalKey<ScaffoldState> scaffoldKey;
    final GlobalKey<RefreshIndicatorState> refreshIndicatorKey;
    List<SABnzbdHistoryEntry> _entries = [];
    bool _loading = true;
    bool _hideCompleted = false;
    DateTime now;

    _SABnzbdHistoryState({
        Key key,
        @required this.scaffoldKey,
        @required this.refreshIndicatorKey,
    });

    @override
    void initState() { 
        super.initState();
        Future.delayed(Duration(milliseconds: 200)).then((_) {
            if(mounted) {
                refreshIndicatorKey?.currentState?.show();
            } 
        });
    }

    Future<void> _handleRefresh() async {
        if(mounted) {
            setState(() {
                _loading = true;
            });
        }
        now = DateTime.now();
        _entries = await SABnzbdAPI.getHistory();
        if(mounted) {
            setState(() {
                _loading = false;
            });
        }
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            key: scaffoldKey,
            floatingActionButton: _buildFloatingActionButton(),
            body: RefreshIndicator(
                key: refreshIndicatorKey,
                backgroundColor: Color(Constants.SECONDARY_COLOR),
                onRefresh: _handleRefresh,
                child: _loading ?
                    Notifications.centeredMessage('Loading...') :
                    _buildList(),
            ),
        );
    }

    FloatingActionButton _buildFloatingActionButton() {
        return FloatingActionButton(
            heroTag: null,
            tooltip: 'Hide/Unhide Successfully Completed History',
            child: _hideCompleted ? (
                Icon(
                    Icons.visibility_off,
                    color: Colors.white,
                )
            ) : (
                Icon(
                    Icons.visibility,
                    color: Colors.white,
                )
            ),
            onPressed: () async {
                setState(() {
                    _hideCompleted = !_hideCompleted;
                });
            },
        );
    }

    Widget _buildList() {
        if(_entries == null) {
            return Notifications.centeredMessage('Connection Error', showBtn: true, btnMessage: 'Refresh', onTapHandler: () async {
                refreshIndicatorKey?.currentState?.show();
            });
        }
        if(_entries.length == 0) {
            return Notifications.centeredMessage('No History Found', showBtn: true, btnMessage: 'Refresh', onTapHandler: () async {
                refreshIndicatorKey?.currentState?.show();
            });
        }
        bool failed = false;
        if(_hideCompleted) {
            for(var entry in _entries) {
                if(entry.failed) {
                    failed = true;
                    break;
                }
            }
        }
        if(_hideCompleted && !failed) {
            return Notifications.centeredMessage('No Unsuccessful History Found', showBtn: true, btnMessage: 'Refresh', onTapHandler: () async {
                refreshIndicatorKey?.currentState?.show();
            });
        }
        return Scrollbar(
            child: ListView.builder(
                itemCount: _entries.length,
                itemBuilder: (context, index) {
                    return _buildEntry(_entries[index]);
                },
                padding: Elements.getListViewPadding(),
                physics: AlwaysScrollableScrollPhysics(),
            ),
        );
    }

    Widget _buildEntry(SABnzbdHistoryEntry entry) {
        if(_hideCompleted && !entry.failed) {
            return Container();
        }
        return Card(
            child: ListTile(
                title: Elements.getTitle(entry.name),
                subtitle: RichText(
                        text: TextSpan(
                            style: TextStyle(
                                color: Colors.white70,
                                letterSpacing: Constants.LETTER_SPACING,
                            ),
                            children: <TextSpan>[
                                TextSpan(
                                    text: '${entry.completeTimeString}\t•\t',
                                ),
                                TextSpan(
                                    text: '${entry.sizeReadable}\n',
                                ),
                                entry.getStatus,
                            ],
                        ),
                        overflow: TextOverflow.fade,
                        softWrap: false,
                        maxLines: 2,
                    ),
                trailing: IconButton(
                    icon: Elements.getIcon(Icons.arrow_forward_ios),
                    onPressed: null,
                ),
                contentPadding: Elements.getContentPadding(),
                onTap: () async {
                    await _enterDetails(entry);
                },
                onLongPress: () async {
                    List<dynamic> values = await SABnzbdDialogs.showHistorySettingsPrompt(context, entry.name, entry.failed);
                    if(values[0]) {
                        switch(values[1]) {
                            case 'delete': {
                                if(await SABnzbdAPI.deleteHistory(entry.nzoId)) {
                                    refreshIndicatorKey?.currentState?.show();
                                    Notifications.showSnackBar(scaffoldKey, 'Deleted history entry');
                                } else {
                                    Notifications.showSnackBar(scaffoldKey, 'Failed to delete history entry');
                                }
                                break;
                            }
                            case 'retry': {
                                if(await SABnzbdAPI.retryFailedJob(entry.nzoId)) {
                                    refreshIndicatorKey?.currentState?.show();
                                    Notifications.showSnackBar(scaffoldKey, 'Attempting to retry job');
                                } else {
                                    Notifications.showSnackBar(scaffoldKey, 'Failed to retry job');
                                }
                                break;
                            }
                            case 'password': {
                                values = await SABnzbdDialogs.showSetPasswordPrompt(context);
                                if(values[0]) {
                                    if(await SABnzbdAPI.retryFailedJobPassword(entry.nzoId, values[1])) {
                                        refreshIndicatorKey?.currentState?.show();
                                        Notifications.showSnackBar(scaffoldKey, 'Attempting to retry job with supplied password');
                                    } else {
                                        Notifications.showSnackBar(scaffoldKey, 'Failed to set password, not attempting to retry job');
                                    }
                                }
                            }
                        }
                    }
                },
            ),
            elevation: 4.0,
            margin: Elements.getCardMargin(),
        );
    }

    Future<void> _enterDetails(SABnzbdHistoryEntry entry) async {
        final result = await Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => SABnzbdHistoryDetails(entry: entry),
            ),
        );
        if(result != null) {
            switch(result[0]) {
                case 'delete': {
                    refreshIndicatorKey?.currentState?.show();
                    Notifications.showSnackBar(scaffoldKey, 'Deleted history entry');
                }
            }
        }
    }
}