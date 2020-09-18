import 'package:fluro_fork/fluro_fork.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:tautulli/tautulli.dart';

class TautulliHistoryDetailsRoute extends StatefulWidget {
    static const String ROUTE_NAME = '/tautulli/history/details/:ratingkey/:key/:value/:profile';
    final int ratingKey;
    final int sessionKey;
    final int referenceId;

    TautulliHistoryDetailsRoute({
        Key key,
        @required this.ratingKey,
        this.sessionKey,
        this.referenceId,
    }) : super(key: key);

    @override
    State<StatefulWidget> createState() => _State();

    static String route({
        @required String profile,
        @required int ratingKey,
        int referenceId,
        int sessionKey,
    }) {
        String _route = '/tautulli/$profile';
        if(referenceId != null) _route = '/tautulli/history/details/$ratingKey/referenceid/$referenceId/$profile';
        if(sessionKey != null)  _route = '/tautulli/history/details/$ratingKey/sessionkey/$sessionKey/$profile';
        return _route;
    }

    static void defineRoute(Router router) => router.define(
        ROUTE_NAME,
        handler: Handler(handlerFunc: (context, params) => TautulliHistoryDetailsRoute(
            ratingKey: int.tryParse(params['ratingkey'][0]),
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
        _local.setHistory(
            widget.ratingKey,
            _global.api.history.getHistory(
                length: TautulliDatabaseValue.CONTENT_LOAD_LENGTH.data,
                ratingKey: widget.ratingKey,
            ),
        );
        await _local.history[widget.ratingKey];
    }

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body,
    );

    Widget get _appBar => LSAppBar(
        title: 'History Details',
        actions: [
            TautulliHistoryDetailsUser(ratingKey: widget.ratingKey, sessionKey: widget.sessionKey, referenceId: widget.referenceId),
            TautulliHistoryDetailsMetadata(ratingKey: widget.ratingKey, sessionKey: widget.sessionKey, referenceId: widget.referenceId),
        ],
    );

    Widget get _body => LSRefreshIndicator(
        refreshKey: _refreshKey,
        onRefresh: _refresh,
        child: FutureBuilder(
            future: Provider.of<TautulliLocalState>(context).history[widget.ratingKey],
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
                    TautulliHistoryRecord _record = snapshot.data.records.firstWhere((record) {
                        if(record.referenceId == (widget.referenceId ?? -1) || record.sessionKey == (widget.sessionKey ?? -1)) return true;
                        return false;
                    }, orElse: () => null);
                    if(_record != null) return TautulliHistoryDetailsInformation(history: _record);
                    return _unknown;
                }
                return LSLoader();
            },
        ),
    );

    Widget get _unknown => LSGenericMessage(text: 'History Record Not Found');
}
