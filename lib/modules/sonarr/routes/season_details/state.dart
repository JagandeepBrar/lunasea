import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeasonDetailsState extends ChangeNotifier {
  final int seriesId;
  final int seasonNumber;
  SonarrSeasonDetailsState({
    @required BuildContext context,
    @required this.seriesId,
    @required this.seasonNumber,
  }) {
    fetchEpisodes(context);
  }

  Future<List<SonarrEpisode>> _episodes;
  Future<List<SonarrEpisode>> get episodes => _episodes;
  Future<void> fetchEpisodes(BuildContext context) async {
    if (context.read<SonarrState>().enabled ?? false) {
      _episodes = context
          .read<SonarrState>()
          .api
          .episode
          .getMulti(seriesId: seriesId, seasonNumber: seasonNumber)
          .then((episodes) {
        episodes.sort((a, b) {
          int _season = b.seasonNumber.compareTo(a.seasonNumber);
          if (_season != 0) return _season;
          return b.episodeNumber.compareTo(a.episodeNumber);
        });
        return episodes;
      });
    }
    notifyListeners();
  }
}
