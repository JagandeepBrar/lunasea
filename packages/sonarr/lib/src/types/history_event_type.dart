part of sonarr_types;

/// Enumerator to handle all history event types used in Sonarr.
enum SonarrHistoryEventType {
    EPISODE_FILE_RENAMED,
    EPISODE_FILE_DELETED,
    DOWNLOAD_FOLDER_IMPORTED,
    DOWNLOAD_FAILED,
    GRABBED,
}

/// Extension on [SonarrHistoryEventType] to implement extended functionality.
extension SonarrHistoryEventTypeExtension on SonarrHistoryEventType {
    /// Given a String, will return the correct `SonarrHistoryEventType` object.
    SonarrHistoryEventType? from(String? type) {
        switch(type) {
            case 'episodeFileRenamed': return SonarrHistoryEventType.EPISODE_FILE_RENAMED;
            case 'episodeFileDeleted': return SonarrHistoryEventType.EPISODE_FILE_DELETED;
            case 'downloadFolderImported': return SonarrHistoryEventType.DOWNLOAD_FOLDER_IMPORTED;
            case 'downloadFailed': return SonarrHistoryEventType.DOWNLOAD_FAILED;
            case 'grabbed': return SonarrHistoryEventType.GRABBED;
            default: return null;
        }
    }

    /// The actual value/key for media types used in Sonarr.
    String? get value {
        switch(this) {
            case SonarrHistoryEventType.EPISODE_FILE_RENAMED: return 'episodeFileRenamed';
            case SonarrHistoryEventType.EPISODE_FILE_DELETED: return 'episodeFileDeleted';
            case SonarrHistoryEventType.DOWNLOAD_FOLDER_IMPORTED: return 'downloadFolderImported';
            case SonarrHistoryEventType.DOWNLOAD_FAILED: return 'downloadFailed';
            case SonarrHistoryEventType.GRABBED: return 'grabbed';
            default: return null;
        }
    }
}
