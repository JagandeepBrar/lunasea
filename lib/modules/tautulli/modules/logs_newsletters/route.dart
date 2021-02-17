import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:tautulli/tautulli.dart';

class TautulliLogsNewslettersRouter {
    static const String ROUTE_NAME = '/tautulli/logs/newsletters';

    static Future<void> navigateTo(BuildContext context) async => LunaRouter.router.navigateTo(
        context,
        route(),
    );

    static String route() => ROUTE_NAME;

    static void defineRoutes(FluroRouter router) {
        router.define(
            ROUTE_NAME,
            handler: Handler(handlerFunc: (context, params) => _TautulliLogsNewslettersRoute()),
            transitionType: LunaRouter.transitionType,
        );
    }

    TautulliLogsNewslettersRouter._();
}

class _TautulliLogsNewslettersRoute extends StatefulWidget {
    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<_TautulliLogsNewslettersRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();

    Future<void> _refresh() async {
        context.read<TautulliState>().resetNewsletterLogs();
        await context.read<TautulliState>().newsletterLogs;
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

    Widget get _appBar => LunaAppBar(title: 'Newsletter Logs');

    Widget get _body => LSRefreshIndicator(
        onRefresh: _refresh,
        refreshKey: _refreshKey,
        child: Selector<TautulliState, Future<TautulliNewsletterLogs>>(
            selector: (_, state) => state.newsletterLogs,
            builder: (context, logs, _) => FutureBuilder(
                future: logs,
                builder: (context, AsyncSnapshot<TautulliNewsletterLogs> snapshot) {
                    if(snapshot.hasError) {
                        if(snapshot.connectionState != ConnectionState.waiting) {
                            LunaLogger().error('Unable to fetch Tautulli newsletter logs', snapshot.error, StackTrace.current);
                        }
                        return LSErrorMessage(onTapHandler: () async => _refreshKey.currentState.show());
                    }
                    if(snapshot.hasData) return snapshot.data.logs.length == 0
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

    Widget _logs(TautulliNewsletterLogs logs) => LSListViewBuilder(
        itemCount: logs.logs.length,
        itemBuilder: (context, index) => TautulliLogsNewsletterLogTile(newsletter: logs.logs[index]),
    );
}
