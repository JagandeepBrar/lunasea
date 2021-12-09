import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliCheckForUpdatesPMSTile extends StatelessWidget {
  final TautulliPMSUpdate update;

  const TautulliCheckForUpdatesPMSTile({
    Key key,
    @required this.update,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaListTile(
      context: context,
      title: LunaText.title(text: 'Plex Media Server'),
      subtitle: _subtitle(),
      trailing: _trailing(),
      contentPadding: true,
    );
  }

  Widget _trailing() {
    return Column(
      children: [
        LunaIconButton(
          icon: LunaBrandIcons.plex,
          color: LunaColours().byListIndex(0),
        ),
      ],
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }

  Widget _subtitle() {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
          color: Colors.white70,
          fontSize: LunaUI.FONT_SIZE_SUBTITLE,
        ),
        children: <TextSpan>[
          if (!update.updateAvailable)
            const TextSpan(
              text: 'No Updates Available\n',
              style: TextStyle(
                color: LunaColours.accent,
                fontWeight: LunaUI.FONT_WEIGHT_BOLD,
              ),
            ),
          if (!update.updateAvailable)
            TextSpan(text: 'Current Version: ${update.version}'),
          if (update.updateAvailable)
            const TextSpan(
              text: 'Update Available\n',
              style: TextStyle(
                color: LunaColours.orange,
                fontWeight: LunaUI.FONT_WEIGHT_BOLD,
              ),
            ),
          if (update.updateAvailable)
            TextSpan(text: 'Latest Version: ${update.version}'),
        ],
      ),
      overflow: TextOverflow.fade,
      maxLines: 2,
    );
  }
}
