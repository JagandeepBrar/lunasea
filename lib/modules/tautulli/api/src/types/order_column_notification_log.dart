part of tautulli_types;

/// Enumerator to handle all notification log order columns used in Tautulli.
enum TautulliNotificationLogOrderColumn {
  TIMESTAMP,
  NOTIFIER_ID,
  AGENT_NAME,
  NOTIFY_ACTION,
  SUBJECT_TEXT,
  BODY_TEXT,
  NULL,
}

/// Extension on [TautulliNotificationLogOrderColumn] to implement extended functionality.
extension TautulliNotificationLogOrderColumnExtension
    on TautulliNotificationLogOrderColumn {
  /// The actual value/key for notification log order column used in Tautulli.
  String? get value {
    switch (this) {
      case TautulliNotificationLogOrderColumn.TIMESTAMP:
        return 'timestamp';
      case TautulliNotificationLogOrderColumn.NOTIFIER_ID:
        return 'notifier_id';
      case TautulliNotificationLogOrderColumn.AGENT_NAME:
        return 'agent_name';
      case TautulliNotificationLogOrderColumn.NOTIFY_ACTION:
        return 'notify_action';
      case TautulliNotificationLogOrderColumn.SUBJECT_TEXT:
        return 'subject_text';
      case TautulliNotificationLogOrderColumn.BODY_TEXT:
        return 'body_text';
      case TautulliNotificationLogOrderColumn.NULL:
        return '';
    }
  }
}
