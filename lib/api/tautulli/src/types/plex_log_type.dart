part of tautulli_types;

/// Enumerator to handle all Plex log types available in Tautulli.
enum TautulliPlexLogType {
  SERVER,
  SCANNER,
  NULL,
}

/// Extension on [TautulliPlexLogType] to implement extended functionality.
extension TautulliPlexLogTypeExtension on TautulliPlexLogType {
  /// The actual value/key for the Plex log type in Tautulli.
  String? get value {
    switch (this) {
      case TautulliPlexLogType.SERVER:
        return 'server';
      case TautulliPlexLogType.SCANNER:
        return 'scanner';
      case TautulliPlexLogType.NULL:
        return '';
    }
  }
}
