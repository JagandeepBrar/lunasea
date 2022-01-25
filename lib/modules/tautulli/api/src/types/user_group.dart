part of tautulli_types;

/// Enumerator to handle all user groups used in Tautulli.
enum TautulliUserGroup {
  ADMIN,
  GUEST,
  NULL,
}

/// Extension on [TautulliUserGroup] to implement extended functionality.
extension TautulliUserGroupExtension on TautulliUserGroup {
  /// Given a String, will return the correct `TautulliUserGroup` object.
  TautulliUserGroup? from(String? key) {
    switch (key) {
      case 'admin':
        return TautulliUserGroup.ADMIN;
      case 'guest':
        return TautulliUserGroup.GUEST;
      case '':
        return TautulliUserGroup.NULL;
    }
    return null;
  }

  /// The actual value/key for the user group used in Tautulli.
  String? get value {
    switch (this) {
      case TautulliUserGroup.ADMIN:
        return 'admin';
      case TautulliUserGroup.GUEST:
        return 'guest';
      case TautulliUserGroup.NULL:
        return '';
    }
  }
}
