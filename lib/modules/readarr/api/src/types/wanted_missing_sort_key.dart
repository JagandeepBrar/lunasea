part of readarr_types;

enum ReadarrWantedMissingSortKey {
  RELEASE_DATE,
  AUTHOR_TITLE,
}

/// Extension on [ReadarrWantedMissingSortKey] to implement extended functionality.
extension ReadarrWantedMissingSortKeyExtension on ReadarrWantedMissingSortKey {
  /// Given a String, will return the correct `ReadarrWantedMissingSortKey` object.
  ReadarrWantedMissingSortKey? from(String? type) {
    switch (type) {
      case 'releaseDate':
        return ReadarrWantedMissingSortKey.RELEASE_DATE;
      case 'authorMetadata.sortName':
        return ReadarrWantedMissingSortKey.AUTHOR_TITLE;
      default:
        return null;
    }
  }

  /// The actual value/key for sorting directions used in Readarr.
  String? get value {
    switch (this) {
      case ReadarrWantedMissingSortKey.RELEASE_DATE:
        return 'releaseDate';
      case ReadarrWantedMissingSortKey.AUTHOR_TITLE:
        return 'authorMetadata.sortName';
      default:
        return null;
    }
  }
}
