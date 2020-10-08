import 'package:fluro_fork/fluro_fork.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:tautulli/tautulli.dart';

class TautulliLogsTautulliRouter {
    static const String ROUTE_NAME = '/tautulli/logs/tautulli';

    static Future<void> navigateTo(BuildContext context) async => LunaRouter.router.navigateTo(
        context,
        route(),
    );

    static String route() => ROUTE_NAME;

    static void defineRoutes(Router router) {
        router.define(
            ROUTE_NAME,
            handler: Handler(handlerFunc: (context, params) => _TautulliLogsTautulliRoute()),
            transitionType: LunaRouter.transitionType,
        );
    }

    TautulliLogsTautulliRouter._();
}

class _TautulliLogsTautulliRoute extends StatefulWidget {
    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<_TautulliLogsTautulliRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();

    Future<void> _refresh() async {
        context.read<TautulliState>().resetTautulliLogs();
        await context.read<TautulliState>().tautulliLogs;
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
        title: 'Tautulli Logs',
        popUntil: '/tautulli',
    );

    Widget get _body => LSRefreshIndicator(
        onRefresh: _refresh,
        refreshKey: _refreshKey,
        child: Selector<TautulliState, Future<List<TautulliLog>>>(
            selector: (_, state) => state.tautulliLogs,
            builder: (context, logs, _) => FutureBuilder(
                future: logs,
                builder: (context, AsyncSnapshot<List<TautulliLog>> snapshot) {
                    if(snapshot.hasError) {
                        if(snapshot.connectionState != ConnectionState.waiting) {
                            LunaLogger.error(
                                '_TautulliLogsTautulliRoute',
                                '_body',
                                'Unable to fetch Tautulli Tautulli logs',
                                snapshot.error,
                                StackTrace.current,
                                uploadToSentry: !(snapshot.error is DioError),
                            );
                        }
                        return LSErrorMessage(onTapHandler: () async => _refreshKey.currentState.show());
                    }
                    if(snapshot.hasData) return snapshot.data.length == 0
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

    Widget _logs(List<TautulliLog> logs) => LSListViewBuilder(
        itemCount: logs.length,
        itemBuilder: (context, index) => TautulliLogsTautulliLogTile(log: logs[index]),
    );
}
