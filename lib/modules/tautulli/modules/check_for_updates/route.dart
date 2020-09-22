import 'package:fluro_fork/fluro_fork.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:tautulli/tautulli.dart';

class TautulliCheckForUpdatesRouter {
    static const ROUTE_NAME = '/tautulli/more/checkforupdates';

    static Future<void> navigateTo(BuildContext context) async => TautulliRouter.router.navigateTo(
        context,
        route(),
    );

    static String route({ String profile }) => [
        ROUTE_NAME,
        if(profile != null) '/$profile',
    ].join();

    static void defineRoutes(Router router) {
        router.define(
            ROUTE_NAME + '/:profile',
            handler: Handler(handlerFunc: (context, params) => _TautulliCheckForUpdatesRoute(
                profile: params['profile'] != null && params['profile'].length != 0
                    ? params['profile'][0]
                    : null,
            )),
            transitionType: LunaRouter.transitionType,
        );
        router.define(
            ROUTE_NAME,
            handler: Handler(handlerFunc: (context, params) => _TautulliCheckForUpdatesRoute(
                profile: null,
            )),
            transitionType: LunaRouter.transitionType,
        );
    }

    TautulliCheckForUpdatesRouter._();
}

class _TautulliCheckForUpdatesRoute extends StatefulWidget {
    final String profile;

    _TautulliCheckForUpdatesRoute({
        Key key,
        @required this.profile,
    }) : super(key: key);

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<_TautulliCheckForUpdatesRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();
    bool _initialLoad = false;

    Future<void> _refresh() async {
        TautulliLocalState _local = Provider.of<TautulliLocalState>(context, listen: false);
        _local.resetAllUpdates(context);
        setState(() => _initialLoad = true);
        await Future.wait([
            _local.updatePlexMediaServer,
            _local.updateTautulli,
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

    Widget get _appBar => LSAppBar(title: 'Check for Updates');

    Widget get _body => LSRefreshIndicator(
        refreshKey: _refreshKey,
        onRefresh: _refresh,
        child: FutureBuilder(
            future: Future.wait([
                Provider.of<TautulliLocalState>(context).updatePlexMediaServer,
                Provider.of<TautulliLocalState>(context).updateTautulli,
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
