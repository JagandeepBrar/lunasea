import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

part 'notification_log_record.g.dart';

/// Model to store an individual notification log details from Tautulli.
@JsonSerializable(explicitToJson: true)
class TautulliNotificationLogRecord {
  /// ID of the notification.
  @JsonKey(name: 'id', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? id;

  /// Timestamp for when the notification was sent.
  @JsonKey(
      name: 'timestamp',
      fromJson: TautulliUtilities.millisecondsDateTimeFromJson)
  final DateTime? timestamp;

  /// Session key (if applicable).
  @JsonKey(
      name: 'session_key', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? sessionKey;

  /// Content rating key (if applicable).
  @JsonKey(
      name: 'rating_key', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? ratingKey;

  /// User's ID (if applicable).
  @JsonKey(name: 'user_id', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? userId;

  /// User's username (if applicable).
  @JsonKey(name: 'user', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? user;

  /// Notifier ID for the notifier that triggered the notification.
  @JsonKey(
      name: 'notifier_id', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? notifierId;

  /// Agent ID for the notifier.
  @JsonKey(name: 'agent_id', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? agentId;

  /// Agent name for the notifier.
  @JsonKey(name: 'agent_name', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? agentName;

  /// Notification action that triggered the notification.
  @JsonKey(
      name: 'notify_action', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? notifyAction;

  /// Subject text of the notification.
  @JsonKey(
      name: 'subject_text', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? subjectText;

  /// Body text of the notification.
  @JsonKey(name: 'body_text', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? bodyText;

  /// Was the notification successfully sent?
  @JsonKey(name: 'success', fromJson: TautulliUtilities.ensureBooleanFromJson)
  final bool? success;

  TautulliNotificationLogRecord({
    this.id,
    this.timestamp,
    this.sessionKey,
    this.ratingKey,
    this.userId,
    this.user,
    this.notifierId,
    this.agentId,
    this.agentName,
    this.notifyAction,
    this.subjectText,
    this.bodyText,
    this.success,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [TautulliNotificationLogRecord] object.
  factory TautulliNotificationLogRecord.fromJson(Map<String, dynamic> json) =>
      _$TautulliNotificationLogRecordFromJson(json);

  /// Serialize a [TautulliNotificationLogRecord] object to a JSON map.
  Map<String, dynamic> toJson() => _$TautulliNotificationLogRecordToJson(this);
}
