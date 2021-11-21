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
    initializeState(context);
  }

  void initializeState(BuildContext context) {
    fetchEpisodes(context);
    fetchFiles(context);
    if (seasonNumber != null) fetchHistory(context);
  }

  LunaLoadingState _episodeSearchState = LunaLoadingState.INACTIVE;
  LunaLoadingState get episodeSearchState => _episodeSearchState;
  set episodeSearchState(LunaLoadingState state) {
    assert(state != null);
    _episodeSearchState = state;
    notifyListeners();
  }

  ///////////////////////
  /// EPISODE HISTORY ///
  ///////////////////////

  final LunaLRUCache _episodeHistoryCache = LunaLRUCache(
    maxEntries: 10,
    module: LunaModule.SONARR,
    id: 'episode_history_cache',
  );

  LunaLRUCache get episodeHistoryCache => _episodeHistoryCache;
  set episodeHistoryCache(LunaLRUCache episodeHistoryCache) {
    assert(episodeHistoryCache != null);
    episodeHistoryCache = episodeHistoryCache;
    notifyListeners();
  }

  Future<void> fetchEpisodeHistory(BuildContext context, int episodeId) async {
    if (context.read<SonarrState>().enabled) {
      episodeHistoryCache.put(
        episodeId.toString(),
        context.read<SonarrState>().api.history.get(
              pageSize: 1000,
              episodeId: episodeId,
            ),
      );
    }
    notifyListeners();
  }

  Future<SonarrHistory> getEpisodeHistory(int episodeId) async {
    return episodeHistoryCache
        .get(episodeId.toString())
        .then((data) => data as SonarrHistory);
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

  Future<List<SonarrHistoryRecord>> _history;
  Future<List<SonarrHistoryRecord>> get history => _history;
  Future<void> fetchHistory(BuildContext context) async {
    if (context.read<SonarrState>().enabled ?? false) {
      _history = context.read<SonarrState>().api.history.getBySeries(
            seriesId: seriesId,
            seasonNumber: seasonNumber,
          );
    }
    notifyListeners();
  }

  Future<Map<int, SonarrEpisodeFile>> _files;
  Future<Map<int, SonarrEpisodeFile>> get files => _files;
  Future<void> fetchFiles(BuildContext context) async {
    if (context.read<SonarrState>().enabled ?? false) {
      _files = context
          .read<SonarrState>()
          .api
          .episodeFile
          .getSeries(seriesId: seriesId)
          .then((files) {
        return {
          for (SonarrEpisodeFile f in files) f.id: f,
        };
      });
    }
    notifyListeners();
  }
}
