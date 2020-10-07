import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeriesSeasonDetailsSeason extends StatelessWidget {
    final int seasonNumber;
    final List<SonarrEpisode> episodes;

    SonarrSeriesSeasonDetailsSeason({
        Key key,
        @required this.seasonNumber,
        @required this.episodes,
    }) : super(key: key);
    
    @override
    Widget build(BuildContext context) => LSListView(
        children: List.generate(
            episodes.length,
            (index) => SonarrSeriesSeasonDetailsEpisodeTile(episode: episodes[index]),
        ),
    );
}
