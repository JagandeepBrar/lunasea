part of tautulli_types;

/// Enumerator to handle all order directions used in Tautulli.
enum TautulliOrderDirection {
  ASCENDING,
  DESCENDING,
  NULL,
}

/// Extension on [TautulliOrderDirection] to implement extended functionality.
extension TautulliOrderDirectionExtension on TautulliOrderDirection {
  /// The actual value/key for order directions used in Tautulli.
  String? get value {
    switch (this) {
      case TautulliOrderDirection.ASCENDING:
        return 'asc';
      case TautulliOrderDirection.DESCENDING:
        return 'desc';
      case TautulliOrderDirection.NULL:
        return '';
    }
  }
}
