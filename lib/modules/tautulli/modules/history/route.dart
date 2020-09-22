import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:tautulli/tautulli.dart';

class TautulliHistoryRoute extends StatefulWidget {
    TautulliHistoryRoute({
        Key key,
    }): super(key: key);

    @override
    State<TautulliHistoryRoute> createState() => _State();
}

class _State extends State<TautulliHistoryRoute> with AutomaticKeepAliveClientMixin {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();

    @override
    bool get wantKeepAlive => true;

    Future<void> _refresh() async {
        TautulliState _state = Provider.of<TautulliState>(context, listen: false);
        _state.resetHistory();
        await _state.history;
    }

    @override
    void initState() {
        super.initState();
        SchedulerBinding.instance.scheduleFrameCallback((_) => _refresh());
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
        child: Selector<TautulliState, Future<TautulliHistory>>(
            selector: (_, state) => state.history,
            builder: (context, history, _) => FutureBuilder(
                future: history,
                builder: (context, AsyncSnapshot<TautulliHistory> snapshot) {
                    if(snapshot.hasError) {
                        if(snapshot.connectionState != ConnectionState.waiting) {
                            LunaLogger.error(
                                'TautulliHistoryRoute',
                                '_body',
                                'Unable to fetch Tautulli history',
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
        ),
    );

    Widget _history(TautulliHistory history) => LSListViewBuilder(
        itemCount: history.records.length,
        itemBuilder: (context, index) => TautulliHistoryTile(
            userId: -1,
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
