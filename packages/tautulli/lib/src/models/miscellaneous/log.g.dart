// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TautulliLog _$TautulliLogFromJson(Map<String, dynamic> json) {
  return TautulliLog(
    timestamp: TautulliUtilities.ensureStringFromJson(json['time']),
    level: TautulliUtilities.ensureStringFromJson(json['loglevel']),
    message: TautulliUtilities.ensureStringFromJson(json['msg']),
    thread: TautulliUtilities.ensureStringFromJson(json['thread']),
  );
}

Map<String, dynamic> _$TautulliLogToJson(TautulliLog instance) =>
    <String, dynamic>{
      'loglevel': instance.level,
      'time': instance.timestamp,
      'msg': instance.message,
      'thread': instance.thread,
    };
