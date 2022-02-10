part of readarr_types;

enum ReadarrQueueStatus {
  DOWNLOADING,
  PAUSED,
  QUEUED,
  COMPLETED,
  DELAY,
  DOWNLOAD_CLIENT_UNAVAILABLE,
  FAILED,
  WARNING,
}

extension ReadarrQueueStatusExtension on ReadarrQueueStatus {
  ReadarrQueueStatus? from(String? type) {
    switch (type) {
      case 'downloading':
        return ReadarrQueueStatus.DOWNLOADING;
      case 'paused':
        return ReadarrQueueStatus.PAUSED;
      case 'queued':
        return ReadarrQueueStatus.QUEUED;
      case 'completed':
        return ReadarrQueueStatus.COMPLETED;
      case 'delay':
        return ReadarrQueueStatus.DELAY;
      case 'downloadClientUnavailable':
        return ReadarrQueueStatus.DOWNLOAD_CLIENT_UNAVAILABLE;
      case 'failed':
        return ReadarrQueueStatus.FAILED;
      case 'warning':
        return ReadarrQueueStatus.WARNING;
      default:
        return null;
    }
  }

  String? get value {
    switch (this) {
      case ReadarrQueueStatus.DOWNLOADING:
        return 'downloading';
      case ReadarrQueueStatus.PAUSED:
        return 'paused';
      case ReadarrQueueStatus.QUEUED:
        return 'queued';
      case ReadarrQueueStatus.COMPLETED:
        return 'completed';
      case ReadarrQueueStatus.DELAY:
        return 'delay';
      case ReadarrQueueStatus.DOWNLOAD_CLIENT_UNAVAILABLE:
        return 'downloadClientUnavailable';
      case ReadarrQueueStatus.FAILED:
        return 'failed';
      case ReadarrQueueStatus.WARNING:
        return 'warning';
      default:
        return null;
    }
  }
}
