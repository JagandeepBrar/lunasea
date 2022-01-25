part of radarr_types;

enum RadarrQueueRecordStatus {
  COMPLETED,
  DELAY,
  DOWNLOAD_CLIENT_UNAVAILABLE,
  DOWNLOADING,
  FAILED,
  PAUSED,
  QUEUED,
  WARNING,
}

extension RadarrQueueRecordStatusExtension on RadarrQueueRecordStatus {
  RadarrQueueRecordStatus? from(String? key) {
    switch (key) {
      case 'completed':
        return RadarrQueueRecordStatus.COMPLETED;
      case 'delay':
        return RadarrQueueRecordStatus.DELAY;
      case 'DownloadClientUnavailable':
        return RadarrQueueRecordStatus.DOWNLOAD_CLIENT_UNAVAILABLE;
      case 'downloading':
        return RadarrQueueRecordStatus.DOWNLOADING;
      case 'failed':
        return RadarrQueueRecordStatus.FAILED;
      case 'paused':
        return RadarrQueueRecordStatus.PAUSED;
      case 'queued':
        return RadarrQueueRecordStatus.QUEUED;
      case 'warning':
        return RadarrQueueRecordStatus.WARNING;
    }
    return null;
  }

  String get key {
    switch (this) {
      case RadarrQueueRecordStatus.COMPLETED:
        return 'completed';
      case RadarrQueueRecordStatus.DELAY:
        return 'delay';
      case RadarrQueueRecordStatus.DOWNLOAD_CLIENT_UNAVAILABLE:
        return 'DownloadClientUnavailable';
      case RadarrQueueRecordStatus.DOWNLOADING:
        return 'downloading';
      case RadarrQueueRecordStatus.FAILED:
        return 'failed';
      case RadarrQueueRecordStatus.PAUSED:
        return 'paused';
      case RadarrQueueRecordStatus.QUEUED:
        return 'queued';
      case RadarrQueueRecordStatus.WARNING:
        return 'warning';
    }
  }

  String get readable {
    switch (this) {
      case RadarrQueueRecordStatus.COMPLETED:
        return 'Downloaded';
      case RadarrQueueRecordStatus.DELAY:
        return 'Pending';
      case RadarrQueueRecordStatus.DOWNLOAD_CLIENT_UNAVAILABLE:
        return 'Download Client Unavailable';
      case RadarrQueueRecordStatus.DOWNLOADING:
        return 'Downloading';
      case RadarrQueueRecordStatus.FAILED:
        return 'Failed';
      case RadarrQueueRecordStatus.PAUSED:
        return 'Paused';
      case RadarrQueueRecordStatus.QUEUED:
        return 'Queued';
      case RadarrQueueRecordStatus.WARNING:
        return 'Warning';
    }
  }
}
