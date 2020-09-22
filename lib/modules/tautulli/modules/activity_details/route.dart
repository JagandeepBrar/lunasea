import 'package:fluro_fork/fluro_fork.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:tautulli/tautulli.dart';

class TautulliActivityDetailsRouter {
    static const String ROUTE_NAME = '/tautulli/activity/details/:sessionid';

    static Future<void> navigateTo(BuildContext context, {
        @required String sessionId,
    }) async => TautulliRouter.router.navigateTo(
        context,
        route(sessionId: sessionId),
    );

    static String route({
        String profile,
        @required String sessionId,
    }) => [
        ROUTE_NAME.replaceFirst(':sessionid', sessionId ?? '0'),
        if(profile != null) '/$profile',
    ].join();

    static void defineRoutes(Router router) {
        /// With profile defined
        router.define(
            ROUTE_NAME + '/:profile',
            handler: Handler(handlerFunc: (context, params) => _TautulliActivityDetailsRoute(
                sessionId: params['sessionid'] != null && params['sessionid'].length != 0
                    ? params['sessionid'][0] ?? '-1'
                    : '-1',
                profile: params['profile'] != null && params['profile'].length != 0
                    ? params['profile'][0]
                    : null,
            )),
            transitionType: LunaRouter.transitionType,
        );
        /// Without profile defined
        router.define(
            ROUTE_NAME,
            handler: Handler(handlerFunc: (context, params) => _TautulliActivityDetailsRoute(
                sessionId: params['sessionid'] != null && params['sessionid'].length != 0
                    ? params['sessionid'][0] ?? '-1'
                    : '-1',
                profile: null,
            )),
            transitionType: LunaRouter.transitionType,
        );
    }

    TautulliActivityDetailsRouter._();
}

class _TautulliActivityDetailsRoute extends StatefulWidget {
    final String profile;
    final String sessionId;

    _TautulliActivityDetailsRoute({
        Key key,
        @required this.profile,
        @required this.sessionId,
    }): super(key: key);

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<_TautulliActivityDetailsRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();

    Future<void> _refresh() async {
        TautulliState _state = Provider.of<TautulliState>(context, listen: false);
        _state.resetActivity();
        await _state.activity;
    }

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body,
    );

    Widget get _appBar => LSAppBar(
        title: 'Activity Details',
        actions: [
            TautulliActivityDetailsUser(sessionId: widget.sessionId),
            TautulliActivityDetailsMetadata(sessionId: widget.sessionId),
        ]
    );

    Widget get _body => LSRefreshIndicator(
        refreshKey: _refreshKey,
        onRefresh: _refresh,
        child: Selector<TautulliState, Future<TautulliActivity>>(
            selector: (_, state) => state.activity,
            builder: (context, future, _) => FutureBuilder(
                future: future,
                builder: (context, AsyncSnapshot<TautulliActivity> snapshot) {
                    if(snapshot.hasError) {
                        if(snapshot.connectionState != ConnectionState.waiting) {
                            LunaLogger.error(
                                '_TautulliActivityDetailsRoute',
                                '_body',
                                'Unable to pull Tautulli activity session',
                                snapshot.error,
                                null,
                                uploadToSentry: !(snapshot.error is DioError),
                            );
                        }
                        return LSErrorMessage(onTapHandler: () => _refresh());
                    }
                    if(snapshot.hasData) {
                        TautulliSession session = snapshot.data.sessions.firstWhere((element) => element.sessionId == widget.sessionId, orElse: () => null);
                        return session == null
                            ? _deadSession()
                            : _activeSession(session);
                    }       
                    return LSLoader();
                },
            ),
        ),
    );

    Widget _activeSession(TautulliSession session) => TautulliActivityDetailsInformation(session: session);

    Widget _deadSession() => LSGenericMessage(
        text: 'Session Ended',
        showButton: true,
        buttonText: 'Back',
        onTapHandler: () async => TautulliRouter.router.pop(context),
    );
}
