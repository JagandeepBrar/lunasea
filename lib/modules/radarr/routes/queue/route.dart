import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrQueueRouter extends RadarrPageRouter {
  RadarrQueueRouter() : super('/radarr/queue');

  @override
  Widget widget() => _Widget();

  @override
  void defineRoute(FluroRouter router) {
    super.noParameterRouteDefinition(router);
  }
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
  Widget build(BuildContext context) {
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      appBar: _appBar(),
      body: _body(),
    );
  }

  @override
  Future<void> loadCallback() async {
    if (context.read<RadarrState>().enabled) {
      await context.read<RadarrState>().api.command.refreshMonitoredDownloads();
      context.read<RadarrState>().fetchQueue();
      await context.read<RadarrState>().queue;
    }
  }

  Widget _appBar() {
    return LunaAppBar(
      title: 'radarr.Queue'.tr(),
      scrollControllers: [scrollController],
    );
  }

  Widget _body() {
    return LunaRefreshIndicator(
      key: _refreshKey,
      context: context,
      onRefresh: loadCallback,
      child: FutureBuilder(
        future: Future.wait([
          context.select((RadarrState state) => state.queue),
          context.select((RadarrState state) => state.movies),
        ]),
        builder: (context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasError) {
            if (snapshot.connectionState != ConnectionState.waiting) {
              LunaLogger().error(
                'Unable to fetch Radarr queue',
                snapshot.error,
                snapshot.stackTrace,
              );
            }
            return LunaMessage.error(onTap: _refreshKey.currentState?.show);
          }
          if (snapshot.hasData) {
            return _list(
              snapshot.data[0],
              snapshot.data[1],
            );
          }
          return const LunaLoader();
        },
      ),
    );
  }

  Widget _list(RadarrQueue queue, List<RadarrMovie> movies) {
    if ((queue?.records?.length ?? 0) == 0) {
      return LunaMessage(
        text: 'Empty Queue',
        buttonText: 'lunasea.Refresh'.tr(),
        onTap: _refreshKey.currentState?.show,
      );
    }
    return LunaListViewBuilder(
      controller: scrollController,
      itemCount: queue.records.length,
      itemBuilder: (context, index) {
        RadarrMovie movie = movies.firstWhere(
          (movie) => movie.id == queue.records[index].movieId,
          orElse: () => null,
        );
        return RadarrQueueTile(
          record: queue.records[index],
          movie: movie,
        );
      },
    );
  }
}
