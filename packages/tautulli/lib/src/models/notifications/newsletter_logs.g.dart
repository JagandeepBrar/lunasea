// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'newsletter_logs.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TautulliNewsletterLogs _$TautulliNewsletterLogsFromJson(
    Map<String, dynamic> json) {
  return TautulliNewsletterLogs(
    recordsFiltered:
        TautulliUtilities.ensureIntegerFromJson(json['recordsFiltered']),
    recordsTotal: TautulliUtilities.ensureIntegerFromJson(json['recordsTotal']),
    draw: TautulliUtilities.ensureIntegerFromJson(json['draw']),
    logs: TautulliNewsletterLogs._logsFromJson(json['data'] as List),
  );
}

Map<String, dynamic> _$TautulliNewsletterLogsToJson(
        TautulliNewsletterLogs instance) =>
    <String, dynamic>{
      'recordsFiltered': instance.recordsFiltered,
      'recordsTotal': instance.recordsTotal,
      'draw': instance.draw,
      'data': TautulliNewsletterLogs._logsToJson(instance.logs),
    };
