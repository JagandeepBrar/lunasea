import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class TautulliSyncedItemsRoute extends StatefulWidget {
    static const ROUTE_NAME = '/tautulli/synced_items';

    TautulliSyncedItemsRoute({
        Key key,
    }): super(key: key);

    @override
    State<TautulliSyncedItemsRoute> createState() => _State();
}

class _State extends State<TautulliSyncedItemsRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
    );

    Widget get _appBar => LSAppBar(title: 'Synced Items');
}
