// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'episode_file_quality.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SonarrEpisodeFileQuality _$SonarrEpisodeFileQualityFromJson(
        Map<String, dynamic> json) =>
    SonarrEpisodeFileQuality(
      quality: json['quality'] == null
          ? null
          : SonarrEpisodeFileQualityQuality.fromJson(
              json['quality'] as Map<String, dynamic>),
      revision: json['revision'] == null
          ? null
          : SonarrEpisodeFileQualityRevision.fromJson(
              json['revision'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SonarrEpisodeFileQualityToJson(
        SonarrEpisodeFileQuality instance) =>
    <String, dynamic>{
      'quality': instance.quality?.toJson(),
      'revision': instance.revision?.toJson(),
    };
