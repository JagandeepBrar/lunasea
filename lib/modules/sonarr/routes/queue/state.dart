import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrQueueState extends ChangeNotifier {
  SonarrQueueState(BuildContext context) {
    fetchQueue(context);
  }

  Timer? _timer;
  void cancelTimer() => _timer?.cancel();
  void createTimer(BuildContext context) {
    _timer = Timer.periodic(
      Duration(seconds: SonarrDatabaseValue.QUEUE_REFRESH_RATE.data),
      (_) => fetchQueue(context),
    );
  }

  late Future<SonarrQueue> _queue;
  Future<SonarrQueue> get queue => _queue;
  set queue(Future<SonarrQueue> queue) {
    this.queue = queue;
    notifyListeners();
  }

  Future<void> fetchQueue(
    BuildContext context, {
    bool hardCheck = false,
  }) async {
    cancelTimer();
    if (context.read<SonarrState>().enabled) {
      if (hardCheck) {
        // "Hard" check by telling Sonarr to refresh the monitored downloads
        // Give it 500 ms to internally check and then continue to fetch queue
        await context
            .read<SonarrState>()
            .api!
            .command
            .refreshMonitoredDownloads()
            .then(
              (_) => Future.delayed(const Duration(milliseconds: 500), () {}),
            );
      }
      _queue = context.read<SonarrState>().api!.queue.get(
            includeEpisode: true,
            includeSeries: true,
            pageSize: SonarrDatabaseValue.QUEUE_PAGE_SIZE.data,
          );
      createTimer(context);
    }
    notifyListeners();
  }
}
