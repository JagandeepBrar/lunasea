import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class TautulliMoreSyncedItemsTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: 'Synced Items'),
        subtitle: LSSubtitle(text: 'Synced Content on Devices'),
        leading: LSIconButton(
            icon: Icons.sync,
            color: LSColors.list(5),
        ),
        onTap: () async => _onTap(context),
    );

    Future<void> _onTap(BuildContext context) async => LSSnackBar(
        context: context,
        title: 'Coming Soon!',
        message: 'This feature has not yet been implemented',
        type: SNACKBAR_TYPE.info,
    );
}
