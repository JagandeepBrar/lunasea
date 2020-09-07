import 'package:flutter/material.dart';
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

    Widget get _subtitle => LSSubtitle(
        text: [
            '${login.ipAddress}\n',
            '${login.os}\n',
            '${login.host}\n'
            '${login.timestamp}',
        ].join(),
        maxLines: 5,
    );

    Widget get _trailing => Column(
        children: [
            LSIconButton(
                icon: login.success ? Icons.check_circle : Icons.cancel,
                color: login.success ? LSColors.accent : LSColors.red,
            ),
        ],
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
    );
}
