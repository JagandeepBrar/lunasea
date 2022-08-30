part of radarr_types;

enum RadarrSortDirection {
  ASCENDING,
  DESCENDING,
}

/// Extension on [RadarrSortDirection] to implement extended functionality.
extension RadarrSortDirectionExtension on RadarrSortDirection {
  /// Given a String, will return the correct `RadarrSortDirection` object.
  RadarrSortDirection? from(String? type) {
    switch (type) {
      case 'ascending':
        return RadarrSortDirection.ASCENDING;
      case 'descending':
        return RadarrSortDirection.DESCENDING;
      default:
        return null;
    }
  }

  /// The actual value/key for sorting directions used in Radarr.
  String? get value {
    switch (this) {
      case RadarrSortDirection.ASCENDING:
        return 'ascending';
      case RadarrSortDirection.DESCENDING:
        return 'descending';
      default:
        return null;
    }
  }
}
