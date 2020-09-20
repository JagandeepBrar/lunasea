import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliLogsPlexMediaServerTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: 'Plex Media Server'),
        subtitle: LSSubtitle(text: 'Plex Media Server Logs'),
        trailing: LSIconButton(
            icon: CustomIcons.plex,
            color: LSColors.list(4),
        ),
        onTap: () async => _onTap(context),
    );

    Future<void> _onTap(BuildContext context) async => TautulliLogsPlexMediaServerRouter.navigateTo(context);
}
