part of overseerr_types;

enum OverseerrUserSortType {
  CREATED,
  DISPLAY_NAME,
  REQUESTS,
  UPDATED,
}

/// Extension on [OverseerrUserSortType] to implement extended functionality.
extension OverseerrUserSortTypeExtension on OverseerrUserSortType {
  OverseerrUserSortType? from(String? type) {
    switch (type) {
      case 'created':
        return OverseerrUserSortType.CREATED;
      case 'displayname':
        return OverseerrUserSortType.DISPLAY_NAME;
      case 'requests':
        return OverseerrUserSortType.REQUESTS;
      case 'updated':
        return OverseerrUserSortType.UPDATED;
      default:
        return null;
    }
  }

  String get value {
    switch (this) {
      case OverseerrUserSortType.CREATED:
        return 'created';
      case OverseerrUserSortType.DISPLAY_NAME:
        return 'displayname';
      case OverseerrUserSortType.REQUESTS:
        return 'requests';
      case OverseerrUserSortType.UPDATED:
        return 'updated';
    }
  }
}
