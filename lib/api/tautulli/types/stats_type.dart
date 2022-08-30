part of tautulli_types;

/// Enumerator to handle all statistic types for home stats.
enum TautulliStatsType {
  PLAYS,
  DURATION,
}

/// Extension on [TautulliStatsType] to implement extended functionality.
extension TautulliStatsTypeExtension on TautulliStatsType {
  /// The actual value/key for the statistic type value in Tautulli.
  String? get value {
    switch (this) {
      case TautulliStatsType.PLAYS:
        return 'plays';
      case TautulliStatsType.DURATION:
        return 'duration';
    }
  }
}
