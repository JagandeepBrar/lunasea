import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliCheckForUpdatesPMSTile extends StatelessWidget {
  final TautulliPMSUpdate update;

  const TautulliCheckForUpdatesPMSTile({
    Key? key,
    required this.update,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaBlock(
      title: 'Plex Media Server',
      body: _subtitle(),
      trailing: _trailing(),
    );
  }

  Widget _trailing() {
    return Column(
      children: [
        LunaIconButton(
          icon: LunaIcons.PLEX,
          iconSize: LunaUI.ICON_SIZE - 2.0,
          color: LunaColours().byListIndex(0),
        ),
      ],
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }

  List<TextSpan> _subtitle() {
    return [
      if (!(update.updateAvailable ?? false))
        const TextSpan(
          text: 'No Updates Available',
          style: TextStyle(
            color: LunaColours.accent,
            fontWeight: LunaUI.FONT_WEIGHT_BOLD,
          ),
        ),
      if (!(update.updateAvailable ?? false))
        TextSpan(
            text: 'Current Version: ${update.version ?? LunaUI.TEXT_EMDASH}'),
      if (update.updateAvailable ?? false)
        const TextSpan(
          text: 'Update Available',
          style: TextStyle(
            color: LunaColours.orange,
            fontWeight: LunaUI.FONT_WEIGHT_BOLD,
          ),
        ),
      if (update.updateAvailable ?? false)
        TextSpan(
            text: 'Latest Version: ${update.version ?? LunaUI.TEXT_EMDASH}'),
    ];
  }
}
