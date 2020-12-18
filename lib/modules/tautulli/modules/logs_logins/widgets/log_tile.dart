import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lunasea/core.dart';
import 'package:tautulli/tautulli.dart';

class TautulliLogsLoginsLogTile extends StatelessWidget {
    final TautulliUserLoginRecord login;

    TautulliLogsLoginsLogTile({
        Key key,
        @required this.login,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: login.friendlyName),
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
                TextSpan(text: '${login.ipAddress}\n'),
                TextSpan(text: '${login.os}\n'),
                TextSpan(text: '${login.host}\n'),
                TextSpan(
                    text: LunaDatabaseValue.USE_24_HOUR_TIME.data
                        ? DateFormat('MMMM dd, yyyy ${Constants.TEXT_EMDASH} HH:mm').format(login.timestamp)
                        : DateFormat('MMMM dd, yyyy ${Constants.TEXT_EMDASH} hh:mm a').format(login.timestamp),
                    style: TextStyle(
                        color: LunaColours.accent,
                        fontWeight: FontWeight.w600,
                    ),
                ),
            ],
        ),
        softWrap: false,
        overflow: TextOverflow.fade,
        maxLines: 5,
    );

    Widget get _trailing => Column(
        children: [
            LSIconButton(
                icon: login.success ? Icons.check_circle : Icons.cancel,
                color: login.success ? Colors.white : LunaColours.red,
            ),
        ],
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
    );
}
