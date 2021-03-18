import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:tautulli/tautulli.dart';

class TautulliCheckForUpdatesRouter extends TautulliPageRouter {
    TautulliCheckForUpdatesRouter() : super('/tautulli/more/checkforupdates');

    @override
    void defineRoute(FluroRouter router) => super.noParameterRouteDefinition(router, _TautulliCheckForUpdatesRoute());
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

    Widget get _appBar => LunaAppBar(title: 'Check for Updates');

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
                            LunaLogger().error('Unable to fetch updates', snapshot.error, StackTrace.current);
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
