import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeriesDetailsSeasonList extends StatelessWidget {
    final SonarrSeries series;

    SonarrSeriesDetailsSeasonList({
        Key key,
        @required this.series,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) => series.seasons.length == 0
        ? LSGenericMessage(text: 'No Seasons Found')
        : LSListView(
            children: [
                if(series.seasons.length > 1) SonarrSeriesDetailsSeasonAllTile(series: series),
                ...List.generate(
                    series.seasons.length,
                    (index) => SonarrSeriesDetailsSeasonTile(
                        seriesId: series.id,
                        season: series.seasons[series.seasons.length - 1 - index],
                    ), 
                ),
            ],
        );
}
