part of radarr_types;

enum RadarrEventType {
  GRABBED,
  DOWNLOAD_FAILED,
  DOWNLOAD_FOLDER_IMPORTED,
  DOWNLOAD_IGNORED,
  MOVIE_FILE_DELETED,
  MOVIE_FILE_RENAMED,
  MOVIE_FOLDER_IMPORTED,
}

/// Extension on [RadarrEventType] to implement extended functionality.
extension RadarrEventTypeExtension on RadarrEventType {
  /// Given a String, will return the correct [RadarrEventType] object.
  RadarrEventType? from(String? type) {
    switch (type) {
      case 'grabbed':
        return RadarrEventType.GRABBED;
      case 'downloadFailed':
        return RadarrEventType.DOWNLOAD_FAILED;
      case 'downloadFolderImported':
        return RadarrEventType.DOWNLOAD_FOLDER_IMPORTED;
      case 'downloadIgnored':
        return RadarrEventType.DOWNLOAD_IGNORED;
      case 'movieFileDeleted':
        return RadarrEventType.MOVIE_FILE_DELETED;
      case 'movieFileRenamed':
        return RadarrEventType.MOVIE_FILE_RENAMED;
      case 'movieFolderImported':
        return RadarrEventType.MOVIE_FOLDER_IMPORTED;
      default:
        return null;
    }
  }

  String? get value {
    switch (this) {
      case RadarrEventType.GRABBED:
        return 'grabbed';
      case RadarrEventType.DOWNLOAD_FAILED:
        return 'downloadFailed';
      case RadarrEventType.DOWNLOAD_FOLDER_IMPORTED:
        return 'downloadFolderImported';
      case RadarrEventType.DOWNLOAD_IGNORED:
        return 'downloadIgnored';
      case RadarrEventType.MOVIE_FILE_DELETED:
        return 'movieFileDeleted';
      case RadarrEventType.MOVIE_FILE_RENAMED:
        return 'movieFileRenamed';
      case RadarrEventType.MOVIE_FOLDER_IMPORTED:
        return 'movieFolderImported';
    }
  }

  String? get readable {
    switch (this) {
      case RadarrEventType.GRABBED:
        return 'Grabbed';
      case RadarrEventType.DOWNLOAD_FAILED:
        return 'Download Failed';
      case RadarrEventType.DOWNLOAD_FOLDER_IMPORTED:
        return 'Movie Imported';
      case RadarrEventType.DOWNLOAD_IGNORED:
        return 'Download Ignored';
      case RadarrEventType.MOVIE_FILE_DELETED:
        return 'Movie File Deleted';
      case RadarrEventType.MOVIE_FILE_RENAMED:
        return 'Movie File Renamed';
      case RadarrEventType.MOVIE_FOLDER_IMPORTED:
        return 'Movie Imported';
    }
  }
}
