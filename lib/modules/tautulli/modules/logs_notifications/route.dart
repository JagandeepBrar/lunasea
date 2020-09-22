import 'package:fluro_fork/fluro_fork.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:tautulli/tautulli.dart';

class TautulliLogsNotificationsRouter {
    static const String ROUTE_NAME = '/tautulli/logs/notifications';

    static Future<void> navigateTo(BuildContext context) async => TautulliRouter.router.navigateTo(
        context,
        route(),
    );

    static String route({ String profile }) => [
        ROUTE_NAME,
        if(profile != null) '/$profile',
    ].join();

    static void defineRoutes(Router router) {
        router.define(
            ROUTE_NAME,
            handler: Handler(handlerFunc: (context, params) => _TautulliLogsNotificationsRoute(
                profile: null,
            )),
            transitionType: LunaRouter.transitionType,
        );
        router.define(
            ROUTE_NAME + '/:profile',
            handler: Handler(handlerFunc: (context, params) => _TautulliLogsNotificationsRoute(
                profile: params['profile'] != null && params['profile'].length != 0 ? params['profile'][0] : null,
            )),
            transitionType: LunaRouter.transitionType,
        );
    }

    TautulliLogsNotificationsRouter._();
}

class _TautulliLogsNotificationsRoute extends StatefulWidget {
    final String profile;

    _TautulliLogsNotificationsRoute({
        Key key,
        @required this.profile,
    }) : super(key: key);

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<_TautulliLogsNotificationsRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();

    Future<void> _refresh() async {
        TautulliLocalState _state = Provider.of<TautulliLocalState>(context, listen: false);
        _state.resetNotificationLogs(context);
        await _state.notificationLogs;
    }

    @override
    void initState() {
        super.initState();
        SchedulerBinding.instance.scheduleFrameCallback((_) => _refresh());
    }

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body,
    );

    Widget get _appBar => LSAppBar(title: 'Notification Logs');

    Widget get _body => LSRefreshIndicator(
        onRefresh: _refresh,
        refreshKey: _refreshKey,
        child: Selector<TautulliLocalState, Future<TautulliNotificationLogs>>(
            selector: (_, state) => state.notificationLogs,
            builder: (context, logs, _) => FutureBuilder(
                future: logs,
                builder: (context, AsyncSnapshot<TautulliNotificationLogs> snapshot) {
                    if(snapshot.hasError) {
                        if(snapshot.connectionState != ConnectionState.waiting) {
                            LunaLogger.error(
                                '_TautulliLogsNotificationsRoute',
                                '_body',
                                'Unable to fetch Tautulli notification logs',
                                snapshot.error,
                                StackTrace.current,
                                uploadToSentry: !(snapshot.error is DioError),
                            );
                        }
                        return LSErrorMessage(onTapHandler: () async => _refreshKey.currentState.show());
                    }
                    if(snapshot.hasData) return snapshot.data.logs.length == 0
                        ? _noLoginLogs()
                        : _loginLogs(snapshot.data);
                    return LSLoader();
                },
            ),
        ),
    );

    Widget _noLoginLogs() => LSGenericMessage(
        text: 'No Logs Found',
        showButton: true,
        buttonText: 'Refresh',
        onTapHandler: () async => _refreshKey.currentState.show(),
    );

    Widget _loginLogs(TautulliNotificationLogs logs) => LSListViewBuilder(
        itemCount: logs.logs.length,
        itemBuilder: (context, index) => TautulliLogsNotificationLogTile(notification: logs.logs[index]),
    );
}
