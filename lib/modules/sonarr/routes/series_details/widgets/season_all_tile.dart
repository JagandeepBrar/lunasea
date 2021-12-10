import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeriesDetailsSeasonAllTile extends StatelessWidget {
  final SonarrSeries series;

  const SonarrSeriesDetailsSeasonAllTile({
    Key key,
    @required this.series,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaThreeLineCardWithPoster(
      posterPlaceholder: LunaAssets.blankVideo,
      posterUrl: context.read<SonarrState>().getPosterURL(series.id),
      posterHeaders: context.read<SonarrState>().headers,
      title: 'sonarr.AllSeasons'.tr(),
      darken: !series.monitored,
      subtitle1: _subtitle1(),
      subtitle2: _subtitle2(),
      trailing: LunaIconButton(icon: Icons.arrow_forward_ios_rounded),
      onTap: () async => SonarrSeasonDetailsRouter().navigateTo(
        context,
        seriesId: series.id,
        seasonNumber: -1,
      ),
    );
  }

  TextSpan _subtitle1() {
    return TextSpan(
      text: series?.statistics?.sizeOnDisk?.lunaBytesToString(decimals: 1) ??
          '0.0B',
    );
  }

  TextSpan _subtitle2() {
    return TextSpan(
      style: TextStyle(
        color: series.lunaPercentageComplete == 100
            ? series.monitored
                ? LunaColours.accent
                : LunaColours.accent.withOpacity(0.30)
            : series.monitored
                ? LunaColours.red
                : LunaColours.red.withOpacity(0.30),
        fontWeight: LunaUI.FONT_WEIGHT_BOLD,
      ),
      text: [
        '${series.lunaPercentageComplete}%',
        LunaUI.TEXT_BULLET,
        '${series.statistics?.episodeFileCount ?? 0}/${series.statistics?.episodeCount ?? 0}',
        'Episodes Available',
      ].join(' '),
    );
  }
}
