import 'package:fluro_fork/fluro_fork.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:tautulli/tautulli.dart';

class TautulliLibrariesRoute extends StatefulWidget {
    static const String ROUTE_NAME = '/tautulli/libraries/:profile';

    TautulliLibrariesRoute({
        Key key,
    }) : super(key: key);

    @override
    State<TautulliLibrariesRoute> createState() => _State();

    static String route({ String profile }) {
        if(profile == null) return '/tautulli/libraries/${LunaSeaDatabaseValue.ENABLED_PROFILE.data}';
        return '/tautulli/libraries/$profile';
    }

    static void defineRoute(Router router) => router.define(
        TautulliLibrariesRoute.ROUTE_NAME,
        handler: Handler(handlerFunc: (context, params) => TautulliLibrariesRoute()),
        transitionType: LunaRouter.transitionType,
    );
}

class _State extends State<TautulliLibrariesRoute> {
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
                            Logger.error(
                                'TautulliLibrariesRoute',
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
