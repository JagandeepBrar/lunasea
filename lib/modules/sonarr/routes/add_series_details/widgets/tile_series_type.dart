import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/extensions/string/string.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeriesAddDetailsSeriesTypeTile extends StatelessWidget {
  const SonarrSeriesAddDetailsSeriesTypeTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaBlock(
      title: 'sonarr.SeriesType'.tr(),
      body: [
        TextSpan(
          text: context
                  .watch<SonarrSeriesAddDetailsState>()
                  .seriesType
                  .value
                  ?.toTitleCase() ??
              LunaUI.TEXT_EMDASH,
        ),
      ],
      trailing: const LunaIconButton.arrow(),
      onTap: () async => _onTap(context),
    );
  }

  Future<void> _onTap(BuildContext context) async {
    Tuple2<bool, SonarrSeriesType?> result =
        await SonarrDialogs().editSeriesType(context);
    if (result.item1) {
      context.read<SonarrSeriesAddDetailsState>().seriesType = result.item2!;
      SonarrDatabase.ADD_SERIES_DEFAULT_SERIES_TYPE
          .update(result.item2!.value!);
    }
  }
}
