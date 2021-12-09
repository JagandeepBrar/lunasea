import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliLogsLoginsLogTile extends StatelessWidget {
  final TautulliUserLoginRecord login;

  const TautulliLogsLoginsLogTile({
    Key key,
    @required this.login,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaListTile(
      context: context,
      title: LunaText.title(text: login.friendlyName),
      subtitle: _subtitle(),
      trailing: _trailing(),
      contentPadding: true,
      height: LunaListTile.itemHeightExtended(4),
    );
  }

  Widget _subtitle() {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
          color: Colors.white70,
          fontSize: LunaUI.FONT_SIZE_SUBTITLE,
        ),
        children: [
          TextSpan(text: '${login.ipAddress}\n'),
          TextSpan(text: '${login.os}\n'),
          TextSpan(text: '${login.host}\n'),
          TextSpan(
            text: LunaDatabaseValue.USE_24_HOUR_TIME.data
                ? DateFormat('MMMM dd, yyyy ${LunaUI.TEXT_EMDASH} HH:mm')
                    .format(login.timestamp)
                : DateFormat('MMMM dd, yyyy ${LunaUI.TEXT_EMDASH} hh:mm a')
                    .format(login.timestamp),
            style: const TextStyle(
              color: LunaColours.accent,
              fontWeight: LunaUI.FONT_WEIGHT_BOLD,
            ),
          ),
        ],
      ),
      softWrap: false,
      overflow: TextOverflow.fade,
      maxLines: 5,
    );
  }

  Widget _trailing() {
    return Column(
      children: [
        LunaIconButton(
          icon:
              login.success ? Icons.check_circle_rounded : Icons.cancel_rounded,
          color: login.success ? Colors.white : LunaColours.red,
        ),
      ],
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }
}
