import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class TautulliMoreLogsTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: 'Logs'),
        subtitle: LSSubtitle(text: 'Tautulli & Plex Logs'),
        leading: LSIconButton(
            icon: Icons.developer_mode,
            color: LSColors.list(2),
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
