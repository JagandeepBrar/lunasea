import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:tautulli/tautulli.dart';

class TautulliSyncedItemTile extends StatelessWidget {
    final TautulliSyncedItem syncedItem;

    TautulliSyncedItemTile({
        Key key,
        @required this.syncedItem,
    }): super(key: key);

    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: syncedItem.syncTitle),
    );
}
