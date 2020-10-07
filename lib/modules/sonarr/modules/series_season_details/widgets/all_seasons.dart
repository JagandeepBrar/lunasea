import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeriesSeasonDetailsAllSeasons extends StatelessWidget {
    final List<SonarrEpisode> episodes;

    SonarrSeriesSeasonDetailsAllSeasons({
        Key key,
        @required this.episodes,
    }) : super(key: key);
    
    @override
    Widget build(BuildContext context) => LSListView(
        children: _buildSeasons,
    );

    List<Widget> get _buildSeasons {
        // Put episodes into a map with the key being the season number
        Map<int, List<SonarrEpisode>> _episodeMap = {};
        episodes.forEach((episode) {
            if(!_episodeMap.containsKey(episode.seasonNumber)) _episodeMap[episode.seasonNumber] = [];
            _episodeMap[episode.seasonNumber].add(episode);
        });
        // Sort the keys
        List<int> _keys = _episodeMap.keys.toList();
        _keys.sort((a,b) => b.compareTo(a));
        // Build each season
        List<List<Widget>> _episodes = _keys.fold([], (array, season) {
            _episodeMap[season].sort((a,b) => b.episodeNumber.compareTo(a.episodeNumber));
            array.add(_season(_episodeMap[season], season));
            return array;
        });
        // Return the final list of seasons
        return _episodes.expand((e) => e).toList();
    }

    List<Widget> _season(List<SonarrEpisode> episodes, int seasonNumber) => [
        LSHeader(
            text: seasonNumber == 0
                ? 'Specials'
                : 'Season $seasonNumber',
        ),
        ...List.generate(
            episodes.length,
            (index) => SonarrSeriesSeasonDetailsEpisodeTile(episode: episodes[index]),
        ),
    ];
}
