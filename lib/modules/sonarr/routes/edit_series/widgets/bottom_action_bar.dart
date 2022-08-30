import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';
import 'package:lunasea/router/router.dart';

class SonarrEditSeriesActionBar extends StatelessWidget {
  const SonarrEditSeriesActionBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaBottomActionBar(
      actions: [
        LunaButton(
          type: LunaButtonType.TEXT,
          text: 'lunasea.Update'.tr(),
          icon: Icons.edit_rounded,
          loadingState: context.watch<SonarrSeriesEditState>().state,
          onTap: () async => _updateOnTap(context),
        ),
      ],
    );
  }

  Future<void> _updateOnTap(BuildContext context) async {
    if (context.read<SonarrSeriesEditState>().canExecuteAction) {
      context.read<SonarrSeriesEditState>().state = LunaLoadingState.ACTIVE;
      if (context.read<SonarrSeriesEditState>().series != null) {
        SonarrSeries series = context
            .read<SonarrSeriesEditState>()
            .series!
            .updateEdits(context.read<SonarrSeriesEditState>());
        bool result = await SonarrAPIController().updateSeries(
          context: context,
          series: series,
        );
        if (result) LunaRouter().popSafely();
      }
    }
  }
}
