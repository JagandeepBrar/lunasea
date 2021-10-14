// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health_check.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RadarrHealthCheck _$RadarrHealthCheckFromJson(Map<String, dynamic> json) {
  return RadarrHealthCheck(
    source: json['source'] as String?,
    type: RadarrUtilities.healthCheckTypeFromJson(json['type'] as String?),
    message: json['message'] as String?,
    wikiUrl: json['wikiUrl'] as String?,
  );
}

Map<String, dynamic> _$RadarrHealthCheckToJson(RadarrHealthCheck instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('source', instance.source);
  writeNotNull('type', RadarrUtilities.healthCheckTypeToJson(instance.type));
  writeNotNull('message', instance.message);
  writeNotNull('wikiUrl', instance.wikiUrl);
  return val;
}
