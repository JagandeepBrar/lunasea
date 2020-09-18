import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliMoreCheckForUpdatesTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: 'Check For Updates'),
        subtitle: LSSubtitle(text: 'Tautulli & Plex Updates'),
        trailing: LSIconButton(
            icon: Icons.system_update,
            color: LSColors.list(0),
        ),
        onTap: () async => _onTap(context),
    );

    Future<void> _onTap(BuildContext context) async => TautulliCheckForUpdatesRouter.navigateTo(context: context);
}
