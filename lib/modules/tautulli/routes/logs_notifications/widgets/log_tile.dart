import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliLogsNotificationLogTile extends StatelessWidget {
  final TautulliNotificationLogRecord notification;

  const TautulliLogsNotificationLogTile({
    Key key,
    @required this.notification,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaListTile(
      context: context,
      title: LunaText.title(text: notification.agentName),
      subtitle: _subtitle(),
      trailing: _trailing(),
      contentPadding: true,
      height: LunaListTile.itemHeightExtended(4),
    );
  }

  Widget _subtitle() => RichText(
        text: TextSpan(
          style: const TextStyle(
            color: Colors.white70,
            fontSize: LunaUI.FONT_SIZE_SUBTITLE,
          ),
          children: [
            TextSpan(text: '${notification.notifyAction}\n'),
            TextSpan(text: '${notification.subjectText}\n'),
            TextSpan(text: '${notification.bodyText}\n'),
            TextSpan(
              text: LunaDatabaseValue.USE_24_HOUR_TIME.data
                  ? DateFormat('MMMM dd, yyyy ${LunaUI.TEXT_EMDASH} HH:mm')
                      .format(notification.timestamp)
                  : DateFormat('MMMM dd, yyyy ${LunaUI.TEXT_EMDASH} hh:mm a')
                      .format(notification.timestamp),
              style: const TextStyle(
                color: LunaColours.accent,
                fontWeight: LunaUI.FONT_WEIGHT_BOLD,
              ),
            ),
          ],
        ),
        softWrap: false,
        overflow: TextOverflow.fade,
        maxLines: 4,
      );

  Widget _trailing() => Column(
        children: [
          LunaIconButton(
            icon: notification.success
                ? Icons.check_circle_rounded
                : Icons.cancel_rounded,
            color: notification.success ? Colors.white : LunaColours.red,
          ),
        ],
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
      );
}
