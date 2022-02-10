import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/readarr.dart';

class ReadarrQueueRouter extends ReadarrPageRouter {
  ReadarrQueueRouter() : super('/readarr/queue');

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
      create: (context) => ReadarrQueueState(context),
      builder: (context, _) => LunaScaffold(
        scaffoldKey: _scaffoldKey,
        appBar: _appBar() as PreferredSizeWidget?,
        body: _body(context),
      ),
    );
  }

  Future<void> _onRefresh(BuildContext context) async {
    await context.read<ReadarrQueueState>().fetchQueue(
          context,
          hardCheck: true,
        );
    await context.read<ReadarrQueueState>().queue;
  }

  Widget _appBar() {
    return LunaAppBar(
      title: 'readarr.Queue'.tr(),
      scrollControllers: [scrollController],
    );
  }

  Widget _body(BuildContext context) {
    return LunaRefreshIndicator(
      key: _refreshKey,
      context: context,
      onRefresh: () async => _onRefresh(context),
      child: FutureBuilder(
        future: context.watch<ReadarrQueueState>().queue,
        builder: (context, AsyncSnapshot<ReadarrQueue> snapshot) {
          if (snapshot.hasError) {
            if (snapshot.connectionState != ConnectionState.waiting) {
              LunaLogger().error(
                'Unable to fetch Readarr queue',
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

  Widget _list(ReadarrQueue queue) {
    if (queue.records!.isEmpty) {
      return LunaMessage(
        text: 'readarr.EmptyQueue'.tr(),
        buttonText: 'lunasea.Refresh'.tr(),
        onTap: _refreshKey.currentState!.show,
      );
    }
    return LunaListViewBuilder(
      controller: scrollController,
      itemCount: queue.records!.length,
      itemBuilder: (context, index) => ReadarrQueueTile(
        key: ObjectKey(queue.records![index].id),
        queueRecord: queue.records![index],
        type: ReadarrQueueTileType.ALL,
      ),
    );
  }
}
