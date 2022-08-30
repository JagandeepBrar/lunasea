part of tautulli_types;

/// Enumerator to handle all API lookup services available in Tautulli.
enum TautulliAPILookupService {
  THEMOVIEDB,
  TVMAZE,
  MUSICBRAINZ,
  NULL,
}

/// Extension on [TautulliAPILookupService] to implement extended functionality.
extension TautulliAPILookupServiceExtension on TautulliAPILookupService {
  /// The actual value/key for the API lookup service in Tautulli.
  String? get value {
    switch (this) {
      case TautulliAPILookupService.THEMOVIEDB:
        return 'themoviedb';
      case TautulliAPILookupService.TVMAZE:
        return 'tvmaze';
      case TautulliAPILookupService.MUSICBRAINZ:
        return 'musicbrainz';
      case TautulliAPILookupService.NULL:
        return '';
    }
  }
}
