part of tautulli_types;

/// Enumerator to handle all newsletter log order columns used in Tautulli.
enum TautulliNewsletterLogOrderColumn {
  TIMESTAMP,
  NEWSLETTER_ID,
  AGENT_NAME,
  NOTIFY_ACTION,
  SUBJECT_TEXT,
  START_DATE,
  END_DATE,
  UUID,
  NULL,
}

/// Extension on [TautulliNewsletterLogOrderColumn] to implement extended functionality.
extension TautulliNewsletterLogOrderColumnExtension
    on TautulliNewsletterLogOrderColumn {
  /// The actual value/key for newsletter log order column used in Tautulli.
  String? get value {
    switch (this) {
      case TautulliNewsletterLogOrderColumn.TIMESTAMP:
        return 'timestamp';
      case TautulliNewsletterLogOrderColumn.NEWSLETTER_ID:
        return 'newsletter_id';
      case TautulliNewsletterLogOrderColumn.AGENT_NAME:
        return 'agent_name';
      case TautulliNewsletterLogOrderColumn.NOTIFY_ACTION:
        return 'notify_action';
      case TautulliNewsletterLogOrderColumn.SUBJECT_TEXT:
        return 'subject_text';
      case TautulliNewsletterLogOrderColumn.START_DATE:
        return 'start_date';
      case TautulliNewsletterLogOrderColumn.END_DATE:
        return 'end_date';
      case TautulliNewsletterLogOrderColumn.UUID:
        return 'uuid';
      case TautulliNewsletterLogOrderColumn.NULL:
        return '';
    }
  }
}
