import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliSyncedItemsRouter extends TautulliPageRouter {
    TautulliSyncedItemsRouter() : super('/tautulli/synceditems');

    @override
    void defineRoute(FluroRouter router) => super.noParameterRouteDefinition(router, _TautulliSyncedItemsRoute());
}

class _TautulliSyncedItemsRoute extends StatefulWidget {
    @override
    State<_TautulliSyncedItemsRoute> createState() => _State();
}

class _State extends State<_TautulliSyncedItemsRoute> with LunaScrollControllerMixin, LunaLoadCallbackMixin {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();

    Future<void> loadCallback() async {
        context.read<TautulliState>().resetSyncedItems();
        await context.read<TautulliState>().syncedItems;
    }

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
            title: 'Synced Items',
            scrollControllers: [scrollController],
        );
    }

    Widget _body() {
        return LunaRefreshIndicator(
            context: context,
            key: _refreshKey,
            onRefresh: loadCallback,
            child: Selector<TautulliState, Future<List<TautulliSyncedItem>>>(
                selector: (_, state) => state.syncedItems,
                builder: (context, synced, _) => FutureBuilder(
                    future: synced,
                    builder: (context, AsyncSnapshot<List<TautulliSyncedItem>> snapshot) {
                        if(snapshot.hasError) {
                            if(snapshot.connectionState != ConnectionState.waiting) LunaLogger().error(
                                'Unable to fetch Tautulli synced items',
                                snapshot.error,
                                snapshot.stackTrace,
                            );
                            return LunaMessage.error(onTap: _refreshKey.currentState.show);
                        }
                        if(snapshot.hasData) return _list(snapshot.data);
                        return LunaLoader();
                    },
                ),
            ),
        );
    }

    Widget _list(List<TautulliSyncedItem> syncedItems) {
        if((syncedItems?.length ?? 0) == 0) return LunaMessage(
            text: 'No Synced Items Found',
            buttonText: 'Refresh',
            onTap: _refreshKey.currentState.show,
        );
        return LunaListViewBuilder(
            controller: scrollController,
            itemCount: syncedItems.length,
            itemBuilder: (context, index) => TautulliSyncedItemTile(syncedItem: syncedItems[index]),
        );
    }
}
