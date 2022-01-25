part of tautulli_types;

/// Enumerator to handle all graph Y-axis values available in Tautulli.
enum TautulliGraphYAxis {
  PLAYS,
  DURATION,
  NULL,
}

/// Extension on [TautulliGraphYAxis] to implement extended functionality.
extension TautulliGraphYAxisExtension on TautulliGraphYAxis {
  /// The actual value/key for the graph Y-axis value in Tautulli.
  String? get value {
    switch (this) {
      case TautulliGraphYAxis.PLAYS:
        return 'plays';
      case TautulliGraphYAxis.DURATION:
        return 'duration';
      case TautulliGraphYAxis.NULL:
        return '';
    }
  }
}
