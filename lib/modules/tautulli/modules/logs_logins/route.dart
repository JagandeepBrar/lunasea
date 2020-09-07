import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:tautulli/tautulli.dart';

class TautulliLogsLoginsRoute extends StatefulWidget {
    static const String ROUTE_NAME = '/:profile/tautulli/logs/logins';
    static String route({
        String profile,
    }) => profile == null
        ? '/${LunaSeaDatabaseValue.ENABLED_PROFILE.data}/tautulli/logs/logins'
        : '/$profile/tautulli/logs/logins';

    TautulliLogsLoginsRoute({
        Key key,
    }) : super(key: key);

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<TautulliLogsLoginsRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();

    Future<void> _refresh() async {
        TautulliLocalState _state = Provider.of<TautulliLocalState>(context, listen: false);
        _state.resetLoginLogs(context);
        await _state.loginLogs;
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

    Widget get _appBar => LSAppBar(title: 'Login Logs');

    Widget get _body => LSRefreshIndicator(
        onRefresh: _refresh,
        refreshKey: _refreshKey,
        child: Selector<TautulliLocalState, Future<TautulliUserLogins>>(
            selector: (_, state) => state.loginLogs,
            builder: (context, logs, _) => FutureBuilder(
                future: logs,
                builder: (context, AsyncSnapshot<TautulliUserLogins> snapshot) {
                    if(snapshot.hasError) {
                        if(snapshot.connectionState != ConnectionState.waiting) {
                            Logger.error(
                                'TautulliLogsLoginsRoute',
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

    Widget _loginLogs(TautulliUserLogins logs) => LSListViewBuilder(
        itemCount: logs.logins.length,
        itemBuilder: (context, index) => TautulliLogsLoginsLogTile(login: logs.logins[index]),
    );
}
