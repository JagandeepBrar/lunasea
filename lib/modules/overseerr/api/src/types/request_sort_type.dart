part of overseerr_types;

enum OverseerrRequestSortType {
  ADDED,
  MODIFIED,
}

/// Extension on [OverseerrRequestSortType] to implement extended functionality.
extension OverseerrRequestSortTypeExtension on OverseerrRequestSortType {
  OverseerrRequestSortType? from(String? type) {
    switch (type) {
      case 'added':
        return OverseerrRequestSortType.ADDED;
      case 'modified':
        return OverseerrRequestSortType.MODIFIED;
      default:
        return null;
    }
  }

  String get value {
    switch (this) {
      case OverseerrRequestSortType.ADDED:
        return 'added';
      case OverseerrRequestSortType.MODIFIED:
        return 'modified';
    }
  }
}
