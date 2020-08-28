import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class TautulliLogsPlexMediaServerTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: 'Plex Media Server'),
        subtitle: LSSubtitle(text: 'Plex Media Server Logs'),
        trailing: LSIconButton(
            icon: CustomIcons.plex,
            color: LSColors.list(1),
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
