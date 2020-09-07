import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliLogsNotificationsTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: 'Notifications'),
        subtitle: LSSubtitle(text: 'Tautulli Notification Logs'),
        trailing: LSIconButton(
            icon: Icons.notifications,
            color: LSColors.list(4),
        ),
        onTap: () async => _onTap(context),
    );

    Future<void> _onTap(BuildContext context) async => TautulliRouter.router.navigateTo(
        context,
        TautulliLogsNotificationsRoute.route(),
    );
}
