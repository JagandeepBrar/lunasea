import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class SyncedItemsRoute extends StatefulWidget {
  const SyncedItemsRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<SyncedItemsRoute> createState() => _State();
}

class _State extends State<SyncedItemsRoute>
    with LunaScrollControllerMixin, LunaLoadCallbackMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  Future<void> loadCallback() async {
    context.read<TautulliState>().resetSyncedItems();
    await context.read<TautulliState>().syncedItems;
  }

  @override
  Widget build(BuildContext context) {
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      module: LunaModule.TAUTULLI,
      appBar: _appBar() as PreferredSizeWidget?,
      body: _body(),
    );
  }

  Widget _appBar() {
    return LunaAppBar(
      title: 'Synced Items',
      scrollControllers: [scrollController],
    );
  }

  Widget _body() {
    return LunaRefreshIndicator(
      context: context,
      key: _refreshKey,
      onRefresh: loadCallback,
      child: Selector<TautulliState, Future<List<TautulliSyncedItem>>?>(
        selector: (_, state) => state.syncedItems,
        builder: (context, synced, _) => FutureBuilder(
          future: synced,
          builder: (context, AsyncSnapshot<List<TautulliSyncedItem>> snapshot) {
            if (snapshot.hasError) {
              if (snapshot.connectionState != ConnectionState.waiting)
                LunaLogger().error(
                  'Unable to fetch Tautulli synced items',
                  snapshot.error,
                  snapshot.stackTrace,
                );
              return LunaMessage.error(onTap: _refreshKey.currentState!.show);
            }
            if (snapshot.hasData) return _list(snapshot.data);
            return const LunaLoader();
          },
        ),
      ),
    );
  }

  Widget _list(List<TautulliSyncedItem>? syncedItems) {
    if ((syncedItems?.length ?? 0) == 0)
      return LunaMessage(
        text: 'No Synced Items Found',
        buttonText: 'Refresh',
        onTap: _refreshKey.currentState!.show,
      );
    return LunaListViewBuilder(
      controller: scrollController,
      itemCount: syncedItems!.length,
      itemBuilder: (context, index) =>
          TautulliSyncedItemTile(syncedItem: syncedItems[index]),
    );
  }
}
