part of sonarr_types;

enum SonarrTrackedDownloadState {
  DOWNLOADING,
  IMPORT_PENDING,
  IMPORTING,
  FAILED_PENDING,
}

extension SonarrTrackedDownloadStateExtension on SonarrTrackedDownloadState {
  SonarrTrackedDownloadState? from(String? type) {
    switch (type) {
      case 'downloading':
        return SonarrTrackedDownloadState.DOWNLOADING;
      case 'importPending':
        return SonarrTrackedDownloadState.IMPORT_PENDING;
      case 'importing':
        return SonarrTrackedDownloadState.IMPORTING;
      case 'failedPending':
        return SonarrTrackedDownloadState.FAILED_PENDING;
      default:
        return null;
    }
  }

  String? get value {
    switch (this) {
      case SonarrTrackedDownloadState.DOWNLOADING:
        return 'downloading';
      case SonarrTrackedDownloadState.IMPORT_PENDING:
        return 'importPending';
      case SonarrTrackedDownloadState.IMPORTING:
        return 'importing';
      case SonarrTrackedDownloadState.FAILED_PENDING:
        return 'failedPending';
      default:
        return null;
    }
  }
}
