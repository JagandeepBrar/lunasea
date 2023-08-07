import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/mylar.dart';

class MylarQueueState extends ChangeNotifier {
  MylarQueueState(BuildContext context) {
    fetchQueue(context);
  }

  Timer? _timer;
  void cancelTimer() => _timer?.cancel();
  void createTimer(BuildContext context) {
    _timer = Timer.periodic(
      Duration(seconds: MylarDatabase.QUEUE_REFRESH_RATE.read()),
      (_) => fetchQueue(context),
    );
  }

  late Future<MylarQueuePage> _queue;
  Future<MylarQueuePage> get queue => _queue;
  set queue(Future<MylarQueuePage> queue) {
    this.queue = queue;
    notifyListeners();
  }

  Future<void> fetchQueue(
    BuildContext context, {
    bool hardCheck = false,
  }) async {
    cancelTimer();
    if (context.read<MylarState>().enabled) {
      if (hardCheck) {
        // "Hard" check by telling Mylar to refresh the monitored downloads
        // Give it 500 ms to internally check and then continue to fetch queue
        await context
            .read<MylarState>()
            .api!
            .command
            .refreshMonitoredDownloads()
            .then(
              (_) => Future.delayed(const Duration(milliseconds: 500), () {}),
            );
      }
      _queue = context.read<MylarState>().api!.queue.get(
            includeEpisode: true,
            includeSeries: true,
            pageSize: MylarDatabase.QUEUE_PAGE_SIZE.read(),
          );
      createTimer(context);
    }
    notifyListeners();
  }
}
