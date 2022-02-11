part of readarr_types;

enum ReadarrEventType {
  GRABBED,
  BOOK_FILE_IMPORTED,
  DOWNLOAD_FAILED,
  BOOK_FILE_DELETED,
  BOOK_FILE_RENAMED,
  BOOK_IMPORT_INCOMPLETE,
  DOWNLOAD_IMPORTED,
  BOOK_FILE_RETAGGED,
  DOWNLOAD_IGNORED
}

/// Extension on [ReadarrEventType] to implement extended functionality.
extension ReadarrEventTypeExtension on ReadarrEventType {
  /// Given a String, will return the correct `ReadarrEventType` object.
  ReadarrEventType? from(String? type) {
    switch (type) {
      case 'grabbed':
        return ReadarrEventType.GRABBED;
      case 'bookFileImported':
        return ReadarrEventType.BOOK_FILE_IMPORTED;
      case 'downloadFailed':
        return ReadarrEventType.DOWNLOAD_FAILED;
      case 'bookFileDeleted':
        return ReadarrEventType.BOOK_FILE_DELETED;
      case 'bookFileRenamed':
        return ReadarrEventType.BOOK_FILE_RENAMED;
      case 'bookImportIncomplete':
        return ReadarrEventType.BOOK_IMPORT_INCOMPLETE;
      case 'downloadImported':
        return ReadarrEventType.DOWNLOAD_IMPORTED;
      case 'bookFileRetagged':
        return ReadarrEventType.BOOK_FILE_RETAGGED;
      case 'downloadIgnored':
        return ReadarrEventType.DOWNLOAD_IGNORED;
      default:
        return null;
    }
  }

  /// The actual value/key for media types used in Readarr.
  String? get value {
    switch (this) {
      case ReadarrEventType.GRABBED:
        return 'grabbed';
      case ReadarrEventType.BOOK_FILE_IMPORTED:
        return 'bookFileImported';
      case ReadarrEventType.DOWNLOAD_FAILED:
        return 'downloadFailed';
      case ReadarrEventType.BOOK_FILE_DELETED:
        return 'bookFileDeleted';
      case ReadarrEventType.BOOK_FILE_RENAMED:
        return 'bookFileRenamed';
      case ReadarrEventType.BOOK_IMPORT_INCOMPLETE:
        return 'bookImportIncomplete';
      case ReadarrEventType.DOWNLOAD_IMPORTED:
        return 'downloadImported';
      case ReadarrEventType.BOOK_FILE_RETAGGED:
        return 'bookFileRetagged';
      case ReadarrEventType.DOWNLOAD_IGNORED:
        return 'downloadIgnored';
      default:
        return null;
    }
  }

  String? get readable {
    switch (this) {
      case ReadarrEventType.GRABBED:
        return 'Grabbed';
      case ReadarrEventType.BOOK_FILE_IMPORTED:
        return 'Book File Imported';
      case ReadarrEventType.DOWNLOAD_FAILED:
        return 'Download Failed';
      case ReadarrEventType.BOOK_FILE_DELETED:
        return 'Book File Deleted';
      case ReadarrEventType.BOOK_FILE_RENAMED:
        return 'Book File Renamed';
      case ReadarrEventType.BOOK_IMPORT_INCOMPLETE:
        return 'Book Import Incomplete';
      case ReadarrEventType.DOWNLOAD_IMPORTED:
        return 'Download Imported';
      case ReadarrEventType.BOOK_FILE_RETAGGED:
        return 'Book File Retagged';
      case ReadarrEventType.DOWNLOAD_IGNORED:
        return 'Download Ignored';
      default:
        return null;
    }
  }
}
