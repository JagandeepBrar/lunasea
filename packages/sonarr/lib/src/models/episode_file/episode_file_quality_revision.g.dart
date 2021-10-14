// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'episode_file_quality_revision.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SonarrEpisodeFileQualityRevision _$SonarrEpisodeFileQualityRevisionFromJson(
        Map<String, dynamic> json) =>
    SonarrEpisodeFileQualityRevision(
      version: json['version'] as int?,
      real: json['real'] as int?,
      isRepack: json['isRepack'] as bool?,
    );

Map<String, dynamic> _$SonarrEpisodeFileQualityRevisionToJson(
        SonarrEpisodeFileQualityRevision instance) =>
    <String, dynamic>{
      'version': instance.version,
      'real': instance.real,
      'isRepack': instance.isRepack,
    };
