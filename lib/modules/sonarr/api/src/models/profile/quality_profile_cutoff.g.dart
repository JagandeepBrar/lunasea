// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quality_profile_cutoff.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SonarrQualityProfileCutoff _$SonarrQualityProfileCutoffFromJson(
        Map<String, dynamic> json) =>
    SonarrQualityProfileCutoff(
      id: json['id'] as int?,
      name: json['name'] as String?,
      source: json['source'] as String?,
      resolution: json['resolution'] as int?,
    );

Map<String, dynamic> _$SonarrQualityProfileCutoffToJson(
    SonarrQualityProfileCutoff instance) {
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
