import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class TautulliLogsNotificationsTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: 'Notifications'),
        subtitle: LSSubtitle(text: 'Tautulli Notification Logs'),
        leading: LSIconButton(
            icon: Icons.notifications,
            color: LSColors.list(4),
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
