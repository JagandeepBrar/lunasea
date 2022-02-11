part of readarr_types;

enum ReadarrTrackedDownloadState {
  DOWNLOADING,
  IMPORT_PENDING,
  IMPORTING,
  FAILED_PENDING,
}

extension ReadarrTrackedDownloadStateExtension on ReadarrTrackedDownloadState {
  ReadarrTrackedDownloadState? from(String? type) {
    switch (type) {
      case 'downloading':
        return ReadarrTrackedDownloadState.DOWNLOADING;
      case 'importPending':
        return ReadarrTrackedDownloadState.IMPORT_PENDING;
      case 'importing':
        return ReadarrTrackedDownloadState.IMPORTING;
      case 'failedPending':
        return ReadarrTrackedDownloadState.FAILED_PENDING;
      default:
        return null;
    }
  }

  String? get value {
    switch (this) {
      case ReadarrTrackedDownloadState.DOWNLOADING:
        return 'downloading';
      case ReadarrTrackedDownloadState.IMPORT_PENDING:
        return 'importPending';
      case ReadarrTrackedDownloadState.IMPORTING:
        return 'importing';
      case ReadarrTrackedDownloadState.FAILED_PENDING:
        return 'failedPending';
      default:
        return null;
    }
  }
}
