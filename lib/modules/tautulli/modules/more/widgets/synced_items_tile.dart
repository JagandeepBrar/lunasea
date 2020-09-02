import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliMoreSyncedItemsTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: 'Synced Items'),
        subtitle: LSSubtitle(text: 'Synced Content on Devices'),
        trailing: LSIconButton(
            icon: Icons.sync,
            color: LSColors.list(5),
        ),
        onTap: () async => _onTap(context),
    );

    Future<void> _onTap(BuildContext context) async => Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => ChangeNotifierProvider.value(
            value: Provider.of<TautulliLocalState>(context, listen: false),
            child: TautulliSyncedItemsRoute(),
        )),
    );
}
