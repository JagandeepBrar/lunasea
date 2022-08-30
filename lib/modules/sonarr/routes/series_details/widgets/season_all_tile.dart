import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/extensions/int/bytes.dart';
import 'package:lunasea/modules/sonarr.dart';
import 'package:lunasea/router/routes/sonarr.dart';

class SonarrSeriesDetailsSeasonAllTile extends StatelessWidget {
  final SonarrSeries? series;

  const SonarrSeriesDetailsSeasonAllTile({
    Key? key,
    required this.series,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaBlock(
      title: 'sonarr.AllSeasons'.tr(),
      disabled: !series!.monitored!,
      body: [
        _subtitle1(),
        _subtitle2(),
      ],
      trailing: const LunaIconButton.arrow(),
      onTap: () async {
        SonarrRoutes.SERIES_SEASON.go(params: {
          'series': (series?.id ?? -1).toString(),
          'season': '-1',
        });
      },
    );
  }

  TextSpan _subtitle1() {
    return TextSpan(
      text: series?.statistics?.sizeOnDisk?.asBytes(decimals: 1) ?? '0.0B',
    );
  }

  TextSpan _subtitle2() {
    return TextSpan(
      style: TextStyle(
        color: series!.lunaPercentageComplete == 100
            ? LunaColours.accent
            : LunaColours.red,
        fontWeight: LunaUI.FONT_WEIGHT_BOLD,
      ),
      text: [
        '${series!.lunaPercentageComplete}%',
        LunaUI.TEXT_BULLET,
        '${series!.statistics?.episodeFileCount ?? 0}/${series!.statistics?.episodeCount ?? 0}',
        'Episodes Available',
      ].join(' '),
    );
  }
}
