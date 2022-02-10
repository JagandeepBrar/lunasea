import 'package:lunasea/core.dart';
import 'package:lunasea/modules/readarr.dart';

extension LunaReadarrQueueStatusExtension on ReadarrQueueStatus {
  String lunaStatus() {
    switch (this) {
      case ReadarrQueueStatus.DOWNLOADING:
        return 'readarr.Downloading'.tr();
      case ReadarrQueueStatus.PAUSED:
        return 'readarr.Paused'.tr();
      case ReadarrQueueStatus.QUEUED:
        return 'readarr.Queued'.tr();
      case ReadarrQueueStatus.COMPLETED:
        return 'readarr.Downloaded'.tr();
      case ReadarrQueueStatus.DELAY:
        return 'readarr.Pending'.tr();
      case ReadarrQueueStatus.DOWNLOAD_CLIENT_UNAVAILABLE:
        return 'readarr.DownloadClientUnavailable'.tr();
      case ReadarrQueueStatus.FAILED:
        return 'readarr.DownloadFailed'.tr();
      case ReadarrQueueStatus.WARNING:
        return 'readarr.DownloadWarning'.tr();
    }
  }
}
