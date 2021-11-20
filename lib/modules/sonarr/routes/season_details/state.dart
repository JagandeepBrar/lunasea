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
    assert(seriesId != null);
    resetEpisodeHistoryCache();
    fetchEpisodes(context);
    if (seasonNumber != null) fetchHistory(context);
  }

  LunaLoadingState _episodeSearchState = LunaLoadingState.INACTIVE;
  LunaLoadingState get episodeSearchState => _episodeSearchState;
  set episodeSearchState(LunaLoadingState state) {
    assert(state != null);
    _episodeSearchState = state;
    notifyListeners();
  }

  LunaLRUCache _episodeHistoryCache;
  LunaLRUCache get episodeHistoryCache => _episodeHistoryCache;
  set episodeHistoryCache(LunaLRUCache episodeHistoryCache) {
    assert(episodeHistoryCache != null);
    episodeHistoryCache = episodeHistoryCache;
    notifyListeners();
  }

  void resetEpisodeHistoryCache() {
    _episodeHistoryCache = LunaLRUCache(
      maxEntries: 5,
      module: LunaModule.SONARR,
      id: 'episode_history_cache',
    );
    notifyListeners();
  }

  Future<void> fetchEpisodeHistory(BuildContext context, int episodeId) async {
    if (context.read<SonarrState>().enabled) {
      episodeHistoryCache.put(
        episodeId.toString(),
        context.read<SonarrState>().api.history.get(
              pageSize: 250,
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

  final List<int> _selectedEpisodes = [];
  List<int> get selectedEpisodes => _selectedEpisodes;
  void addSelected(int id) {
    if (!_selectedEpisodes.contains(id)) _selectedEpisodes.add(id);
    notifyListeners();
  }

  void removeSelected(int id) {
    if (_selectedEpisodes.contains(id)) _selectedEpisodes.remove(id);
    notifyListeners();
  }

  void toggleSelected(int id) {
    if (_selectedEpisodes.contains(id)) {
      removeSelected(id);
    } else {
      addSelected(id);
    }
    notifyListeners();
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
    SonarrState state = context.read<SonarrState>();
    if (state.enabled) {
      _history = state.api.history.getBySeries(
        seriesId: seriesId,
        seasonNumber: seasonNumber,
      );
    }
    notifyListeners();
    await _history;
  }
}
