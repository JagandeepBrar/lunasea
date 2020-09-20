import 'package:fluro_fork/fluro_fork.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:tautulli/tautulli.dart';

class TautulliRecentlyAddedRouter {
    static const String ROUTE_NAME = '/tautulli/recentlyadded/list';

    static Future<void> navigateTo(BuildContext context) async => TautulliRouter.router.navigateTo(
        context,
        route(),
    );

    static String route({
        String profile,
    }) => [
        ROUTE_NAME,
        if(profile != null) '/$profile',
    ].join();

    static void defineRoutes(Router router) {
        router.define(
            ROUTE_NAME,
            handler: Handler(handlerFunc: (context, params) => _TautulliRecentlyAddedRoute(profile: null)),
            transitionType: LunaRouter.transitionType,
        );
        router.define(
            ROUTE_NAME + '/:profile',
            handler: Handler(handlerFunc: (context, params) => _TautulliRecentlyAddedRoute(
                profile: params['profile'] != null && params['profile'].length != 0
                    ? params['profile'][0]
                    : null,
            )),
            transitionType: LunaRouter.transitionType,
        );
    }

    TautulliRecentlyAddedRouter._();
}

class _TautulliRecentlyAddedRoute extends StatefulWidget {
    final String profile;

    _TautulliRecentlyAddedRoute({
        Key key,
        @required this.profile,
    }) : super(key: key);

    @override
    State<_TautulliRecentlyAddedRoute> createState() => _State();
}

class _State extends State<_TautulliRecentlyAddedRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();

    Future<void> _refresh() async {
        TautulliLocalState _state = Provider.of<TautulliLocalState>(context, listen: false);
        _state.resetRecentlyAdded(context);
        await _state.recentlyAdded;
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

    Widget get _appBar => LSAppBar(title: 'Recently Added');

    Widget get _body => LSRefreshIndicator(
        refreshKey: _refreshKey,
        onRefresh: _refresh,
        child: Selector<TautulliLocalState, Future<List<TautulliRecentlyAdded>>>(
            selector: (_, state) => state.recentlyAdded,
            builder: (context, stats, _) => FutureBuilder(
                future: stats,
                builder: (context, AsyncSnapshot<List<TautulliRecentlyAdded>> snapshot) {
                    if(snapshot.hasError) {
                        if(snapshot.connectionState != ConnectionState.waiting) {
                            Logger.error(
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