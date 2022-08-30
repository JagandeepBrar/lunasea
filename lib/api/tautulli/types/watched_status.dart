part of tautulli_types;

/// Enumerator to handle all watched statuses in Tautulli.
enum TautulliWatchedStatus {
  UNWATCHED,
  PARTIALLY_WATCHED,
  WATCHED,
}

/// Extension on [TautulliWatchedStatus] to implement extended functionality.
extension TautulliWatchedStatusExtension on TautulliWatchedStatus {
  /// Given a double, will return the correct `TautulliWatchedStatus` object.
  TautulliWatchedStatus? from(num? watched) {
    // Have to use if statements here because Dart doesn't like switch statements with dobules :/
    if (watched == 0) return TautulliWatchedStatus.UNWATCHED;
    if (watched == 0.5) return TautulliWatchedStatus.PARTIALLY_WATCHED;
    if (watched == 1) return TautulliWatchedStatus.WATCHED;
    return null;
  }

  /// The actual value/key for the API lookup service in Tautulli.
  double? get value {
    switch (this) {
      case TautulliWatchedStatus.UNWATCHED:
        return 0;
      case TautulliWatchedStatus.PARTIALLY_WATCHED:
        return 0.5;
      case TautulliWatchedStatus.WATCHED:
        return 1;
    }
  }
}
