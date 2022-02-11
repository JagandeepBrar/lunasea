import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/readarr.dart';

class ReadarrQueueState extends ChangeNotifier {
  ReadarrQueueState(BuildContext context) {
    fetchQueue(context);
  }

  Timer? _timer;
  void cancelTimer() => _timer?.cancel();
  void createTimer(BuildContext context) {
    _timer = Timer.periodic(
      Duration(seconds: ReadarrDatabaseValue.QUEUE_REFRESH_RATE.data),
      (_) => fetchQueue(context),
    );
  }

  late Future<ReadarrQueue> _queue;
  Future<ReadarrQueue> get queue => _queue;
  set queue(Future<ReadarrQueue> queue) {
    this.queue = queue;
    notifyListeners();
  }

  Future<void> fetchQueue(
    BuildContext context, {
    bool hardCheck = false,
  }) async {
    cancelTimer();
    if (context.read<ReadarrState>().enabled) {
      if (hardCheck) {
        // "Hard" check by telling Readarr to refresh the monitored downloads
        // Give it 500 ms to internally check and then continue to fetch queue
        await context
            .read<ReadarrState>()
            .api!
            .command
            .refreshMonitoredDownloads()
            .then(
              (_) => Future.delayed(const Duration(milliseconds: 500), () {}),
            );
      }
      _queue = context.read<ReadarrState>().api!.queue.get(
            includeBook: true,
            includeAuthor: true,
            pageSize: ReadarrDatabaseValue.QUEUE_PAGE_SIZE.data,
          );
      createTimer(context);
    }
    notifyListeners();
  }
}
