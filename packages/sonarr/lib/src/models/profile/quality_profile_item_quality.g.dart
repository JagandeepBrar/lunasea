// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quality_profile_item_quality.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SonarrQualityProfileItemQuality _$SonarrQualityProfileItemQualityFromJson(
        Map<String, dynamic> json) =>
    SonarrQualityProfileItemQuality(
      id: json['id'] as int?,
      name: json['name'] as String?,
      source: json['source'] as String?,
      resolution: json['resolution'] as int?,
    );

Map<String, dynamic> _$SonarrQualityProfileItemQualityToJson(
    SonarrQualityProfileItemQuality instance) {
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
  return val;
}
