import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeriesDetailsSeasonsPage extends StatelessWidget {
  final SonarrSeries series;

  const SonarrSeriesDetailsSeasonsPage({
    Key key,
    @required this.series,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (series?.seasons?.isEmpty ?? true) {
      return LunaMessage(text: 'sonarr.NoSeasonsFound'.tr());
    }
    List<SonarrSeriesSeason> _seasons = series.seasons;
    _seasons.sort((a, b) => a.seasonNumber.compareTo(b.seasonNumber));
    return LunaListView(
      controller: SonarrSeriesDetailsNavigationBar.scrollControllers[1],
      children: [
        if (_seasons.length > 1)
          SonarrSeriesDetailsSeasonAllTile(series: series),
        ...List.generate(
          _seasons.length,
          (index) => SonarrSeriesDetailsSeasonTile(
            seriesId: series.id,
            season: series.seasons[_seasons.length - 1 - index],
          ),
        ),
      ],
    );
  }
}
