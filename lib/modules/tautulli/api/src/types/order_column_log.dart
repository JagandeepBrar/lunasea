part of tautulli_types;

/// Enumerator to handle all log order columns used in Tautulli.
enum TautulliLogsOrderColumn {
  TIME,
  THREAD,
  MESSAGE,
  LEVEL,
  NULL,
}

/// Extension on [TautulliLogsOrderColumn] to implement extended functionality.
extension TautulliLogsOrderColumnExtension on TautulliLogsOrderColumn {
  /// The actual value/key for log order column used in Tautulli.
  String? get value {
    switch (this) {
      case TautulliLogsOrderColumn.TIME:
        return 'time';
      case TautulliLogsOrderColumn.THREAD:
        return 'thread';
      case TautulliLogsOrderColumn.MESSAGE:
        return 'msg';
      case TautulliLogsOrderColumn.LEVEL:
        return 'loglevel';
      case TautulliLogsOrderColumn.NULL:
        return '';
    }
  }
}
