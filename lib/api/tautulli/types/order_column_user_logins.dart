part of tautulli_types;

/// Enumerator to handle all user login order columns used in Tautulli.
enum TautulliUserLoginsOrderColumn {
  DATE,
  TIME,
  IP_ADDRESS,
  HOST,
  OS,
  BROWSER,
  NULL,
}

/// Extension on [TautulliUserLoginsOrderColumn] to implement extended functionality.
extension TautulliUserLoginsOrderColumnExtension
    on TautulliUserLoginsOrderColumn {
  /// The actual value/key for the user login order columns used in Tautulli.
  String? get value {
    switch (this) {
      case TautulliUserLoginsOrderColumn.DATE:
        return 'date';
      case TautulliUserLoginsOrderColumn.TIME:
        return 'time';
      case TautulliUserLoginsOrderColumn.IP_ADDRESS:
        return 'ip_address';
      case TautulliUserLoginsOrderColumn.HOST:
        return 'host';
      case TautulliUserLoginsOrderColumn.OS:
        return 'os';
      case TautulliUserLoginsOrderColumn.BROWSER:
        return 'browser';
      case TautulliUserLoginsOrderColumn.NULL:
        return '';
    }
  }
}
