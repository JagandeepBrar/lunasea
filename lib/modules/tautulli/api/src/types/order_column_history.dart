part of tautulli_types;

/// Enumerator to handle all history order columns used in Tautulli.
enum TautulliHistoryOrderColumn {
  DATE,
  FRIENDLY_NAME,
  IP_ADDRESS,
  PLATFORM,
  PLAYER,
  FULL_TITLE,
  STARTED,
  PAUSED_COUNTER,
  STOPPED,
  DURATION,
  NULL,
}

/// Extension on [TautulliHistoryOrderColumn] to implement extended functionality.
extension TautulliHistoryOrderColumnExtension on TautulliHistoryOrderColumn {
  /// The actual value/key for history order column used in Tautulli.
  String? get value {
    switch (this) {
      case TautulliHistoryOrderColumn.DATE:
        return 'date';
      case TautulliHistoryOrderColumn.FRIENDLY_NAME:
        return 'friendly_name';
      case TautulliHistoryOrderColumn.IP_ADDRESS:
        return 'ip_address';
      case TautulliHistoryOrderColumn.PLATFORM:
        return 'platform';
      case TautulliHistoryOrderColumn.PLAYER:
        return 'player';
      case TautulliHistoryOrderColumn.FULL_TITLE:
        return 'full_title';
      case TautulliHistoryOrderColumn.STARTED:
        return 'started';
      case TautulliHistoryOrderColumn.PAUSED_COUNTER:
        return 'paused_counter';
      case TautulliHistoryOrderColumn.STOPPED:
        return 'stopped';
      case TautulliHistoryOrderColumn.DURATION:
        return 'duration';
      case TautulliHistoryOrderColumn.NULL:
        return '';
    }
  }
}
