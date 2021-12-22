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
          icon: LunaBrandIcons.plex,
          color: LunaColours().byListIndex(0),
        ),
      ],
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }

  List<TextSpan> _subtitle() {
    return [
      if (!update.updateAvailable)
        const TextSpan(
          text: 'No Updates Available',
          style: TextStyle(
            color: LunaColours.accent,
            fontWeight: LunaUI.FONT_WEIGHT_BOLD,
          ),
        ),
      if (!update.updateAvailable)
        TextSpan(text: 'Current Version: ${update.version}'),
      if (update.updateAvailable)
        const TextSpan(
          text: 'Update Available',
          style: TextStyle(
            color: LunaColours.orange,
            fontWeight: LunaUI.FONT_WEIGHT_BOLD,
          ),
        ),
      if (update.updateAvailable)
        TextSpan(text: 'Latest Version: ${update.version}'),
    ];
  }
}
