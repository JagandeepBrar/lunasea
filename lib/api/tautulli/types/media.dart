part of tautulli_types;

/// Enumerator to handle all media types used in Tautulli.
enum TautulliMediaType {
  MOVIE,
  SHOW,
  SEASON,
  EPISODE,
  ARTIST,
  ALBUM,
  TRACK,
  PHOTO_ALBUM,
  PHOTO,
  CLIP,
  COLLECTION,
  PLAYLIST,
  LIVE,
  NULL;

  static TautulliMediaType from(String? type) {
    switch (type) {
      case 'movie':
        return TautulliMediaType.MOVIE;
      case 'show':
        return TautulliMediaType.SHOW;
      case 'season':
        return TautulliMediaType.SEASON;
      case 'episode':
        return TautulliMediaType.EPISODE;
      case 'artist':
        return TautulliMediaType.ARTIST;
      case 'album':
        return TautulliMediaType.ALBUM;
      case 'track':
        return TautulliMediaType.TRACK;
      case 'photoalbum':
        return TautulliMediaType.PHOTO_ALBUM;
      case 'photo':
        return TautulliMediaType.PHOTO;
      case 'clip':
        return TautulliMediaType.CLIP;
      case 'collection':
        return TautulliMediaType.COLLECTION;
      case 'playlist':
        return TautulliMediaType.PLAYLIST;
      case 'live':
        return TautulliMediaType.LIVE;
      default:
        return TautulliMediaType.NULL;
    }
  }

  /// The actual value/key for media types used in Tautulli.
  String get value {
    switch (this) {
      case TautulliMediaType.MOVIE:
        return 'movie';
      case TautulliMediaType.SHOW:
        return 'show';
      case TautulliMediaType.SEASON:
        return 'season';
      case TautulliMediaType.EPISODE:
        return 'episode';
      case TautulliMediaType.ARTIST:
        return 'artist';
      case TautulliMediaType.ALBUM:
        return 'album';
      case TautulliMediaType.TRACK:
        return 'track';
      case TautulliMediaType.PHOTO_ALBUM:
        return 'photoalbum';
      case TautulliMediaType.PHOTO:
        return 'photo';
      case TautulliMediaType.CLIP:
        return 'clip';
      case TautulliMediaType.COLLECTION:
        return 'collection';
      case TautulliMediaType.PLAYLIST:
        return 'playlist';
      case TautulliMediaType.LIVE:
        return 'live';
      default:
        return '';
    }
  }
}
