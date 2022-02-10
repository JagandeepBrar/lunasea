part of readarr_types;

enum ReadarrHistorySortKey {
  DATE,
  SERIES_TITLE,
}

/// Extension on [ReadarrHistorySortKey] to implement extended functionality.
extension ReadarrHistorySortKeyExtension on ReadarrHistorySortKey {
  /// Given a String, will return the correct `ReadarrHistorySortKey` object.
  ReadarrHistorySortKey? from(String? type) {
    switch (type) {
      case 'date':
        return ReadarrHistorySortKey.DATE;
      case 'series.title':
        return ReadarrHistorySortKey.SERIES_TITLE;
      default:
        return null;
    }
  }

  /// The actual value/key for sorting directions used in Readarr.
  String? get value {
    switch (this) {
      case ReadarrHistorySortKey.DATE:
        return 'date';
      case ReadarrHistorySortKey.SERIES_TITLE:
        return 'series.title';
      default:
        return null;
    }
  }
}
