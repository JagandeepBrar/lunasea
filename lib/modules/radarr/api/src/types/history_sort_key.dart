part of radarr_types;

enum RadarrHistorySortKey {
  DATE,
  MOVIES_TITLE,
  LANGUAGES,
  QUALITY,
}

/// Extension on [RadarrHistorySortKey] to implement extended functionality.
extension RadarrHistorySortKeyExtension on RadarrHistorySortKey {
  /// Given a String, will return the correct `RadarrHistorySortKey` object.
  RadarrHistorySortKey? from(String? type) {
    switch (type) {
      case 'date':
        return RadarrHistorySortKey.DATE;
      case 'movies.sortTitle':
        return RadarrHistorySortKey.MOVIES_TITLE;
      case 'languages':
        return RadarrHistorySortKey.LANGUAGES;
      case 'quality':
        return RadarrHistorySortKey.QUALITY;
      default:
        return null;
    }
  }

  /// The actual value/key for sorting directions used in Radarr.
  String? get value {
    switch (this) {
      case RadarrHistorySortKey.DATE:
        return 'date';
      case RadarrHistorySortKey.MOVIES_TITLE:
        return 'movies.sortTitle';
      case RadarrHistorySortKey.LANGUAGES:
        return 'languages';
      case RadarrHistorySortKey.QUALITY:
        return 'quality';
      default:
        return null;
    }
  }
}
