import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliCheckForUpdatesRouter extends TautulliPageRouter {
    TautulliCheckForUpdatesRouter() : super('/tautulli/more/checkforupdates');

    @override
    void defineRoute(FluroRouter router) => super.noParameterRouteDefinition(router, _TautulliCheckForUpdatesRoute());
}

class _TautulliCheckForUpdatesRoute extends StatefulWidget {
    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<_TautulliCheckForUpdatesRoute> with LunaScrollControllerMixin {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();

    @override
    Widget build(BuildContext context) {
        return ChangeNotifierProvider(
            create: (context) => TautulliCheckForUpdatesState(context),
            builder: (context, _) =>  LunaScaffold(
                scaffoldKey: _scaffoldKey,
                appBar: _appBar(),
                body: _body(context),
            ),
        );
    }

    Widget _appBar() {
        return LunaAppBar(
            title: 'Check for Updates',
            scrollControllers: [scrollController],
        );
    }

    Widget _body(BuildContext context) {
        return LunaRefreshIndicator(
            context: context,
            key: _refreshKey,
            onRefresh: () async => context.read<TautulliCheckForUpdatesState>().fetchAllUpdates(context),
            child: FutureBuilder(
                future: Future.wait([
                    context.watch<TautulliCheckForUpdatesState>().plexMediaServer,
                    context.watch<TautulliCheckForUpdatesState>().tautulli,
                ]),
                builder: (context, AsyncSnapshot<List<Object>> snapshot) {
                    if(snapshot.hasError) {
                            if(snapshot.connectionState != ConnectionState.waiting) LunaLogger().error(
                                'Unable to fetch updates',
                                snapshot.error,
                                snapshot.stackTrace,
                            );
                            return LunaMessage.error(onTap: _refreshKey.currentState.show);
                        }
                        if(snapshot.hasData) return _list(snapshot.data[0], snapshot.data[1]);
                        return LunaLoader();
                },
            ),
        );
    }

    Widget _list(TautulliPMSUpdate pms, TautulliUpdateCheck tautulli) {
        return LunaListView(
            controller: scrollController,
            children: [
                TautulliCheckForUpdatesPMSTile(update: pms),
                TautulliCheckForUpdatesTautulliTile(update: tautulli),
            ],
        );
    }
}
