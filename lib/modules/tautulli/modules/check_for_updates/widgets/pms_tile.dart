import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:tautulli/tautulli.dart';

class TautulliCheckForUpdatesPMSTile extends StatelessWidget {
    final TautulliPMSUpdate update;

    TautulliCheckForUpdatesPMSTile({
        Key key,
        @required this.update,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: 'Plex Media Server'),
        subtitle: _subtitle,
        trailing: _trailing,
        padContent: true,
    );

    Widget get _trailing => Column(
        children: [
            LSIconButton(
                icon: CustomIcons.plex,
                color: LunaColours.list(0),
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
                if(!update.updateAvailable) TextSpan(
                    text: 'No Updates Available\n',
                    style: TextStyle(
                        color: LunaColours.accent,
                        fontWeight: LunaUI.FONT_WEIGHT_BOLD,
                    ),
                ),
                if(!update.updateAvailable) TextSpan(text: 'Current Version: ${update.version}'),
                if(update.updateAvailable) TextSpan(
                    text: 'Update Available\n',
                    style: TextStyle(
                        color: LunaColours.orange,
                        fontWeight: LunaUI.FONT_WEIGHT_BOLD,
                    ),
                ),
                if(update.updateAvailable) TextSpan(text: 'Latest Version: ${update.version}'),
            ],
        ),
        overflow: TextOverflow.fade,
        maxLines: 3,
    );
}
