part of readarr_types;

enum ReadarrSortDirection {
  ASCENDING,
  DESCENDING,
}

/// Extension on [ReadarrSortDirection] to implement extended functionality.
extension ReadarrSortDirectionExtension on ReadarrSortDirection {
  /// The actual value/key for sorting directions used in Readarr.
  String? get value {
    switch (this) {
      case ReadarrSortDirection.ASCENDING:
        return 'ascending';
      case ReadarrSortDirection.DESCENDING:
        return 'descending';
      default:
        return null;
    }
  }
}
