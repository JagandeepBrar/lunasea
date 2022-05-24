import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliCheckForUpdatesTautulliTile extends StatelessWidget {
  final TautulliUpdateCheck update;

  const TautulliCheckForUpdatesTautulliTile({
    Key? key,
    required this.update,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaBlock(
      title: 'Tautulli',
      body: _subtitle(),
      trailing: _trailing(),
    );
  }

  Widget _trailing() {
    return Column(
      children: [
        LunaIconButton(
          icon: LunaIcons.TAUTULLI,
          color: LunaColours().byListIndex(1),
        ),
      ],
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }

  List<TextSpan> _subtitle() {
    return [
      if (!(update.update ?? false))
        const TextSpan(
          text: 'No Updates Available',
          style: TextStyle(
            color: LunaColours.accent,
            fontWeight: LunaUI.FONT_WEIGHT_BOLD,
          ),
        ),
      if (update.update ?? false)
        const TextSpan(
          text: 'Update Available',
          style: TextStyle(
            color: LunaColours.orange,
            fontWeight: LunaUI.FONT_WEIGHT_BOLD,
          ),
        ),
      if (update.update ?? false)
        TextSpan(
          children: [
            const TextSpan(text: 'Current Version: '),
            TextSpan(
              text: update.currentRelease ??
                  update.currentVersion?.substring(
                    0,
                    min(7, update.currentVersion!.length),
                  ) ??
                  'lunasea.Unknown'.tr(),
            ),
          ],
        ),
      if (update.update ?? false)
        TextSpan(
          children: [
            const TextSpan(text: 'Latest Version: '),
            TextSpan(
              text: update.latestRelease ??
                  update.latestVersion?.substring(
                    0,
                    min(7, update.latestVersion!.length),
                  ) ??
                  'lunasea.Unknown'.tr(),
            ),
          ],
        ),
      TextSpan(
          text: 'Install Type: ${update.installType ?? LunaUI.TEXT_EMDASH}'),
    ];
  }
}
