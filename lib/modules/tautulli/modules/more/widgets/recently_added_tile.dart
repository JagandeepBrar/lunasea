import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class TautulliMoreRecentlyAddedTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: 'Recently Added'),
        subtitle: LSSubtitle(text: 'Recently Added Content to Plex'),
        leading: LSIconButton(
            icon: Icons.recent_actors,
            color: LSColors.list(3),
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
