// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'newsletter_log_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TautulliNewsletterLogRecord _$TautulliNewsletterLogRecordFromJson(
    Map<String, dynamic> json) {
  return TautulliNewsletterLogRecord(
    id: TautulliUtilities.ensureIntegerFromJson(json['id']),
    timestamp:
        TautulliUtilities.millisecondsDateTimeFromJson(json['timestamp']),
    endDate: TautulliUtilities.ensureStringFromJson(json['end_date']),
    startDate: TautulliUtilities.ensureStringFromJson(json['start_date']),
    uuid: TautulliUtilities.ensureStringFromJson(json['uuid']),
    newsletterId:
        TautulliUtilities.ensureIntegerFromJson(json['newsletter_id']),
    agentId: TautulliUtilities.ensureIntegerFromJson(json['agent_id']),
    agentName: TautulliUtilities.ensureStringFromJson(json['agent_name']),
    notifyAction: TautulliUtilities.ensureStringFromJson(json['notify_action']),
    subjectText: TautulliUtilities.ensureStringFromJson(json['subject_text']),
    bodyText: TautulliUtilities.ensureStringFromJson(json['body_text']),
    success: TautulliUtilities.ensureBooleanFromJson(json['success']),
  );
}

Map<String, dynamic> _$TautulliNewsletterLogRecordToJson(
        TautulliNewsletterLogRecord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'timestamp': instance.timestamp?.toIso8601String(),
      'end_date': instance.endDate,
      'start_date': instance.startDate,
      'uuid': instance.uuid,
      'newsletter_id': instance.newsletterId,
      'agent_id': instance.agentId,
      'agent_name': instance.agentName,
      'notify_action': instance.notifyAction,
      'subject_text': instance.subjectText,
      'body_text': instance.bodyText,
      'success': instance.success,
    };
