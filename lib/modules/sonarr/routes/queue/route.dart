import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrQueueRouter extends SonarrPageRouter {
  SonarrQueueRouter() : super('/sonarr/queue');

  @override
  _Widget widget() => _Widget();

  @override
  void defineRoute(FluroRouter router) {
    super.noParameterRouteDefinition(router);
  }
}

class _Widget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<_Widget> with LunaScrollControllerMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SonarrQueueState(context),
      builder: (context, _) => LunaScaffold(
        scaffoldKey: _scaffoldKey,
        appBar: _appBar() as PreferredSizeWidget?,
        body: _body(context),
      ),
    );
  }

  Future<void> _onRefresh(BuildContext context) async {
    await context.read<SonarrQueueState>().fetchQueue(
          context,
          hardCheck: true,
        );
    await context.read<SonarrQueueState>().queue;
  }

  Widget _appBar() {
    return LunaAppBar(
      title: 'sonarr.Queue'.tr(),
      scrollControllers: [scrollController],
    );
  }

  Widget _body(BuildContext context) {
    return LunaRefreshIndicator(
      key: _refreshKey,
      context: context,
      onRefresh: () async => _onRefresh(context),
      child: FutureBuilder(
        future: context.watch<SonarrQueueState>().queue,
        builder: (context, AsyncSnapshot<SonarrQueue> snapshot) {
          if (snapshot.hasError) {
            if (snapshot.connectionState != ConnectionState.waiting) {
              LunaLogger().error(
                'Unable to fetch Sonarr queue',
                snapshot.error,
                snapshot.stackTrace,
              );
            }
            return LunaMessage.error(
              onTap: _refreshKey.currentState!.show,
            );
          }
          if (snapshot.hasData) {
            return _list(snapshot.data!);
          }
          return const LunaLoader();
        },
      ),
    );
  }

  Widget _list(SonarrQueue queue) {
    if (queue.records!.isEmpty) {
      return LunaMessage(
        text: 'sonarr.EmptyQueue'.tr(),
        buttonText: 'lunasea.Refresh'.tr(),
        onTap: _refreshKey.currentState!.show,
      );
    }
    return LunaListViewBuilder(
      controller: scrollController,
      itemCount: queue.records!.length,
      itemBuilder: (context, index) => SonarrQueueTile(
        key: ObjectKey(queue.records![index].id),
        queueRecord: queue.records![index],
        type: SonarrQueueTileType.ALL,
      ),
    );
  }
}
