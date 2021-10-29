import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeriesDetailsSeasonList extends StatelessWidget {
  final SonarrSeries series;

  const SonarrSeriesDetailsSeasonList({
    Key key,
    @required this.series,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (series.seasons.isEmpty) return LunaMessage(text: 'No Seasons Found');
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
