part of readarr_types;

enum ReadarrTrackedDownloadStatus {
  OK,
  WARNING,
  ERROR,
}

extension ReadarrTrackedDownloadStatusExtension on ReadarrTrackedDownloadStatus {
  ReadarrTrackedDownloadStatus? from(String? type) {
    switch (type) {
      case 'ok':
        return ReadarrTrackedDownloadStatus.OK;
      case 'warning':
        return ReadarrTrackedDownloadStatus.WARNING;
      case 'error':
        return ReadarrTrackedDownloadStatus.ERROR;
      default:
        return null;
    }
  }

  String? get value {
    switch (this) {
      case ReadarrTrackedDownloadStatus.OK:
        return 'ok';
      case ReadarrTrackedDownloadStatus.WARNING:
        return 'warning';
      case ReadarrTrackedDownloadStatus.ERROR:
        return 'error';
      default:
        return null;
    }
  }
}
