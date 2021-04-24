import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrQueueRouter extends SonarrPageRouter {
  SonarrQueueRouter() : super('/sonarr/queue');

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

class _State extends State<_Widget>
    with LunaLoadCallbackMixin, LunaScrollControllerMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  Future<void> loadCallback() async {
    if (context.read<SonarrState>().enabled) {
      await context.read<SonarrState>().api.command.refreshMonitoredDownloads();
      context.read<SonarrState>().resetQueue();
      await context.read<SonarrState>().queue;
    }
  }

  @override
  Widget build(BuildContext context) => LunaScaffold(
        scaffoldKey: _scaffoldKey,
        appBar: _appBar(),
        body: _body(),
      );

  Widget _appBar() {
    return LunaAppBar(
      title: 'Queue',
      scrollControllers: [scrollController],
    );
  }

  Widget _body() {
    return LunaRefreshIndicator(
      context: context,
      key: _refreshKey,
      onRefresh: loadCallback,
      child: FutureBuilder(
        future: context.watch<SonarrState>().queue,
        builder: (context, AsyncSnapshot<List<SonarrQueueRecord>> snapshot) {
          if (snapshot.hasError) {
            if (snapshot.connectionState != ConnectionState.waiting) {
              LunaLogger().error('Unable to fetch Sonarr queue', snapshot.error,
                  snapshot.stackTrace);
            }
            return LunaMessage.error(onTap: _refreshKey.currentState?.show);
          }
          if (snapshot.hasData) return _queue(snapshot.data);
          return LunaLoader();
        },
      ),
    );
  }

  Widget _queue(List<SonarrQueueRecord> queue) {
    if ((queue?.length ?? 0) == 0)
      return LunaMessage(
        text: 'Empty Queue',
        buttonText: 'Refresh',
        onTap: _refreshKey.currentState.show,
      );
    return LunaListViewBuilder(
      controller: scrollController,
      itemCount: queue.length,
      itemBuilder: (context, index) => SonarrQueueQueueTile(
        key: ObjectKey(queue[index].id),
        record: queue[index],
      ),
    );
  }
}
