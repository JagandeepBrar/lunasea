import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:tautulli/tautulli.dart';

class TautulliMediaDetailsHistory extends StatefulWidget {
    final TautulliMediaType type;
    final int ratingKey;

    TautulliMediaDetailsHistory({
        @required this.type,
        @required this.ratingKey,
        Key key,
    }): super(key: key);

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<TautulliMediaDetailsHistory> with AutomaticKeepAliveClientMixin {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();
    
    @override
    bool get wantKeepAlive => true;

    @override
    void initState() {
        super.initState();
        SchedulerBinding.instance.scheduleFrameCallback((_) => _refresh());
    }

    Future<void> _refresh() async {
        context.read<TautulliState>().setIndividualHistory(
            widget.ratingKey,
            context.read<TautulliState>().api.history.getHistory(
                ratingKey: _ratingKey,
                parentRatingKey: _parentRatingKey,
                grandparentRatingKey: _grandparentRatingKey,
                length: TautulliDatabaseValue.CONTENT_LOAD_LENGTH.data,
            ),
        );
        await context.read<TautulliState>().individualHistory[widget.ratingKey];
    }

    int get _ratingKey {
        switch(widget.type) { 
            case TautulliMediaType.MOVIE:
            case TautulliMediaType.EPISODE:
            case TautulliMediaType.LIVE:
            case TautulliMediaType.TRACK: return widget.ratingKey;
            default: return null;
        }
    }

    int get _parentRatingKey {
        switch(widget.type) { 
            case TautulliMediaType.SEASON:
            case TautulliMediaType.ALBUM: return widget.ratingKey;
            default: return null;
        }
    }

    int get _grandparentRatingKey {
        switch(widget.type) { 
            case TautulliMediaType.SHOW:
            case TautulliMediaType.ARTIST: return widget.ratingKey;
            default: return null;
        }
    }

    @override
    Widget build(BuildContext context) {
        super.build(context);
        return Scaffold(
            key: _scaffoldKey,
            body: _body,
        );
    }

    Widget get _body => LSRefreshIndicator(
        refreshKey: _refreshKey,
        onRefresh: _refresh,
        child: FutureBuilder(
            future: context.watch<TautulliState>().individualHistory[widget.ratingKey],
            builder: (context, AsyncSnapshot<TautulliHistory> snapshot) {
                if(snapshot.hasError) {
                    if(snapshot.connectionState != ConnectionState.waiting) {
                        LunaLogger().error('Unable to fetch Tautulli history: ${widget.ratingKey}', snapshot.error, StackTrace.current);
                    }
                    return LSErrorMessage(onTapHandler: () async => _refreshKey.currentState.show());
                }
                if(snapshot.hasData) return snapshot.data.records.length == 0 
                    ? _noHistory()
                    : _history(snapshot.data);
                return LSLoader();
            },
        ),
    );

    Widget _history(TautulliHistory history) => LSListViewBuilder(
        itemCount: history.records.length,
        itemBuilder: (context, index) => TautulliHistoryTile(
            userId: history.records[index].userId,
            history: history.records[index],
        ),
    );

    Widget _noHistory() => LSGenericMessage(
        text: 'No History Found',
        showButton: true,
        buttonText: 'Refresh',
        onTapHandler: () async => _refreshKey.currentState.show(),
    );
}
