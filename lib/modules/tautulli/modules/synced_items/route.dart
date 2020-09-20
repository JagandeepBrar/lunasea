import 'package:fluro_fork/fluro_fork.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:tautulli/tautulli.dart';

class TautulliSyncedItemsRouter {
    static const String ROUTE_NAME = '/tautulli/synceditems/list';

    static Future<void> navigateTo(BuildContext context) async => TautulliRouter.router.navigateTo(
        context,
        route(),
    );

    static String route({ String profile }) => [
        ROUTE_NAME,
        if(profile != null) '/$profile',
    ].join();

    static void defineRoutes(Router router) {
        router.define(
            ROUTE_NAME + '/:profile',
            handler: Handler(handlerFunc: (context, params) => _TautulliSyncedItemsRoute(
                profile: params['profile'] != null && params['profile'].length != 0 ? params['profile'][0] : null,
            )),
            transitionType: LunaRouter.transitionType,
        );
        router.define(
            ROUTE_NAME,
            handler: Handler(handlerFunc: (context, params) => _TautulliSyncedItemsRoute(
                profile: null,
            )),
            transitionType: LunaRouter.transitionType,
        );
    }

    TautulliSyncedItemsRouter._();
}

class _TautulliSyncedItemsRoute extends StatefulWidget {
    final String profile;

    _TautulliSyncedItemsRoute({
        Key key,
        @required this.profile,
    }): super(key: key);

    @override
    State<_TautulliSyncedItemsRoute> createState() => _State();
}

class _State extends State<_TautulliSyncedItemsRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();

    @override
    void initState() {
        super.initState();
        SchedulerBinding.instance.addPostFrameCallback((_) => _refresh()); 
    }

    Future<void> _refresh() async {
        TautulliLocalState _state = Provider.of<TautulliLocalState>(context, listen: false);
        _state.resetSyncedItems(context);
        await _state.syncedItems;
    }

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body,
    );
    
    Widget get _appBar => LSAppBar(title: 'Synced Items');

    Widget get _body => LSRefreshIndicator(
        refreshKey: _refreshKey,
        onRefresh: _refresh,
        child: Selector<TautulliLocalState, Future<List<TautulliSyncedItem>>>(
            selector: (_, state) => state.syncedItems,
            builder: (context, synced, _) => FutureBuilder(
                future: synced,
                builder: (context, AsyncSnapshot<List<TautulliSyncedItem>> snapshot) {
                    if(snapshot.hasError) {
                        if(snapshot.connectionState != ConnectionState.waiting) {
                            Logger.error(
                                '_TautulliSyncedItemsRoute',
                                '_body',
                                'Unable to fetch Tautulli synced items',
                                snapshot.error,
                                null,
                                uploadToSentry: !(snapshot.error is DioError),
                            );
                        }
                        return LSErrorMessage(onTapHandler: () async => _refreshKey.currentState.show());
                    }
                    if(snapshot.hasData) return snapshot.data.length == 0
                        ? _noSyncedItems()
                        : _syncedItems(snapshot.data);
                    return LSLoader();
                },
            ),
        ),
    );

    Widget _syncedItems(List<TautulliSyncedItem> syncedItems) => LSListViewBuilder(
        itemCount: syncedItems.length,
        itemBuilder: (context, index) => TautulliSyncedItemTile(syncedItem: syncedItems[index]),
    );

    Widget _noSyncedItems() => LSGenericMessage(
        text: 'No Synced Items Found',
        showButton: true,
        buttonText: 'Refresh',
        onTapHandler: () async => _refreshKey.currentState.show(),
    );
}
