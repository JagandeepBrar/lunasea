// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'queue_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RadarrQueueStatus _$RadarrQueueStatusFromJson(Map<String, dynamic> json) {
  return RadarrQueueStatus(
    totalCount: json['totalCount'] as int?,
    count: json['count'] as int?,
    unknownCount: json['unknownCount'] as int?,
    errors: json['errors'] as bool?,
    warnings: json['warnings'] as bool?,
    unknownErrors: json['unknownErrors'] as bool?,
    unknownWarnings: json['unknownWarnings'] as bool?,
  );
}

Map<String, dynamic> _$RadarrQueueStatusToJson(RadarrQueueStatus instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('totalCount', instance.totalCount);
  writeNotNull('count', instance.count);
  writeNotNull('unknownCount', instance.unknownCount);
  writeNotNull('errors', instance.errors);
  writeNotNull('warnings', instance.warnings);
  writeNotNull('unknownErrors', instance.unknownErrors);
  writeNotNull('unknownWarnings', instance.unknownWarnings);
  return val;
}
