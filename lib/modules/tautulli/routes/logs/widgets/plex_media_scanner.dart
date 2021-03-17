import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliLogsPlexMediaScannerTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: 'Plex Media Scanner'),
        subtitle: LSSubtitle(text: 'Plex Media Scanner Logs'),
        trailing: LSIconButton(
            icon: Icons.scanner,
            color: LunaColours.list(3),
        ),
        onTap: () async => _onTap(context),
    );

    Future<void> _onTap(BuildContext context) async => TautulliLogsPlexMediaScannerRouter().navigateTo(context);
}
