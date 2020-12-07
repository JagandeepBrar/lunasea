import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:tautulli/tautulli.dart';

class TautulliHistoryDetailsRouter {
    static const String ROUTE_NAME = '/tautulli/history/details/:ratingkey/:key/:value';

    static Future<void> navigateTo(BuildContext context, {
        @required int ratingKey,
        int referenceId,
        int sessionKey,
    }) async => LunaRouter.router.navigateTo(
        context,
        route(ratingKey: ratingKey, referenceId: referenceId, sessionKey: sessionKey),
    );

    static String route({
        @required int ratingKey,
        int referenceId,
        int sessionKey,
    }) {
        String _route = '/tautulli';
        if(referenceId != null) _route = '/tautulli/history/details/$ratingKey/referenceid/$referenceId';
        if(sessionKey != null)  _route = '/tautulli/history/details/$ratingKey/sessionkey/$sessionKey';
        return _route;
    }

    static void defineRoutes(FluroRouter router) {
        router.define(
            ROUTE_NAME,
            handler: Handler(handlerFunc: (context, params) => _TautulliHistoryDetailsRoute(
                ratingKey: int.tryParse(params['ratingkey'][0]),
                sessionKey: params['key'][0] == 'sessionkey' ? int.tryParse(params['value'][0]) : null,
                referenceId: params['key'][0] == 'referenceid' ? int.tryParse(params['value'][0]) : null,
            )),
            transitionType: LunaRouter.transitionType,
        );
    }

    TautulliHistoryDetailsRouter._();
}

class _TautulliHistoryDetailsRoute extends StatefulWidget {
    final int ratingKey;
    final int sessionKey;
    final int referenceId;

    _TautulliHistoryDetailsRoute({
        Key key,
        @required this.ratingKey,
        this.sessionKey,
        this.referenceId,
    }) : super(key: key);

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<_TautulliHistoryDetailsRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();

    @override
    void initState() {
        super.initState();
        SchedulerBinding.instance.scheduleFrameCallback((_) => _refresh());
    }

    Future<void> _refresh() async {
        context.read<TautulliState>().setIndividualHistory(
            widget.ratingKey,
            context.read<TautulliState>().api.history.getHistory(
                length: TautulliDatabaseValue.CONTENT_LOAD_LENGTH.data,
                ratingKey: widget.ratingKey,
            ),
        );
        await context.read<TautulliState>().individualHistory[widget.ratingKey];
    }

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body,
    );

    Widget get _appBar => LunaAppBar(
        context: context,
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
            future: context.watch<TautulliState>().individualHistory[widget.ratingKey],
            builder: (context, AsyncSnapshot<TautulliHistory> snapshot) {
                if(snapshot.hasError) {
                    if(snapshot.connectionState != ConnectionState.waiting) {
                        LunaLogger.error(
                            '_TautulliHistoryDetailsRoute',
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

    Widget get _unknown => LSGenericMessage(text: 'History Not Found');
}
