import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lunasea/core.dart';
import 'package:tautulli/tautulli.dart';

class TautulliLogsNewsletterLogTile extends StatelessWidget {
    final TautulliNewsletterLogRecord newsletter;

    TautulliLogsNewsletterLogTile({
        Key key,
        @required this.newsletter,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: newsletter.agentName),
        subtitle: _subtitle,
        trailing: _trailing,
        padContent: true,
    );

    Widget get _subtitle => LSSubtitle(
        text: [
            '${newsletter.notifyAction}\n',
            '${newsletter.subjectText}\n',
            LunaSeaDatabaseValue.USE_24_HOUR_TIME.data
                ? DateFormat('MMMM dd, yyyy ${Constants.TEXT_EMDASH} HH:mm').format(newsletter.timestamp)
                : DateFormat('MMMM dd, yyyy ${Constants.TEXT_EMDASH} KK:mm a').format(newsletter.timestamp),
        ].join(),
        maxLines: 5,
    );

    Widget get _trailing => Column(
        children: [
            LSIconButton(
                icon: newsletter.success ? Icons.check_circle : Icons.cancel,
                color: newsletter.success ? LSColors.accent : LSColors.red,
            ),
        ],
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
    );
}
