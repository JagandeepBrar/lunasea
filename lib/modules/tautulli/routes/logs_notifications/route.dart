import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliLogsNotificationsRouter extends TautulliPageRouter {
  TautulliLogsNotificationsRouter() : super('/tautulli/logs/notifications');

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
      create: (context) => TautulliLogsNotificationsState(context),
      builder: (context, _) => LunaScaffold(
        scaffoldKey: _scaffoldKey,
        appBar: _appBar() as PreferredSizeWidget?,
        body: _body(context),
      ),
    );
  }

  Widget _appBar() {
    return LunaAppBar(
      title: 'Notification Logs',
      scrollControllers: [scrollController],
    );
  }

  Widget _body(BuildContext context) {
    return LunaRefreshIndicator(
      context: context,
      key: _refreshKey,
      onRefresh: () async =>
          context.read<TautulliLogsNotificationsState>().fetchLogs(context),
      child: FutureBuilder(
        future: context
            .select((TautulliLogsNotificationsState state) => state.logs),
        builder: (context, AsyncSnapshot<TautulliNotificationLogs> snapshot) {
          if (snapshot.hasError) {
            if (snapshot.connectionState != ConnectionState.waiting)
              LunaLogger().error(
                'Unable to fetch Tautulli notification logs',
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

  Widget _logs(TautulliNotificationLogs? logs) {
    if ((logs?.logs?.length ?? 0) == 0)
      return LunaMessage(
        text: 'No Logs Found',
        buttonText: 'Refresh',
        onTap: _refreshKey.currentState?.show,
      );
    return LunaListViewBuilder(
      controller: scrollController,
      itemCount: logs!.logs!.length,
      itemBuilder: (context, index) =>
          TautulliLogsNotificationLogTile(notification: logs.logs![index]),
    );
  }
}
