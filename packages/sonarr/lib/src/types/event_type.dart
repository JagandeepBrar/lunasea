part of sonarr_types;

enum SonarrEventType {
  EPISODE_FILE_RENAMED,
  EPISODE_FILE_DELETED,
  DOWNLOAD_FOLDER_IMPORTED,
  DOWNLOAD_FAILED,
  DOWNLOAD_IGNORED,
  GRABBED,
  SERIES_FOLDER_IMPORTED,
}

/// Extension on [SonarrEventType] to implement extended functionality.
extension SonarrEventTypeExtension on SonarrEventType {
  /// Given a String, will return the correct `SonarrEventType` object.
  SonarrEventType? from(String? type) {
    switch (type) {
      case 'episodeFileRenamed':
        return SonarrEventType.EPISODE_FILE_RENAMED;
      case 'episodeFileDeleted':
        return SonarrEventType.EPISODE_FILE_DELETED;
      case 'downloadFolderImported':
        return SonarrEventType.DOWNLOAD_FOLDER_IMPORTED;
      case 'downloadFailed':
        return SonarrEventType.DOWNLOAD_FAILED;
      case 'downloadIgnored':
        return SonarrEventType.DOWNLOAD_IGNORED;
      case 'grabbed':
        return SonarrEventType.GRABBED;
      case 'seriesFolderImported':
        return SonarrEventType.SERIES_FOLDER_IMPORTED;
      default:
        return null;
    }
  }

  /// The actual value/key for media types used in Sonarr.
  String? get value {
    switch (this) {
      case SonarrEventType.EPISODE_FILE_RENAMED:
        return 'episodeFileRenamed';
      case SonarrEventType.EPISODE_FILE_DELETED:
        return 'episodeFileDeleted';
      case SonarrEventType.DOWNLOAD_FOLDER_IMPORTED:
        return 'downloadFolderImported';
      case SonarrEventType.DOWNLOAD_FAILED:
        return 'downloadFailed';
      case SonarrEventType.DOWNLOAD_IGNORED:
        return 'downloadIgnored';
      case SonarrEventType.GRABBED:
        return 'grabbed';
      case SonarrEventType.SERIES_FOLDER_IMPORTED:
        return 'seriesFolderImported';
      default:
        return null;
    }
  }

  String? get readable {
    switch (this) {
      case SonarrEventType.EPISODE_FILE_RENAMED:
        return 'Episode File Renamed';
      case SonarrEventType.EPISODE_FILE_DELETED:
        return 'Episode File deleted';
      case SonarrEventType.DOWNLOAD_FOLDER_IMPORTED:
        return 'Episode Imported';
      case SonarrEventType.DOWNLOAD_FAILED:
        return 'Download Failed';
      case SonarrEventType.DOWNLOAD_IGNORED:
        return 'Download Ignored';
      case SonarrEventType.GRABBED:
        return 'Grabbed';
      case SonarrEventType.SERIES_FOLDER_IMPORTED:
        return 'Series Folder Imported';
      default:
        return null;
    }
  }
}
