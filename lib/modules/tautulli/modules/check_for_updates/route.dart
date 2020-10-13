import 'package:fluro_fork/fluro_fork.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:tautulli/tautulli.dart';

class TautulliCheckForUpdatesRouter {
    static const ROUTE_NAME = '/tautulli/more/checkforupdates';

    static Future<void> navigateTo(BuildContext context) async => LunaRouter.router.navigateTo(
        context,
        route(),
    );

    static String route() => ROUTE_NAME;

    static void defineRoutes(Router router) {
        router.define(
            ROUTE_NAME,
            handler: Handler(handlerFunc: (context, params) => _TautulliCheckForUpdatesRoute()),
            transitionType: LunaRouter.transitionType,
        );
    }

    TautulliCheckForUpdatesRouter._();
}

class _TautulliCheckForUpdatesRoute extends StatefulWidget {
    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<_TautulliCheckForUpdatesRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();
    bool _initialLoad = false;

    Future<void> _refresh() async {
        context.read<TautulliState>().resetAllUpdates();
        setState(() => _initialLoad = true);
        await Future.wait([
            context.read<TautulliState>().updatePlexMediaServer,
            context.read<TautulliState>().updateTautulli,
        ]);
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
        body: _initialLoad ? _body : LSLoader(),
    );

    Widget get _appBar => LunaAppBar(
        context: context,
        title: 'Check for Updates',
        popUntil: '/tautulli',
    );

    Widget get _body => LSRefreshIndicator(
        refreshKey: _refreshKey,
        onRefresh: _refresh,
        child: FutureBuilder(
            future: Future.wait([
                context.watch<TautulliState>().updatePlexMediaServer,
                context.watch<TautulliState>().updateTautulli,
            ]),
            builder: (context, AsyncSnapshot<List<Object>> snapshot) {
                if(snapshot.hasError) {
                        if(snapshot.connectionState != ConnectionState.waiting) {
                            LunaLogger.error(
                                '_TautulliCheckForUpdatesRoute',
                                '_body',
                                'Unable to fetch updates',
                                snapshot.error,
                                null,
                                uploadToSentry: !(snapshot.error is DioError),
                            );
                        }
                        return LSErrorMessage(onTapHandler: () async => _refreshKey.currentState.show());
                    }
                    if(snapshot.hasData) return _list(
                        pms: snapshot.data[0],
                        tautulli: snapshot.data[1],
                    );
                    return LSLoader();
            },
        ),
    );

    Widget _list({
        @required TautulliPMSUpdate pms,
        @required TautulliUpdateCheck tautulli,
    }) => LSListView(
        children: [
            TautulliCheckForUpdatesPMSTile(update: pms),
            TautulliCheckForUpdatesTautulliTile(update: tautulli),
        ],
    );
}
