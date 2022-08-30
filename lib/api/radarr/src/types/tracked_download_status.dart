part of radarr_types;

enum RadarrTrackedDownloadStatus {
  OK,
  ERROR,
  WARNING,
}

extension RadarrTrackedDownloadStatusExtension on RadarrTrackedDownloadStatus {
  RadarrTrackedDownloadStatus? from(String? key) {
    switch (key) {
      case 'ok':
        return RadarrTrackedDownloadStatus.OK;
      case 'error':
        return RadarrTrackedDownloadStatus.ERROR;
      case 'warning':
        return RadarrTrackedDownloadStatus.WARNING;
    }
    return null;
  }

  String get key {
    switch (this) {
      case RadarrTrackedDownloadStatus.OK:
        return 'ok';
      case RadarrTrackedDownloadStatus.ERROR:
        return 'delay';
      case RadarrTrackedDownloadStatus.WARNING:
        return 'warning';
    }
  }
}
