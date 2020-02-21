import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lunasea/routes/sabnzbd/subpages/history/details.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/widgets/ui.dart';

class SABnzbdHistory extends StatefulWidget {
    final GlobalKey<ScaffoldState> scaffoldKey;
    final GlobalKey<RefreshIndicatorState> refreshIndicatorKey;
    final SABnzbdAPI api = SABnzbdAPI.from(Database.currentProfileObject);

    SABnzbdHistory({
        Key key,
        @required this.scaffoldKey,
        @required this.refreshIndicatorKey,
    }) : super(key: key);

    @override
    State<SABnzbdHistory> createState() {
        return _State();
    }
}

class _State extends State<SABnzbdHistory> with TickerProviderStateMixin {
    final _scrollController = ScrollController();
    AnimationController _animationController;
    List<SABnzbdHistoryEntry> _entries = [];
    bool _loading = true;
    bool _hideCompleted = false;
    bool _hideFab = false;

    @override
    void initState() { 
        super.initState();
        _animationController = AnimationController(vsync: this, duration: kThemeAnimationDuration);
        _animationController?.forward();
        _scrollController.addListener(() {
            if(_scrollController?.position?.userScrollDirection == ScrollDirection.reverse) {
                if(!_hideFab) {
                    _hideFab = true;
                    _animationController?.reverse();

                }
            } else if(_scrollController?.position?.userScrollDirection == ScrollDirection.forward) {
                if(_hideFab) {
                    _hideFab = false;
                    _animationController?.forward();
                }
            }
        });
        Future.delayed(Duration(milliseconds: 200)).then((_) {
            if(mounted) {
                widget.refreshIndicatorKey?.currentState?.show();
            } 
        });
    }

    @override
    void dispose() {
        _animationController?.dispose();
        super.dispose();
    }

    Future<void> _handleRefresh() async {
        if(mounted) {
            setState(() {
                _loading = true;
            });
        }
        _entries = await widget.api.getHistory();
        if(mounted) {
            setState(() {
                _loading = false;
            });
        }
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            key: widget.scaffoldKey,
            body: RefreshIndicator(
                key: widget.refreshIndicatorKey,
                backgroundColor: Color(Constants.SECONDARY_COLOR),
                onRefresh: _handleRefresh,
                child: _loading ?
                    Notifications.centeredMessage('Loading...') :
                    _buildList(),
            ),
            floatingActionButton: _entries == null ?
                Container() :
                _buildFloatingActionButton(),
        );
    }

    Widget _buildFloatingActionButton() {
        return ScaleTransition(
            child: FloatingActionButton(
                heroTag: null,
                tooltip: 'Hide/Unhide Successfully Completed History',
                child: Elements.getIcon(_hideCompleted ? Icons.visibility_off : Icons.visibility),
                onPressed: () async {
                    if(mounted) {
                        setState(() {
                            _hideCompleted = !_hideCompleted;
                        });
                    }
                },
            ),
            scale: _animationController,
        );
    }

    Widget _buildList() {
        if(_entries == null) {
            return Notifications.centeredMessage('Connection Error', showBtn: true, btnMessage: 'Refresh', onTapHandler: () async {
                widget.refreshIndicatorKey?.currentState?.show();
            });
        }
        if(_entries.length == 0) {
            return Notifications.centeredMessage('No History Found', showBtn: true, btnMessage: 'Refresh', onTapHandler: () async {
                widget.refreshIndicatorKey?.currentState?.show();
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
                widget.refreshIndicatorKey?.currentState?.show();
            });
        }
        return Scrollbar(
            child: ListView.builder(
                controller: _scrollController,
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
                            letterSpacing: Constants.UI_LETTER_SPACING,
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
                                if(await widget.api.deleteHistory(entry.nzoId)) {
                                    widget.refreshIndicatorKey?.currentState?.show();
                                    Notifications.showSnackBar(widget.scaffoldKey, 'Deleted history entry');
                                } else {
                                    Notifications.showSnackBar(widget.scaffoldKey, 'Failed to delete history entry');
                                }
                                break;
                            }
                            case 'retry': {
                                if(await widget.api.retryFailedJob(entry.nzoId)) {
                                    widget.refreshIndicatorKey?.currentState?.show();
                                    Notifications.showSnackBar(widget.scaffoldKey, 'Attempting to retry job');
                                } else {
                                    Notifications.showSnackBar(widget.scaffoldKey, 'Failed to retry job');
                                }
                                break;
                            }
                            case 'password': {
                                values = await SABnzbdDialogs.showSetPasswordPrompt(context);
                                if(values[0]) {
                                    if(await widget.api.retryFailedJobPassword(entry.nzoId, values[1])) {
                                        widget.refreshIndicatorKey?.currentState?.show();
                                        Notifications.showSnackBar(widget.scaffoldKey, 'Attempting to retry job with supplied password');
                                    } else {
                                        Notifications.showSnackBar(widget.scaffoldKey, 'Failed to set password, not attempting to retry job');
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
                    widget.refreshIndicatorKey?.currentState?.show();
                    Notifications.showSnackBar(widget.scaffoldKey, 'Deleted history entry');
                }
            }
        }
    }
}