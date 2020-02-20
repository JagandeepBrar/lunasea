import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lunasea/routes/nzbget/subpages/history/details.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/widgets/ui.dart';

class NZBGetHistory extends StatefulWidget {
    final NZBGetAPI api = NZBGetAPI.from(Database.getProfileObject());
    final GlobalKey<ScaffoldState> scaffoldKey;
    final GlobalKey<RefreshIndicatorState> refreshIndicatorKey;

    NZBGetHistory({
        Key key,
        @required this.scaffoldKey,
        @required this.refreshIndicatorKey,
    }) : super(key: key);

    @override
    State<NZBGetHistory> createState() {
        return _State();
    }
}

class _State extends State<NZBGetHistory> with TickerProviderStateMixin {
    final _scrollController = ScrollController();
    AnimationController _animationController;
    List<NZBGetHistoryEntry> _entries = [];
    bool _loading = true;
    bool _hideCompleted = false;
    bool _hideFab = false;

    @override
    initState() {
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

    Future<void> _refreshData() async {
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
                onRefresh: _refreshData,
                child: _loading ?
                    Notifications.centeredMessage('Loading...') :
                    _buildList(),
            ),
            floatingActionButton: _entries == null
                ? Container()
                : _buildFloatingActionButton(),
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
                if(!entry.isHideable) {
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

    Widget _buildEntry(NZBGetHistoryEntry entry) {
        if(_hideCompleted && entry.isHideable) {
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
                                text: '${entry.completeTime}\t•\t',
                            ),
                            TextSpan(
                                text: '${entry.sizeReadable}\n',
                            ),
                            TextSpan(
                                text: entry.statusString,
                                style: TextStyle(
                                    color: entry.statusColor,
                                    fontWeight: FontWeight.bold,
                                ),
                            ),
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
                onTap: () async {
                    await _enterDetails(entry);
                },
                onLongPress: () async {
                    await _handleLongPress(entry);
                },
                contentPadding: Elements.getContentPadding(),
            ),
            elevation: 4.0,
            margin: Elements.getCardMargin(),
        );
    }

    Future<void> _handleLongPress(NZBGetHistoryEntry entry) async {
        List<dynamic> values = await NZBGetDialogs.showHistorySettingsPrompt(context, entry.name, entry.failed);
        if(values[0]) {
            switch(values[1]) {
                case 'retry': {
                    if(await widget.api.retryHistoryEntry(entry.id)) {
                        widget.refreshIndicatorKey?.currentState?.show();
                        Notifications.showSnackBar(widget.scaffoldKey, entry.failed ? 'Attempting to retry job' : 'Redownloading job');
                    } else {
                        Notifications.showSnackBar(widget.scaffoldKey, entry.failed ? 'Failed to retry job' : 'Failed to redownload job');
                    }
                    break;
                }
                case 'hide': {
                    if(await widget.api.deleteHistoryEntry(entry.id, hide: true)) {
                        widget.refreshIndicatorKey?.currentState?.show();
                        Notifications.showSnackBar(widget.scaffoldKey, 'Hid history entry');
                    } else {
                        Notifications.showSnackBar(widget.scaffoldKey, 'Failed to hide history entry');
                    }
                    break;
                }
                case 'delete': {
                    if(await widget.api.deleteHistoryEntry(entry.id)) {
                        widget.refreshIndicatorKey?.currentState?.show();
                        Notifications.showSnackBar(widget.scaffoldKey, 'Deleted history entry');
                    } else {
                        Notifications.showSnackBar(widget.scaffoldKey, 'Failed to delete history entry');
                    }
                    break;
                }
            }
        }
    }

    Future<void> _enterDetails(NZBGetHistoryEntry entry) async {
        final result = await Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => NZBGetHistoryDetails(entry: entry),
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
