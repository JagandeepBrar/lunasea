import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lunasea/core.dart';
import 'package:tautulli/tautulli.dart';

class TautulliLogsNotificationLogTile extends StatelessWidget {
    final TautulliNotificationLogRecord notification;

    TautulliLogsNotificationLogTile({
        Key key,
        @required this.notification,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: notification.agentName),
        subtitle: _subtitle,
        trailing: _trailing,
        padContent: true,
    );

    Widget get _subtitle => RichText(
        text: TextSpan(
            style: TextStyle(
                color: Colors.white70,
                fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
            ),
            children: [
                TextSpan(text: '${notification.notifyAction}\n'),
                TextSpan(text: '${notification.subjectText}\n'),
                TextSpan(text: '${notification.bodyText}\n'),
                TextSpan(
                    text: LunaSeaDatabaseValue.USE_24_HOUR_TIME.data
                        ? DateFormat('MMMM dd, yyyy ${Constants.TEXT_EMDASH} HH:mm').format(notification.timestamp)
                        : DateFormat('MMMM dd, yyyy ${Constants.TEXT_EMDASH} KK:mm a').format(notification.timestamp),
                    style: TextStyle(
                        color: LunaColours.accent,
                        fontWeight: FontWeight.w600,
                    ),
                ),
            ],
        ),
        softWrap: false,
        overflow: TextOverflow.fade,
        maxLines: 4,
    );

    Widget get _trailing => Column(
        children: [
            LSIconButton(
                icon: notification.success ? Icons.check_circle : Icons.cancel,
                color: notification.success ? Colors.white : LunaColours.red,
            ),
        ],
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
    );
}
