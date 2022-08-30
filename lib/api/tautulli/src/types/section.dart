part of tautulli_types;

/// Enumerator to handle all section types used in Tautulli.
enum TautulliSectionType {
  MOVIE,
  SHOW,
  ARTIST,
  PHOTO,
  NULL,
}

/// Extension on [TautulliSectionType] to implement extended functionality.
extension TautulliSectionTypeExtension on TautulliSectionType {
  /// Given a String, will return the correct `TautulliSectionType` object.
  TautulliSectionType? from(String? type) {
    switch (type) {
      case 'movie':
        return TautulliSectionType.MOVIE;
      case 'show':
        return TautulliSectionType.SHOW;
      case 'artist':
        return TautulliSectionType.ARTIST;
      case 'photo':
        return TautulliSectionType.PHOTO;
      case '':
        return TautulliSectionType.NULL;
    }
    return null;
  }

  /// The actual value/key for section types used in Tautulli.
  String? get value {
    switch (this) {
      case TautulliSectionType.MOVIE:
        return 'movie';
      case TautulliSectionType.SHOW:
        return 'show';
      case TautulliSectionType.ARTIST:
        return 'artist';
      case TautulliSectionType.PHOTO:
        return 'photo';
      case TautulliSectionType.NULL:
        return '';
    }
  }
}
