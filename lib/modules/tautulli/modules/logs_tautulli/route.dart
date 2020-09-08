import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:tautulli/tautulli.dart';

class TautulliLogsTautulliRoute extends StatefulWidget {
    static const String ROUTE_NAME = '/tautulli/logs/tautulli/:profile';

    TautulliLogsTautulliRoute({
        Key key,
    }) : super(key: key);

    @override
    State<StatefulWidget> createState() => _State();

    static String route({ String profile }) {
        if(profile == null) return '/tautulli/logs/tautulli/${LunaSeaDatabaseValue.ENABLED_PROFILE.data}';
        return '/tautulli/logs/tautulli/$profile';
    }
}

class _State extends State<TautulliLogsTautulliRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();

    Future<void> _refresh() async {
        TautulliLocalState _state = Provider.of<TautulliLocalState>(context, listen: false);
        _state.resetTautulliLogs(context);
        await _state.tautulliLogs;
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

    Widget get _appBar => LSAppBar(title: 'Tautulli Logs');

    Widget get _body => LSRefreshIndicator(
        onRefresh: _refresh,
        refreshKey: _refreshKey,
        child: Selector<TautulliLocalState, Future<List<TautulliLog>>>(
            selector: (_, state) => state.tautulliLogs,
            builder: (context, logs, _) => FutureBuilder(
                future: logs,
                builder: (context, AsyncSnapshot<List<TautulliLog>> snapshot) {
                    if(snapshot.hasError) {
                        if(snapshot.connectionState != ConnectionState.waiting) {
                            Logger.error(
                                'TautulliLogsTautulliRoute',
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
