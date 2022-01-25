part of tautulli_types;

/// Enumerator to handle all user order columns used in Tautulli.
enum TautulliUsersOrderColumn {
  USER_THUMB,
  FRIENDLY_NAME,
  LAST_SEEN,
  IP_ADDRESS,
  PLATFORM,
  PLAYER,
  LAST_PLAYED,
  PLAYS,
  DURATION,
  NULL,
}

/// Extension on [TautulliUsersOrderColumn] to implement extended functionality.
extension TautulliUsersOrderColumnExtension on TautulliUsersOrderColumn {
  /// The actual value/key for the users order column used in Tautulli.
  String? get value {
    switch (this) {
      case TautulliUsersOrderColumn.USER_THUMB:
        return 'user_thumb';
      case TautulliUsersOrderColumn.FRIENDLY_NAME:
        return 'friendly_name';
      case TautulliUsersOrderColumn.LAST_SEEN:
        return 'last_seen';
      case TautulliUsersOrderColumn.IP_ADDRESS:
        return 'ip_address';
      case TautulliUsersOrderColumn.PLATFORM:
        return 'platform';
      case TautulliUsersOrderColumn.PLAYER:
        return 'player';
      case TautulliUsersOrderColumn.LAST_PLAYED:
        return 'last_played';
      case TautulliUsersOrderColumn.PLAYS:
        return 'plays';
      case TautulliUsersOrderColumn.DURATION:
        return 'duration';
      case TautulliUsersOrderColumn.NULL:
        return '';
    }
  }
}
