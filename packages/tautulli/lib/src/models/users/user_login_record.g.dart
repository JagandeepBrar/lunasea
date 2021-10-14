// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_login_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TautulliUserLoginRecord _$TautulliUserLoginRecordFromJson(
    Map<String, dynamic> json) {
  return TautulliUserLoginRecord(
    timestamp:
        TautulliUtilities.millisecondsDateTimeFromJson(json['timestamp']),
    userId: TautulliUtilities.ensureIntegerFromJson(json['user_id']),
    userGroup:
        TautulliUtilities.userGroupFromJson(json['user_group'] as String?),
    ipAddress: TautulliUtilities.ensureStringFromJson(json['ip_address']),
    host: TautulliUtilities.ensureStringFromJson(json['host']),
    userAgent: TautulliUtilities.ensureStringFromJson(json['user_agent']),
    os: TautulliUtilities.ensureStringFromJson(json['os']),
    browser: TautulliUtilities.ensureStringFromJson(json['browser']),
    success: TautulliUtilities.ensureBooleanFromJson(json['success']),
    friendlyName: TautulliUtilities.ensureStringFromJson(json['friendly_name']),
  );
}

Map<String, dynamic> _$TautulliUserLoginRecordToJson(
        TautulliUserLoginRecord instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp?.toIso8601String(),
      'user_id': instance.userId,
      'user_group': TautulliUtilities.userGroupToJson(instance.userGroup),
      'ip_address': instance.ipAddress,
      'host': instance.host,
      'user_agent': instance.userAgent,
      'os': instance.os,
      'browser': instance.browser,
      'success': instance.success,
      'friendly_name': instance.friendlyName,
    };
