import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/mylar.dart';
import 'package:lunasea/system/cache/memory/memory_cache.dart';

class MylarSeasonDetailsState extends ChangeNotifier {
  final int seriesId;
  final int? seasonNumber;
  int _currentQueueItems = 0;
  int? currentEpisodeId;

  MylarSeasonDetailsState({
    required BuildContext context,
    required this.seriesId,
    required this.seasonNumber,
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
    _episodeSearchState = state;
    notifyListeners();
  }

  final _episodeHistoryCache = LunaMemoryCache<Future<MylarHistoryPage>>(
    maxEntries: 10,
    module: LunaModule.SONARR,
    id: 'episode_history_cache',
  );

  Future<void> fetchEpisodeHistory(BuildContext context, int? episodeId) async {
    if (context.read<MylarState>().enabled) {
      _episodeHistoryCache.put(
        episodeId.toString(),
        context.read<MylarState>().api!.history.get(
              pageSize: 1000,
              episodeId: episodeId,
            ),
      );
    }
    notifyListeners();
  }

  Future<MylarHistoryPage?> getEpisodeHistory(int episodeId) async {
    String id = episodeId.toString();
    return await _episodeHistoryCache.get(id);
  }

  Future<Map<int, MylarEpisode>>? _episodes;
  Future<Map<int, MylarEpisode>>? get episodes => _episodes;
  Future<void> fetchEpisodes(BuildContext context) async {
    if (context.read<MylarState>().enabled) {
      _episodes = context
          .read<MylarState>()
          .api!
          .episode
          .getMulti(seriesId: seriesId, seasonNumber: seasonNumber)
          .then((episodes) {
        return {
          for (MylarEpisode e in episodes) e.id!: e,
        };
      });
    }
    notifyListeners();
  }

  Future<void> setSingleEpisode(MylarEpisode episode) async {
    (await _episodes)![episode.id!] = episode;
    notifyListeners();
  }

  Future<List<MylarHistoryRecord>>? _history;
  Future<List<MylarHistoryRecord>>? get history => _history;
  Future<void> fetchHistory(BuildContext context) async {
    if (this.seasonNumber == null) return;
    if (context.read<MylarState>().enabled) {
      _history = context.read<MylarState>().api!.history.getBySeries(
            seriesId: seriesId,
            seasonNumber: seasonNumber,
          );
    }
    notifyListeners();
  }

  Future<Map<int, MylarEpisodeFile>>? _files;
  Future<Map<int, MylarEpisodeFile>>? get files => _files;
  Future<void> fetchFiles(BuildContext context) async {
    if (context.read<MylarState>().enabled) {
      _files = context
          .read<MylarState>()
          .api!
          .episodeFile
          .getSeries(seriesId: seriesId)
          .then((files) {
        return {
          for (MylarEpisodeFile f in files) f.id!: f,
        };
      });
    }
    notifyListeners();
  }

  Timer? _queueTimer;
  void cancelQueueTimer() => _queueTimer?.cancel();
  void createQueueTimer(BuildContext context) {
    _queueTimer = Timer.periodic(
      Duration(seconds: MylarDatabase.QUEUE_REFRESH_RATE.read()),
      (_) => fetchQueue(context),
    );
  }

  late Future<List<MylarQueueRecord>> _queue;
  Future<List<MylarQueueRecord>> get queue => _queue;
  set queue(Future<List<MylarQueueRecord>> queue) {
    _queue = queue;
    notifyListeners();
  }

  Future<void> fetchQueue(
    BuildContext context, {
    bool hardCheck = false,
  }) async {
    cancelQueueTimer();
    if (context.read<MylarState>().enabled) {
      // "Hard" check by telling Mylar to refresh the monitored downloads
      // Give it 500 ms to internally check and then continue to fetch queue
      if (hardCheck) {
        await context
            .read<MylarState>()
            .api!
            .command
            .refreshMonitoredDownloads()
            .then(
              (_) => Future.delayed(const Duration(milliseconds: 500), () {}),
            );
      }
      _queue = context
          .read<MylarState>()
          .api!
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

  final Set<int> selectedEpisodes = {};

  void toggleSelectedEpisode(MylarEpisode episode) {
    final id = episode.id!;
    if (selectedEpisodes.contains(id)) {
      selectedEpisodes.remove(id);
    } else {
      selectedEpisodes.add(id);
    }

    notifyListeners();
  }

  void clearSelectedEpisodes() {
    selectedEpisodes.clear();
    notifyListeners();
  }

  Future<void> toggleSeasonEpisodes(int seasonNumber) async {
    final eps = (await episodes)!
        .filter((ep) => ep.value.seasonNumber == seasonNumber)
        .map((ep) => ep.value.id!)
        .toList();
    final allSelected = eps.every(selectedEpisodes.contains);

    if (allSelected) {
      selectedEpisodes.removeAll(eps);
    } else {
      selectedEpisodes.addAll(eps);
    }

    notifyListeners();
  }
}
