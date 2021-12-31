import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliLogsTautulliRouter extends TautulliPageRouter {
  TautulliLogsTautulliRouter() : super('/tautulli/logs/tautulli');

  @override
  _Widget widget() => _Widget();

  @override
  void defineRoute(FluroRouter router) =>
      super.noParameterRouteDefinition(router);
}

class _Widget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<_Widget> with LunaScrollControllerMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TautulliLogsTautulliState(context),
      builder: (context, _) => LunaScaffold(
        scaffoldKey: _scaffoldKey,
        appBar: _appBar() as PreferredSizeWidget?,
        body: _body(context),
      ),
    );
  }

  Widget _appBar() {
    return LunaAppBar(
      title: 'Plex Media Server Logs',
      scrollControllers: [scrollController],
    );
  }

  Widget _body(BuildContext context) {
    return LunaRefreshIndicator(
      context: context,
      key: _refreshKey,
      onRefresh: () async =>
          context.read<TautulliLogsTautulliState>().fetchLogs(context),
      child: FutureBuilder(
        future: context.select((TautulliLogsTautulliState state) => state.logs),
        builder: (context, AsyncSnapshot<List<TautulliLog>> snapshot) {
          if (snapshot.hasError) {
            if (snapshot.connectionState != ConnectionState.waiting)
              LunaLogger().error(
                'Unable to fetch Tautulli logs',
                snapshot.error,
                snapshot.stackTrace,
              );
            return LunaMessage.error(onTap: _refreshKey.currentState!.show);
          }
          if (snapshot.hasData) return _logs(snapshot.data);
          return const LunaLoader();
        },
      ),
    );
  }

  Widget _logs(List<TautulliLog>? logs) {
    if ((logs?.length ?? 0) == 0)
      return LunaMessage(
        text: 'No Logs Found',
        buttonText: 'Refresh',
        onTap: _refreshKey.currentState?.show,
      );
    return LunaListViewBuilder(
      controller: scrollController,
      itemCount: logs!.length,
      itemBuilder: (context, index) =>
          TautulliLogsTautulliLogTile(log: logs[index]),
    );
  }
}
