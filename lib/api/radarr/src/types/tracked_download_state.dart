part of radarr_types;

enum RadarrTrackedDownloadState {
  DOWNLOADING,
  FAILED_PENDING,
  IMPORT_PENDING,
  IMPORTING,
}

extension RadarrTrackedDownloadStateExtension on RadarrTrackedDownloadState {
  RadarrTrackedDownloadState? from(String? key) {
    switch (key) {
      case 'downloading':
        return RadarrTrackedDownloadState.DOWNLOADING;
      case 'importPending':
        return RadarrTrackedDownloadState.IMPORT_PENDING;
      case 'failedPending':
        return RadarrTrackedDownloadState.FAILED_PENDING;
      case 'importing':
        return RadarrTrackedDownloadState.IMPORTING;
    }
    return null;
  }

  String get key {
    switch (this) {
      case RadarrTrackedDownloadState.DOWNLOADING:
        return 'downloading';
      case RadarrTrackedDownloadState.FAILED_PENDING:
        return 'failedPending';
      case RadarrTrackedDownloadState.IMPORT_PENDING:
        return 'importPending';
      case RadarrTrackedDownloadState.IMPORTING:
        return 'importing';
    }
  }
}
