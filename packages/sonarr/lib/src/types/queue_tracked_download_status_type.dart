part of sonarr_types;

enum SonarrTrackedDownloadStatus {
  OK,
  WARNING,
  ERROR,
}

extension SonarrTrackedDownloadStatusExtension on SonarrTrackedDownloadStatus {
  SonarrTrackedDownloadStatus? from(String? type) {
    switch (type) {
      case 'ok':
        return SonarrTrackedDownloadStatus.OK;
      case 'warning':
        return SonarrTrackedDownloadStatus.WARNING;
      case 'error':
        return SonarrTrackedDownloadStatus.ERROR;
      default:
        return null;
    }
  }

  String? get value {
    switch (this) {
      case SonarrTrackedDownloadStatus.OK:
        return 'ok';
      case SonarrTrackedDownloadStatus.WARNING:
        return 'warning';
      case SonarrTrackedDownloadStatus.ERROR:
        return 'error';
      default:
        return null;
    }
  }
}
