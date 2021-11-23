import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeriesAddDetailsSeriesTypeTile extends StatelessWidget {
  const SonarrSeriesAddDetailsSeriesTypeTile({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaListTile(
      context: context,
      title: LunaText.title(text: 'sonarr.SeriesType'.tr()),
      subtitle: LunaText.subtitle(
          text: context
                  .watch<SonarrSeriesAddDetailsState>()
                  .seriesType
                  ?.value
                  ?.lunaCapitalizeFirstLetters() ??
              LunaUI.TEXT_EMDASH),
      trailing: LunaIconButton(icon: Icons.arrow_forward_ios_rounded),
      onTap: () async => _onTap(context),
    );
  }

  Future<void> _onTap(BuildContext context) async {
    Tuple2<bool, SonarrSeriesType> result =
        await SonarrDialogs().editSeriesType(context);
    if (result.item1) {
      context.read<SonarrSeriesAddDetailsState>().seriesType = result.item2;
      SonarrDatabaseValue.ADD_SERIES_DEFAULT_SERIES_TYPE
          .put(result.item2.value);
    }
  }
}
