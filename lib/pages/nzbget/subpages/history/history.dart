import 'package:flutter/material.dart';
import 'package:lunasea/logic/clients/nzbget.dart';
import 'package:lunasea/system/constants.dart';
import 'package:lunasea/system/ui.dart';

class NZBGetHistory extends StatefulWidget {
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
    List<NZBGetHistoryEntry> _entries = [];
    bool _loading = true;
    DateTime now;

    @override
    initState() {
        super.initState();
        Future.delayed(Duration(milliseconds: 200)).then((_) {
            if(mounted) {
                widget.refreshIndicatorKey?.currentState?.show();
            }
        });
    }

    Future<void> _refreshData() async {
        if(mounted) {
            setState(() {
                _loading = true;
            });
        }
        now = DateTime.now();
        _entries = await NZBGetAPI.getHistory();
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

    Widget _buildEntry(NZBGetHistoryEntry entry) {
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
                                text: '${entry.completeTime}\t•\t',
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
            ),
            elevation: 4.0,
            margin: Elements.getCardMargin(),
        );
    }
}
