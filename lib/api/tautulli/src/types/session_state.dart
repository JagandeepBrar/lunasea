part of tautulli_types;

/// Enumerator to handle all session states used in Tautulli.
enum TautulliSessionState {
  PLAYING,
  PAUSED,
  BUFFERING,
  NULL,
}

/// Extension on [TautulliSessionState] to implement extended functionality.
extension TautulliSessionStateExtension on TautulliSessionState {
  /// Given a String, will return the correct `TautulliSessionState` object.
  TautulliSessionState? from(String? state) {
    switch (state) {
      case 'playing':
        return TautulliSessionState.PLAYING;
      case 'buffering':
        return TautulliSessionState.BUFFERING;
      case 'paused':
        return TautulliSessionState.PAUSED;
      case '':
        return TautulliSessionState.NULL;
    }
    return null;
  }

  /// The actual value/key for session states used in Tautulli.
  String? get value {
    switch (this) {
      case TautulliSessionState.PLAYING:
        return 'playing';
      case TautulliSessionState.PAUSED:
        return 'paused';
      case TautulliSessionState.BUFFERING:
        return 'buffering';
      case TautulliSessionState.NULL:
        return '';
    }
  }
}
