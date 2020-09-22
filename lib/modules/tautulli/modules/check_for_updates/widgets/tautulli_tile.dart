import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:tautulli/tautulli.dart';

class TautulliCheckForUpdatesTautulliTile extends StatelessWidget {
    final TautulliUpdateCheck update;

    TautulliCheckForUpdatesTautulliTile({
        Key key,
        @required this.update,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: 'Tautulli'),
        subtitle: _subtitle,
        trailing: _trailing,
        padContent: true,
    );

    Widget get _trailing => Column(
        children: [
            LSIconButton(
                icon: CustomIcons.tautulli,
                color: LunaColours.list(1),
            ),
        ],
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
    );

    Widget get _subtitle => RichText(
        text: TextSpan(
            style: TextStyle(
                color: Colors.white70,
                fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
            ),
            children: <TextSpan>[
                if(!update.update) TextSpan(
                    text: 'No Updates Available\n',
                    style: TextStyle(
                        color: LunaColours.accent,
                        fontWeight: FontWeight.w600,
                    ),
                ),
                if(update.update) TextSpan(
                    text: 'Update Available\n',
                    style: TextStyle(
                        color: LunaColours.orange,
                        fontWeight: FontWeight.w600,
                    ),
                ),
                if(update.update) TextSpan(
                    text: 'Current Version: ${update.currentRelease?? update.currentVersion?.substring(0, 7) ?? 'Unknown'}\n',
                ),
                if(update.update) TextSpan(
                    text: 'Latest Version: ${update.latestRelease?? update.latestVersion?.substring(0, 7) ?? 'Unknown'}\n',
                ),
                TextSpan(text: 'Install Type: ${update.installType}'),
            ],
        ),
        overflow: TextOverflow.fade,
        maxLines: 4,
    );
}
