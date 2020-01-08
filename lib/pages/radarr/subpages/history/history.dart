import 'package:flutter/material.dart';
import 'package:lunasea/logic/automation/radarr.dart';
import 'package:lunasea/system/constants.dart';
import 'package:lunasea/system/ui.dart';

class History extends StatefulWidget {
    final GlobalKey<RefreshIndicatorState> refreshIndicatorKey;

    History({
        Key key,
        @required this.refreshIndicatorKey,
    }) : super(key: key);

    @override
    State<History> createState() {
        return _State();
    }
}

class _State extends State<History> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    List<RadarrHistoryEntry> _historyEntries = [];
    bool _loading = true;

    @override
    void initState() {
        super.initState();
        Future.delayed(Duration(milliseconds: 200)).then((_) {
            if(mounted) {
                widget.refreshIndicatorKey?.currentState?.show();
            }
        });
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            key: _scaffoldKey,
            body: RefreshIndicator(
                key: widget.refreshIndicatorKey,
                backgroundColor: Color(Constants.SECONDARY_COLOR),
                onRefresh: _handleRefresh,
                child: _loading ?
                    Notifications.centeredMessage('Loading...') :
                    _historyEntries == null ?
                        Notifications.centeredMessage('Connection Error', showBtn: true, btnMessage: 'Refresh', onTapHandler: () {widget.refreshIndicatorKey?.currentState?.show();}) :
                        _historyEntries.length == 0 ?
                            Notifications.centeredMessage('No History Found', showBtn: true, btnMessage: 'Refresh', onTapHandler: () {widget.refreshIndicatorKey?.currentState?.show();}) :
                            _buildList(),
            ),
        );
    }

    Future<void> _handleRefresh() async {
        if(mounted) {
            setState(() {
                _loading = true;
            });
        }
        _historyEntries = await RadarrAPI.getHistory();
        if(mounted) {
            setState(() {
                _loading = false;
            });
        }
    }

    Widget _buildList() {
        return Scrollbar(
            child: ListView.builder(
                itemCount: _historyEntries.length,
                itemBuilder: (context, index) {
                    return _buildEntry(_historyEntries[index]);
                },
                padding: Elements.getListViewPadding(),
                physics: AlwaysScrollableScrollPhysics(),
            ),
        );
    }

    Widget _buildEntry(RadarrHistoryEntry entry) {
        return Card(
            child: Container(
                child: ListTile(
                    title: Elements.getTitle(entry.movieTitle),
                    subtitle: RichText(
                        text: TextSpan(
                            style: TextStyle(
                                color: Colors.white70,
                                letterSpacing: Constants.LETTER_SPACING,
                            ),
                            children: entry.subtitle,
                        ),
                    ),
                    contentPadding: Elements.getContentPadding(),
                ),
            ),
            margin: Elements.getCardMargin(),
            elevation: 4.0,
        );
    }
}