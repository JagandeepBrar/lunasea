import 'package:fluro_fork/fluro_fork.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:tautulli/tautulli.dart';

class TautulliLogsLoginsRouter {
    static const String ROUTE_NAME = '/tautulli/logs/logins';

    static Future<void> navigateTo(BuildContext context) async => LunaRouter.router.navigateTo(
        context,
        route(),
    );

    static String route() => ROUTE_NAME;

    static void defineRoutes(Router router) {
        router.define(
            ROUTE_NAME,
            handler: Handler(handlerFunc: (context, params) => _TautulliLogsLoginsRoute()),
            transitionType: LunaRouter.transitionType,
        );
    }

    TautulliLogsLoginsRouter._();
}

class _TautulliLogsLoginsRoute extends StatefulWidget {
    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<_TautulliLogsLoginsRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();

    Future<void> _refresh() async {
        context.read<TautulliState>().resetLoginLogs();
        await context.read<TautulliState>().loginLogs;
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

    Widget get _appBar => LunaAppBar(
        context: context,
        title: 'Login Logs',
        popUntil: '/tautulli',
    );

    Widget get _body => LSRefreshIndicator(
        onRefresh: _refresh,
        refreshKey: _refreshKey,
        child: Selector<TautulliState, Future<TautulliUserLogins>>(
            selector: (_, state) => state.loginLogs,
            builder: (context, logs, _) => FutureBuilder(
                future: logs,
                builder: (context, AsyncSnapshot<TautulliUserLogins> snapshot) {
                    if(snapshot.hasError) {
                        if(snapshot.connectionState != ConnectionState.waiting) {
                            LunaLogger.error(
                                '_TautulliLogsLoginsRoute',
                                '_body',
                                'Unable to fetch Tautulli login logs',
                                snapshot.error,
                                StackTrace.current,
                                uploadToSentry: !(snapshot.error is DioError),
                            );
                        }
                        return LSErrorMessage(onTapHandler: () async => _refreshKey.currentState.show());
                    }
                    if(snapshot.hasData) return snapshot.data.logins.length == 0
                        ? _noLogs()
                        : _logs(snapshot.data);
                    return LSLoader();
                },
            ),
        ),
    );

    Widget _noLogs() => LSGenericMessage(
        text: 'No Logs Found',
        showButton: true,
        buttonText: 'Refresh',
        onTapHandler: () async => _refreshKey.currentState.show(),
    );

    Widget _logs(TautulliUserLogins logs) => LSListViewBuilder(
        itemCount: logs.logins.length,
        itemBuilder: (context, index) => TautulliLogsLoginsLogTile(login: logs.logins[index]),
    );
}
