import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:tautulli/tautulli.dart';

class TautulliSyncedItemsRoute extends StatefulWidget {
    static const String ROUTE_NAME = '/tautulli/synceditems/:profile';

    TautulliSyncedItemsRoute({
        Key key,
    }): super(key: key);

    @override
    State<TautulliSyncedItemsRoute> createState() => _State();

    static String route({ String profile }) {
        if(profile == null) return '/tautulli/synceditems/${LunaSeaDatabaseValue.ENABLED_PROFILE.data}';
        return '/tautulli/synceditems/$profile';
    }
}

class _State extends State<TautulliSyncedItemsRoute> {
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
                                'TautulliSyncedItemsRoute',
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
