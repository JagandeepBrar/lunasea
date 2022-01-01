// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'episode_file_quality_quality.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SonarrEpisodeFileQualityQuality _$SonarrEpisodeFileQualityQualityFromJson(
        Map<String, dynamic> json) =>
    SonarrEpisodeFileQualityQuality(
      id: json['id'] as int?,
      name: json['name'] as String?,
      source: json['source'] as String?,
      resolution: json['resolution'] as int?,
    );

Map<String, dynamic> _$SonarrEpisodeFileQualityQualityToJson(
    SonarrEpisodeFileQualityQuality instance) {
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
