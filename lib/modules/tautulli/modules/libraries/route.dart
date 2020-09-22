import 'package:fluro_fork/fluro_fork.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:tautulli/tautulli.dart';

class TautulliLibrariesRouter {
    static const String ROUTE_NAME = '/tautulli/libraries/list';

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
            ROUTE_NAME,
            handler: Handler(handlerFunc: (context, params) => _TautulliLibrariesRoute(
                profile: null,
            )),
            transitionType: LunaRouter.transitionType,
        );
        router.define(
            ROUTE_NAME + '/:profile',
            handler: Handler(handlerFunc: (context, params) => _TautulliLibrariesRoute(
                profile: params['profile'] != null && params['profile'].length != 0 ? params['profile'][0] : null,
            )),
            transitionType: LunaRouter.transitionType,
        );
    }

    TautulliLibrariesRouter._();
}

class _TautulliLibrariesRoute extends StatefulWidget {
    final String profile;

    _TautulliLibrariesRoute({
        Key key,
        @required this.profile,
    }) : super(key: key);

    @override
    State<_TautulliLibrariesRoute> createState() => _State();
}

class _State extends State<_TautulliLibrariesRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();

    Future<void> _refresh() async {
        TautulliLocalState _state = Provider.of<TautulliLocalState>(context, listen: false);
        _state.resetLibrariesTable(context);
        await _state.librariesTable;
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

    Widget get _appBar => LSAppBar(title: 'Libraries');

    Widget get _body => LSRefreshIndicator(
        onRefresh: _refresh,
        refreshKey: _refreshKey,
        child: Selector<TautulliLocalState, Future<TautulliLibrariesTable>>(
            selector: (_, state) => state.librariesTable,
            builder: (context, future, _) => FutureBuilder(
                future: future,
                builder: (context, AsyncSnapshot<TautulliLibrariesTable> snapshot) {
                    if(snapshot.hasError) {
                        if(snapshot.connectionState != ConnectionState.waiting) {
                            LunaLogger.error(
                                '_TautulliLibrariesRoute',
                                '_body',
                                'Unable to fetch Tautulli libraries table',
                                snapshot.error,
                                StackTrace.current,
                                uploadToSentry: !(snapshot.error is DioError),
                            );
                        }
                        return LSErrorMessage(onTapHandler: () async => _refreshKey.currentState.show());
                    }
                    if(snapshot.hasData) return snapshot.data.libraries.length == 0
                        ? _noLibraries()
                        : _libraries(snapshot.data);
                    return LSLoader();
                },
            ),
        ),
    );

    Widget _noLibraries() => LSGenericMessage(
        text: 'No Libraries Found',
        showButton: true,
        buttonText: 'Refresh',
        onTapHandler: () async => _refreshKey.currentState.show(),
    );

    Widget _libraries(TautulliLibrariesTable libraries) => LSListViewBuilder(
        itemCount: libraries.libraries.length,
        itemBuilder: (context, index) => TautulliLibrariesLibraryTile(library: libraries.libraries[index]),
    );
}
