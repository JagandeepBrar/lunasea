// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_logs.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TautulliNotificationLogs _$TautulliNotificationLogsFromJson(
    Map<String, dynamic> json) {
  return TautulliNotificationLogs(
    recordsFiltered:
        TautulliUtilities.ensureIntegerFromJson(json['recordsFiltered']),
    recordsTotal: TautulliUtilities.ensureIntegerFromJson(json['recordsTotal']),
    draw: TautulliUtilities.ensureIntegerFromJson(json['draw']),
    logs: TautulliNotificationLogs._logsFromJson(json['data'] as List),
  );
}

Map<String, dynamic> _$TautulliNotificationLogsToJson(
        TautulliNotificationLogs instance) =>
    <String, dynamic>{
      'recordsFiltered': instance.recordsFiltered,
      'recordsTotal': instance.recordsTotal,
      'draw': instance.draw,
      'data': TautulliNotificationLogs._logsToJson(instance.logs),
    };
