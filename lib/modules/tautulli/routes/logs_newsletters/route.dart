import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliLogsNewslettersRouter extends TautulliPageRouter {
    TautulliLogsNewslettersRouter() : super('/tautulli/logs/newsletters');

    @override
    void defineRoute(FluroRouter router) => super.noParameterRouteDefinition(router, _TautulliLogsNewslettersRoute());
}

class _TautulliLogsNewslettersRoute extends StatefulWidget {
    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<_TautulliLogsNewslettersRoute> with LunaScrollControllerMixin {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();

    @override
    Widget build(BuildContext context) {
        return ChangeNotifierProvider(
            create: (context) => TautulliLogsNewslettersState(context),
            builder: (context, _) => Scaffold(
                key: _scaffoldKey,
                appBar: _appBar(),
                body: _body(context),
            ),
        );
    }

    Widget _appBar() {
        return LunaAppBar(
            title: 'Newsletter Logs',
            scrollControllers: [scrollController],
        );
    }

    Widget _body(BuildContext context) {
        return LunaRefreshIndicator(
            context: context,
            key: _refreshKey,
            onRefresh: () async => context.read<TautulliLogsNewslettersState>().fetchLogs(context),
            child: FutureBuilder(
                future: context.select((TautulliLogsNewslettersState state) => state.logs),
                builder: (context, AsyncSnapshot<TautulliNewsletterLogs> snapshot) {
                    if(snapshot.hasError) {
                        if(snapshot.connectionState != ConnectionState.waiting) LunaLogger().error(
                            'Unable to fetch Tautulli newsletter logs',
                            snapshot.error,
                            snapshot.stackTrace,
                        );
                        return LunaMessage.error(onTap: _refreshKey.currentState?.show);
                    }
                    if(snapshot.hasData) return _logs(snapshot.data);
                    return LunaLoader();
                },
            ),
        );
    }

    Widget _logs(TautulliNewsletterLogs logs) {
        if((logs?.logs?.length ?? 0) == 0) return LunaMessage(
            text: 'No Logs Found',
            buttonText: 'Refresh',
            onTap: _refreshKey.currentState?.show,
        );
        return LunaListViewBuilder(
            controller: scrollController,
            itemCount: logs.logs.length,
            itemBuilder: (context, index) => TautulliLogsNewsletterLogTile(newsletter: logs.logs[index]),
        );
    }
}
