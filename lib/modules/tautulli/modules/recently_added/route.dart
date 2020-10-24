import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:tautulli/tautulli.dart';

class TautulliRecentlyAddedRouter {
    static const String ROUTE_NAME = '/tautulli/recentlyadded/list';

    static Future<void> navigateTo(BuildContext context) async => LunaRouter.router.navigateTo(
        context,
        route(),
    );

    static String route() => ROUTE_NAME;

    static void defineRoutes(FluroRouter router) {
        router.define(
            ROUTE_NAME,
            handler: Handler(handlerFunc: (context, params) => _TautulliRecentlyAddedRoute()),
            transitionType: LunaRouter.transitionType,
        );
    }

    TautulliRecentlyAddedRouter._();
}

class _TautulliRecentlyAddedRoute extends StatefulWidget {
    @override
    State<_TautulliRecentlyAddedRoute> createState() => _State();
}

class _State extends State<_TautulliRecentlyAddedRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();

    Future<void> _refresh() async {
        context.read<TautulliState>().resetRecentlyAdded();
        await context.read<TautulliState>().recentlyAdded;
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
        title: 'Recently Added',
        popUntil: '/tautulli',
    );

    Widget get _body => LSRefreshIndicator(
        refreshKey: _refreshKey,
        onRefresh: _refresh,
        child: Selector<TautulliState, Future<List<TautulliRecentlyAdded>>>(
            selector: (_, state) => state.recentlyAdded,
            builder: (context, stats, _) => FutureBuilder(
                future: stats,
                builder: (context, AsyncSnapshot<List<TautulliRecentlyAdded>> snapshot) {
                    if(snapshot.hasError) {
                        if(snapshot.connectionState != ConnectionState.waiting) {
                            LunaLogger.error(
                                '_TautulliRecentlyAddedRoute',
                                '_body',
                                'Unable to fetch Tautulli recently added',
                                snapshot.error,
                                StackTrace.current,
                                uploadToSentry: !(snapshot.error is DioError),
                            );
                        }
                        return LSErrorMessage(onTapHandler: () async => _refreshKey.currentState.show());
                    }
                    if(snapshot.hasData) return snapshot.data.length == 0
                        ? _noRecentlyAdded()
                        : _recentlyAdded(snapshot.data);
                    return LSLoader();
                },
            ),
        ),
    );

    Widget _noRecentlyAdded() => LSGenericMessage(
        text: 'No Statistics Found',
        showButton: true,
        buttonText: 'Refresh',
        onTapHandler: () async => _refreshKey.currentState.show(),
    );

    Widget _recentlyAdded(List<TautulliRecentlyAdded> added) => LSListViewBuilder(
        itemCount: added.length,
        itemBuilder: (context, index) => TautulliRecentlyAddedContentTile(recentlyAdded: added[index]),
    );
}