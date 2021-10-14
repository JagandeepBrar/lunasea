part of overseerr_types;

enum OverseerrMediaType {
  MOVIE,
  TV,
}

/// Extension on [OverseerrMediaType] to implement extended functionality.
extension OverseerrMediaTypeExtension on OverseerrMediaType {
  OverseerrMediaType? from(String? type) {
    switch (type) {
      case 'movie':
        return OverseerrMediaType.MOVIE;
      case 'tv':
        return OverseerrMediaType.TV;
      default:
        return null;
    }
  }

  String get value {
    switch (this) {
      case OverseerrMediaType.MOVIE:
        return 'movie';
      case OverseerrMediaType.TV:
        return 'tv';
    }
  }
}
