import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:tautulli/tautulli.dart';

class TautulliLogsNotificationsRouter extends TautulliPageRouter {
    TautulliLogsNotificationsRouter() : super('/tautulli/logs/notifications');

    @override
    void defineRoute(FluroRouter router) => super.noParameterRouteDefinition(router, _TautulliLogsNotificationsRoute());
}

class _TautulliLogsNotificationsRoute extends StatefulWidget {
    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<_TautulliLogsNotificationsRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();

    Future<void> _refresh() async {
        context.read<TautulliState>().resetNotificationLogs();
        await context.read<TautulliState>().notificationLogs;
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

    Widget get _appBar => LunaAppBar(title: 'Notification Logs');

    Widget get _body => LSRefreshIndicator(
        onRefresh: _refresh,
        refreshKey: _refreshKey,
        child: Selector<TautulliState, Future<TautulliNotificationLogs>>(
            selector: (_, state) => state.notificationLogs,
            builder: (context, logs, _) => FutureBuilder(
                future: logs,
                builder: (context, AsyncSnapshot<TautulliNotificationLogs> snapshot) {
                    if(snapshot.hasError) {
                        if(snapshot.connectionState != ConnectionState.waiting) {
                            LunaLogger().error('Unable to fetch Tautulli notification logs', snapshot.error, snapshot.stackTrace);
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
