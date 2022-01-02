// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quality.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RadarrQuality _$RadarrQualityFromJson(Map<String, dynamic> json) {
  return RadarrQuality(
    id: json['id'] as int?,
    name: json['name'] as String?,
    source: json['source'] as String?,
    resolution: json['resolution'] as int?,
    modifier: json['modifier'] as String?,
  );
}

Map<String, dynamic> _$RadarrQualityToJson(RadarrQuality instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  writeNotNull('source', instance.source);
  writeNotNull('resolution', instance.resolution);
  writeNotNull('modifier', instance.modifier);
  return val;
}
