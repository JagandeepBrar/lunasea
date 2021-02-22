import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrHealthCheckRouter extends LunaPageRouter {
    RadarrHealthCheckRouter() : super('/radarr/system/health');

    @override
    void defineRoute(FluroRouter router) => super.noParameterRouteDefinition(router, _RadarrHealthCheckRoute());
}


class _RadarrHealthCheckRoute extends StatefulWidget {
    @override
    State<_RadarrHealthCheckRoute> createState() => _State();
}

class _State extends State<_RadarrHealthCheckRoute> with LunaScrollControllerMixin {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            key: _scaffoldKey,
            appBar: _appBar(),
            body: _body(),
        );
    }

    Widget _appBar() {
        return LunaAppBar(
            title: 'Health Check',
            scrollControllers: [scrollController],
        );
    }

    Widget _body() {
        return ChangeNotifierProvider(
            create: (context) => RadarrHealthCheckState(context),
            builder: (context, _) => LunaRefreshIndicator(
                context: context,
                key: _refreshKey,
                onRefresh: () async => context.read<RadarrHealthCheckState>().fetchHealthCheck(context),
                child: FutureBuilder(
                    future: context.read<RadarrHealthCheckState>().healthCheck,
                    builder: (context, AsyncSnapshot<List<RadarrHealthCheck>> snapshot) {
                        if(snapshot.hasError) {
                            LunaLogger().error('Unable to fetch Radarr health check', snapshot.error, snapshot.stackTrace);
                            return LunaMessage.error(onTap: _refreshKey.currentState.show);
                        }
                        if(snapshot.hasData) return _list(snapshot.data);
                        return LunaLoader();
                    }
                ),
            ),
        );
    }

    Widget _list(List<RadarrHealthCheck> checks) {
        if((checks?.length ?? 0) == 0) return LunaMessage(
            text: 'No Issues Found',
            buttonText: 'Refresh',
            onTap: _refreshKey.currentState.show,
        );
        return LunaListViewBuilder(
            controller: scrollController,
            itemCount: checks.length,
            itemBuilder: (context, index) => RadarrHealthCheckTile(healthCheck: checks[index]),
        );
    }
}
