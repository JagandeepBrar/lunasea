part of tautulli_types;

/// Enumerator to handle all user IP address order columns used in Tautulli.
enum TautulliUserIPsOrderColumn {
  LAST_SEEN,
  FIRST_SEEN,
  IP_ADDRESS,
  PLATFORM,
  PLAYER,
  LAST_PLAYED,
  PLAY_COUNT,
  NULL,
}

/// Extension on [TautulliUserIPsOrderColumn] to implement extended functionality.
extension TautulliUserIPsOrderColumnExtension on TautulliUserIPsOrderColumn {
  /// The actual value/key for the user IP address order columns used in Tautulli.
  String? get value {
    switch (this) {
      case TautulliUserIPsOrderColumn.LAST_SEEN:
        return 'last_seen';
      case TautulliUserIPsOrderColumn.FIRST_SEEN:
        return 'first_seen';
      case TautulliUserIPsOrderColumn.IP_ADDRESS:
        return 'ip_address';
      case TautulliUserIPsOrderColumn.PLATFORM:
        return 'platform';
      case TautulliUserIPsOrderColumn.PLAYER:
        return 'player';
      case TautulliUserIPsOrderColumn.LAST_PLAYED:
        return 'last_played';
      case TautulliUserIPsOrderColumn.PLAY_COUNT:
        return 'play_count';
      case TautulliUserIPsOrderColumn.NULL:
        return '';
    }
  }
}
