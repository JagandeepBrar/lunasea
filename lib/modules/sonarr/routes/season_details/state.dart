import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeasonDetailsState extends ChangeNotifier {
  final int seriesId;
  final int seasonNumber;
  int _currentQueueItems = 0;
  int currentEpisodeId;

  SonarrSeasonDetailsState({
    @required BuildContext context,
    @required this.seriesId,
    @required this.seasonNumber,
  }) {
    fetchState(context, queueHardCheck: false);
  }

  Future<void> fetchState(
    BuildContext context, {
    bool shouldFetchEpisodes = true,
    bool shouldFetchFiles = true,
    bool shouldFetchHistory = true,
    bool shouldFetchQueue = true,
    bool queueHardCheck = true,
    bool shouldFetchMostRecentEpisodeHistory = true,
  }) async {
    if (shouldFetchEpisodes) fetchEpisodes(context);
    if (shouldFetchFiles) fetchFiles(context);
    if (shouldFetchHistory) fetchHistory(context);
    if (shouldFetchQueue) fetchQueue(context, hardCheck: queueHardCheck);
    if (shouldFetchMostRecentEpisodeHistory)
      fetchEpisodeHistory(context, currentEpisodeId);
  }

  @override
  void dispose() {
    _queueTimer?.cancel();
    super.dispose();
  }

  LunaLoadingState _episodeSearchState = LunaLoadingState.INACTIVE;
  LunaLoadingState get episodeSearchState => _episodeSearchState;
  set episodeSearchState(LunaLoadingState state) {
    assert(state != null);
    _episodeSearchState = state;
    notifyListeners();
  }

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

  Future<Map<int, SonarrEpisode>> _episodes;
  Future<Map<int, SonarrEpisode>> get episodes => _episodes;
  Future<void> fetchEpisodes(BuildContext context) async {
    if (context.read<SonarrState>().enabled ?? false) {
      _episodes = context
          .read<SonarrState>()
          .api
          .episode
          .getMulti(seriesId: seriesId, seasonNumber: seasonNumber)
          .then((episodes) {
        return {
          for (SonarrEpisode e in episodes) e.id: e,
        };
      });
    }
    notifyListeners();
  }

  Future<void> setSingleEpisode(SonarrEpisode episode) async {
    assert(episode != null);
    (await _episodes)[episode.id] = episode;
    notifyListeners();
  }

  Future<List<SonarrHistoryRecord>> _history;
  Future<List<SonarrHistoryRecord>> get history => _history;
  Future<void> fetchHistory(BuildContext context) async {
    if (this.seasonNumber == null) return;
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

  Timer _queueTimer;
  void cancelQueueTimer() => _queueTimer?.cancel();
  void createQueueTimer(BuildContext context) {
    _queueTimer = Timer.periodic(
      Duration(seconds: SonarrDatabaseValue.QUEUE_REFRESH_RATE.data),
      (_) => fetchQueue(context),
    );
  }

  Future<List<SonarrQueueRecord>> _queue;
  Future<List<SonarrQueueRecord>> get queue => _queue;
  set queue(Future<List<SonarrQueueRecord>> queue) {
    assert(queue != null);
    _queue = queue;
    notifyListeners();
  }

  Future<void> fetchQueue(
    BuildContext context, {
    bool hardCheck = false,
  }) async {
    cancelQueueTimer();
    if (context.read<SonarrState>().enabled) {
      // "Hard" check by telling Sonarr to refresh the monitored downloads
      // Give it 500 ms to internally check and then continue to fetch queue
      if (hardCheck) {
        await context
            .read<SonarrState>()
            .api
            .command
            .refreshMonitoredDownloads()
            .then(
              (_) => Future.delayed(const Duration(milliseconds: 500), () {}),
            );
      }
      _queue = context
          .read<SonarrState>()
          .api
          .queue
          .getDetails(
            seriesId: seriesId,
            includeEpisode: true,
          )
          .then((queue) {
        if (_currentQueueItems != queue.length) {
          fetchState(
            context,
            shouldFetchQueue: false,
          );
        }
        _currentQueueItems = queue.length;
        return queue;
      });
      createQueueTimer(context);
    }
    notifyListeners();
  }
}
