import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:tautulli/tautulli.dart';

class TautulliHistoryDetailsRoute extends StatefulWidget {
    final int userId;
    final int referenceId;
    final int sessionKey;

    static const String ROUTE = '/:profile/tautulli/history/details/:userid/:key/:value';
    /// ReferenceId takes priority over sessionKey
    static String enterRoute({
        String profile,
        @required int userId,
        int referenceId,
        int sessionKey,
    }) {
        if(referenceId != null) return profile == null
            ? '/${LunaSeaDatabaseValue.ENABLED_PROFILE.data}/tautulli/history/details/$userId/referenceid/$referenceId'
            : '/$profile/tautulli/history/details/referenceid/$referenceId';
        if(sessionKey != null) return profile == null
            ? '/${LunaSeaDatabaseValue.ENABLED_PROFILE.data}/tautulli/history/details/$userId/sessionkey/$sessionKey'
            : '/$profile/tautulli/history/details/sessionkey/$sessionKey';
        throw Exception('referenceId or sessionKey must be provided');
    }

    TautulliHistoryDetailsRoute({
        Key key,
        @required this.userId,
        this.referenceId,
        this.sessionKey,
    }) : super(key: key);

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<TautulliHistoryDetailsRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();

    @override
    void initState() {
        super.initState();
        SchedulerBinding.instance.scheduleFrameCallback((_) => _refresh());
    }

    Future<void> _refresh() async {
        TautulliState _global = Provider.of<TautulliState>(context, listen: false);
        TautulliLocalState _local = Provider.of<TautulliLocalState>(context, listen: false);
        if(widget.userId == -1) {
            _global.resetHistory();
            await _global.history;
        } else {
            _local.setUserHistory(
                widget.userId,
                _global.api.history.getHistory(
                    userId: widget.userId,
                    length: TautulliDatabaseValue.CONTENT_LOAD_LENGTH.data,
                ),
            );
            await _local.userHistory[widget.userId];
        }
    }

    TautulliHistoryRecord _findGlobalHistory(TautulliHistory history) {
        return history.records.firstWhere(
            (record) {
                if(record.referenceId != null && widget.referenceId != null) return record.referenceId == widget.referenceId ?? -1;
                if(record.sessionKey != null && widget.sessionKey != null) return record.sessionKey == widget.sessionKey ?? -1;
                return false;
            },
            orElse: () => null,
        );
    }

    TautulliHistoryRecord _findLocalHistory(TautulliHistory history) {
        return history.records.firstWhere(
            (record) {
                if(record.referenceId != null && widget.referenceId != null) return record.referenceId == widget.referenceId ?? -1;
                if(record.sessionKey != null && widget.sessionKey != null) return record.sessionKey == widget.sessionKey ?? -1;
                return false;
            },
            orElse: () => null,
        );
    }

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body,
    );

    Widget get _appBar => LSAppBar(title: 'History Details');

    Widget get _body => LSRefreshIndicator(
        refreshKey: _refreshKey,
        onRefresh: _refresh,
        child: widget.userId == -1 ? _global : _local,
    );

    Widget get _local => Selector<TautulliLocalState, Future<TautulliHistory>>(
        selector: (_, state) => state.userHistory[widget.userId],
        builder: (context, future, _) => _shared(future),
    );

    Widget get _global => Selector<TautulliState, Future<TautulliHistory>>(
        selector: (_, state) => state.history,
        builder: (context, future, _) => _shared(future),
    );

    Widget _shared(Future<TautulliHistory> history) => FutureBuilder(
        future: history,
        builder: (context, AsyncSnapshot<TautulliHistory> snapshot) {
            if(snapshot.hasError) {
                if(snapshot.connectionState != ConnectionState.waiting) {
                    Logger.error(
                        'TautulliHistoryDetailsRoute',
                        '_shared',
                        'Unable to pull Tautulli history session',
                        snapshot.error,
                        null,
                        uploadToSentry: !(snapshot.error is DioError),
                    );
                }
                return LSErrorMessage(onTapHandler: () => _refresh());
            }
            if(snapshot.hasData) {
                TautulliHistoryRecord history = widget.userId == -1
                    ? _findGlobalHistory(snapshot.data)
                    : _findLocalHistory(snapshot.data);
                return history == null
                    ? _unknown
                    : TautulliHistoryDetailsInformation(history: history);
            }
            return LSLoader();
        },
    );

    Widget get _unknown => LSGenericMessage(text: 'History Record Not Found');
}