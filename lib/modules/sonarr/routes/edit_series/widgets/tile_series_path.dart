import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeriesEditSeriesPathTile extends StatelessWidget {
  const SonarrSeriesEditSeriesPathTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaBlock(
      title: 'sonarr.SeriesPath'.tr(),
      body: [
        TextSpan(
          text: context.watch<SonarrSeriesEditState>().seriesPath,
        ),
      ],
      trailing: const LunaIconButton.arrow(),
      onTap: () async => _onTap(context),
    );
  }

  Future<void> _onTap(BuildContext context) async {
    Tuple2<bool, String> _values = await LunaDialogs().editText(
      context,
      'sonarr.SeriesPath'.tr(),
      prefill: context.read<SonarrSeriesEditState>().seriesPath,
    );
    if (_values.item1)
      context.read<SonarrSeriesEditState>().seriesPath = _values.item2;
  }
}
