part of sonarr_types;

enum SonarrQueueStatus {
  DOWNLOADING,
  PAUSED,
  QUEUED,
  COMPLETED,
  DELAY,
  DOWNLOAD_CLIENT_UNAVAILABLE,
  FAILED,
  WARNING,
}

extension SonarrQueueStatusExtension on SonarrQueueStatus {
  SonarrQueueStatus? from(String? type) {
    switch (type) {
      case 'downloading':
        return SonarrQueueStatus.DOWNLOADING;
      case 'paused':
        return SonarrQueueStatus.PAUSED;
      case 'queued':
        return SonarrQueueStatus.QUEUED;
      case 'completed':
        return SonarrQueueStatus.COMPLETED;
      case 'delay':
        return SonarrQueueStatus.DELAY;
      case 'downloadClientUnavailable':
        return SonarrQueueStatus.DOWNLOAD_CLIENT_UNAVAILABLE;
      case 'failed':
        return SonarrQueueStatus.FAILED;
      case 'warning':
        return SonarrQueueStatus.WARNING;
      default:
        return null;
    }
  }

  String? get value {
    switch (this) {
      case SonarrQueueStatus.DOWNLOADING:
        return 'downloading';
      case SonarrQueueStatus.PAUSED:
        return 'paused';
      case SonarrQueueStatus.QUEUED:
        return 'queued';
      case SonarrQueueStatus.COMPLETED:
        return 'completed';
      case SonarrQueueStatus.DELAY:
        return 'delay';
      case SonarrQueueStatus.DOWNLOAD_CLIENT_UNAVAILABLE:
        return 'downloadClientUnavailable';
      case SonarrQueueStatus.FAILED:
        return 'failed';
      case SonarrQueueStatus.WARNING:
        return 'warning';
      default:
        return null;
    }
  }
}
