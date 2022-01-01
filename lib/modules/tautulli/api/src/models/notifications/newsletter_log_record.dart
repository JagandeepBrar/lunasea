import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

part 'newsletter_log_record.g.dart';

/// Model to store an individual newsletter log details from Tautulli.
@JsonSerializable(explicitToJson: true)
class TautulliNewsletterLogRecord {
  /// ID.
  @JsonKey(name: 'id', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? id;

  /// Timestamp for when the newsletter was sent.
  @JsonKey(
      name: 'timestamp',
      fromJson: TautulliUtilities.millisecondsDateTimeFromJson)
  final DateTime? timestamp;

  /// End date (of content) of the newsletter.
  @JsonKey(name: 'end_date', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? endDate;

  /// Start date (of content) of the newsletter.
  @JsonKey(name: 'start_date', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? startDate;

  /// UUID of the newsletter.
  @JsonKey(name: 'uuid', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? uuid;

  /// newsletter ID.
  @JsonKey(
      name: 'newsletter_id', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? newsletterId;

  /// Agent ID for the newsletter.
  @JsonKey(name: 'agent_id', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? agentId;

  /// Agent name for the newsletter.
  @JsonKey(name: 'agent_name', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? agentName;

  /// Notification action that triggered the newsletter.
  @JsonKey(
      name: 'notify_action', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? notifyAction;

  /// Subject text of the newsletter.
  @JsonKey(
      name: 'subject_text', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? subjectText;

  /// Body text of the newsletter.
  @JsonKey(name: 'body_text', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? bodyText;

  /// Was the newsletter successfully sent?
  @JsonKey(name: 'success', fromJson: TautulliUtilities.ensureBooleanFromJson)
  final bool? success;

  TautulliNewsletterLogRecord({
    this.id,
    this.timestamp,
    this.endDate,
    this.startDate,
    this.uuid,
    this.newsletterId,
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

  /// Deserialize a JSON map to a [TautulliNewsletterLogRecord] object.
  factory TautulliNewsletterLogRecord.fromJson(Map<String, dynamic> json) =>
      _$TautulliNewsletterLogRecordFromJson(json);

  /// Serialize a [TautulliNewsletterLogRecord] object to a JSON map.
  Map<String, dynamic> toJson() => _$TautulliNewsletterLogRecordToJson(this);
}
