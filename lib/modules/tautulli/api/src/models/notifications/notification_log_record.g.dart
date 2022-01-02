// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_log_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TautulliNotificationLogRecord _$TautulliNotificationLogRecordFromJson(
    Map<String, dynamic> json) {
  return TautulliNotificationLogRecord(
    id: TautulliUtilities.ensureIntegerFromJson(json['id']),
    timestamp:
        TautulliUtilities.millisecondsDateTimeFromJson(json['timestamp']),
    sessionKey: TautulliUtilities.ensureIntegerFromJson(json['session_key']),
    ratingKey: TautulliUtilities.ensureIntegerFromJson(json['rating_key']),
    userId: TautulliUtilities.ensureIntegerFromJson(json['user_id']),
    user: TautulliUtilities.ensureStringFromJson(json['user']),
    notifierId: TautulliUtilities.ensureIntegerFromJson(json['notifier_id']),
    agentId: TautulliUtilities.ensureIntegerFromJson(json['agent_id']),
    agentName: TautulliUtilities.ensureStringFromJson(json['agent_name']),
    notifyAction: TautulliUtilities.ensureStringFromJson(json['notify_action']),
    subjectText: TautulliUtilities.ensureStringFromJson(json['subject_text']),
    bodyText: TautulliUtilities.ensureStringFromJson(json['body_text']),
    success: TautulliUtilities.ensureBooleanFromJson(json['success']),
  );
}

Map<String, dynamic> _$TautulliNotificationLogRecordToJson(
        TautulliNotificationLogRecord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'timestamp': instance.timestamp?.toIso8601String(),
      'session_key': instance.sessionKey,
      'rating_key': instance.ratingKey,
      'user_id': instance.userId,
      'user': instance.user,
      'notifier_id': instance.notifierId,
      'agent_id': instance.agentId,
      'agent_name': instance.agentName,
      'notify_action': instance.notifyAction,
      'subject_text': instance.subjectText,
      'body_text': instance.bodyText,
      'success': instance.success,
    };
