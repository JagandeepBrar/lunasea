import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:tautulli/tautulli.dart';

class TautulliMetadataDetailsHistory extends StatefulWidget {
    final int ratingKey;

    TautulliMetadataDetailsHistory({
        @required this.ratingKey,
        Key key,
    }): super(key: key);

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<TautulliMetadataDetailsHistory> with AutomaticKeepAliveClientMixin {
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
        TautulliState _global = Provider.of<TautulliState>(context, listen: false);
        TautulliLocalState _local = Provider.of<TautulliLocalState>(context, listen: false);
        //int _ratingKey, _parentRatingKey, _grandparentRatingKey;
        _local.setHistory(
            widget.ratingKey,
            _global.api.history.getHistory(
                ratingKey: widget.ratingKey != null ? widget.ratingKey : null,
                // parentRatingKey: _parentRatingKey != null ? _parentRatingKey : null,
                // grandparentRatingKey: _grandparentRatingKey != null ? _grandparentRatingKey : null,
                length: TautulliDatabaseValue.CONTENT_LOAD_LENGTH.data,
            ),
        );
        await _local.history[widget.ratingKey];
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
            future: Provider.of<TautulliLocalState>(context).history[widget.ratingKey],
            builder: (context, AsyncSnapshot<TautulliHistory> snapshot) {
                if(snapshot.hasError) {
                    if(snapshot.connectionState != ConnectionState.waiting) {
                        Logger.error(
                            'TautulliMetadataDetailsHistory',
                            '_body',
                            'Unable to fetch Tautulli history: ${widget.ratingKey}',
                            snapshot.error,
                            null,
                            uploadToSentry: !(snapshot.error is DioError),
                        );
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
