import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeasonDetailsSeason extends StatelessWidget {
    final int seasonNumber;
    final int seriesId;
    final List<SonarrEpisode> episodes;
    final ScrollController scrollController;

    SonarrSeasonDetailsSeason({
        Key key,
        @required this.seasonNumber,
        @required this.seriesId,
        @required this.episodes,
        @required this.scrollController,
    }) : super(key: key);
    
    @override
    Widget build(BuildContext context) {
        return LunaListView(
            controller: scrollController,
            children: [
                SonarrSeasonDetailsSeasonHeader(
                    seriesId: seriesId,
                    seasonNumber: seasonNumber,
                    episodes: episodes,
                ),
                ...List.generate(
                    episodes.length,
                    (index) => SonarrSeasonDetailsEpisodeTile(episode: episodes[index]),
                ),
            ],
        );
    }
}
