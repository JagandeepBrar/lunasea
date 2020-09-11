import 'package:fluro_fork/fluro_fork.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:tautulli/tautulli.dart';

class TautulliHistoryDetailsRoute extends StatefulWidget {
    static const String ROUTE_NAME = '/tautulli/history/details/:userid/:key/:value/:profile';
    final int userId;
    final int referenceId;
    final int sessionKey;

    TautulliHistoryDetailsRoute({
        Key key,
        @required this.userId,
        this.referenceId,
        this.sessionKey,
    }) : super(key: key);

    @override
    State<StatefulWidget> createState() => _State();

    /// ReferenceId takes priority over sessionKey
    static String route({ String profile, @required int userId, int referenceId, int sessionKey }) {
        if(profile == null) {
            if(referenceId != null) return '/tautulli/history/details/$userId/referenceid/$referenceId/${LunaSeaDatabaseValue.ENABLED_PROFILE.data}';
            if(sessionKey != null)  return '/tautulli/history/details/$userId/sessionkey/$sessionKey/${LunaSeaDatabaseValue.ENABLED_PROFILE.data}';
        } else {
            if(referenceId != null) return '/tautulli/history/details/$userId/referenceid/$referenceId/$profile';
            if(sessionKey != null) return '/tautulli/history/details/$userId/sessionkey/$sessionKey/$profile';
        }
        throw Exception('referenceId or sessionKey must be provided');
    }

    static void defineRoute(Router router) => router.define(
        ROUTE_NAME,
        handler: Handler(handlerFunc: (context, params) => TautulliHistoryDetailsRoute(
            userId: int.tryParse(params['userid'][0]),
            sessionKey: params['key'][0] == 'sessionkey' ? int.tryParse(params['value'][0]) : null,
            referenceId: params['key'][0] == 'referenceid' ? int.tryParse(params['value'][0]) : null,
        )),
        transitionType: LunaRouter.transitionType,
    );
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

    Widget get _appBar => LSAppBar(
        title: 'History Details',
        actions: [],
    );

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