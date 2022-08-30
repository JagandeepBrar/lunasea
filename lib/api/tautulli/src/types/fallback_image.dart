part of tautulli_types;

/// Enumerator to handle all fallback images available in Tautulli.
enum TautulliFallbackImage {
  POSTER,
  COVER,
  ART,
  POSTER_LIVE,
  ART_LIVE,
  ART_LIVE_FULL,
  NULL,
}

/// Extension on [TautulliFallbackImage] to implement extended functionality.
extension TautulliFallbackImageExtension on TautulliFallbackImage {
  /// The actual value/key for the fallback image in Tautulli.
  String? get value {
    switch (this) {
      case TautulliFallbackImage.POSTER:
        return 'poster';
      case TautulliFallbackImage.COVER:
        return 'cover';
      case TautulliFallbackImage.ART:
        return 'art';
      case TautulliFallbackImage.POSTER_LIVE:
        return 'poster-live';
      case TautulliFallbackImage.ART_LIVE:
        return 'art-live';
      case TautulliFallbackImage.ART_LIVE_FULL:
        return 'art-live-full';
      case TautulliFallbackImage.NULL:
        return '';
    }
  }
}
