part of tautulli_types;

/// Enumerator to handle all session locations used in Tautulli.
enum TautulliSessionLocation {
  LAN,
  WAN,
  NULL,
}

/// Extension on [TautulliSessionLocation] to implement extended functionality.
extension TautulliSessionLocationExtension on TautulliSessionLocation {
  /// Given a String, will return the correct `TautulliSessionLocation` object.
  TautulliSessionLocation? from(String? location) {
    switch (location) {
      case 'lan':
        return TautulliSessionLocation.LAN;
      case 'wan':
        return TautulliSessionLocation.WAN;
      case '':
        return TautulliSessionLocation.NULL;
    }
    return null;
  }

  /// The actual value/key for session locations used in Tautulli.
  String? get value {
    switch (this) {
      case TautulliSessionLocation.LAN:
        return 'lan';
      case TautulliSessionLocation.WAN:
        return 'wan';
      case TautulliSessionLocation.NULL:
        return '';
    }
  }
}
