import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class TautulliLogsPlexMediaScannerTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: 'Plex Media Scanner'),
        subtitle: LSSubtitle(text: 'Plex Media Scanner Logs'),
        leading: LSIconButton(
            icon: Icons.scanner,
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
