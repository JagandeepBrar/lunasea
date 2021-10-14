// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'episode_file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SonarrEpisodeFile _$SonarrEpisodeFileFromJson(Map<String, dynamic> json) =>
    SonarrEpisodeFile(
      seriesId: json['seriesId'] as int?,
      seasonNumber: json['seasonNumber'] as int?,
      relativePath: json['relativePath'] as String?,
      path: json['path'] as String?,
      size: json['size'] as int?,
      dateAdded: SonarrUtilities.dateTimeFromJson(json['dateAdded'] as String?),
      sceneName: json['sceneName'] as String?,
      quality: json['quality'] == null
          ? null
          : SonarrEpisodeFileQuality.fromJson(
              json['quality'] as Map<String, dynamic>),
      language: json['language'] == null
          ? null
          : SonarrEpisodeFileLanguage.fromJson(
              json['language'] as Map<String, dynamic>),
      mediaInfo: json['mediaInfo'] == null
          ? null
          : SonarrEpisodeFileMediaInfo.fromJson(
              json['mediaInfo'] as Map<String, dynamic>),
      originalFilePath: json['originalFilePath'] as String?,
      qualityCutoffNotMet: json['qualityCutoffNotMet'] as bool?,
      id: json['id'] as int?,
    );

Map<String, dynamic> _$SonarrEpisodeFileToJson(SonarrEpisodeFile instance) =>
    <String, dynamic>{
      'seriesId': instance.seriesId,
      'seasonNumber': instance.seasonNumber,
      'relativePath': instance.relativePath,
      'path': instance.path,
      'size': instance.size,
      'dateAdded': SonarrUtilities.dateTimeToJson(instance.dateAdded),
      'sceneName': instance.sceneName,
      'quality': instance.quality?.toJson(),
      'language': instance.language?.toJson(),
      'mediaInfo': instance.mediaInfo?.toJson(),
      'originalFilePath': instance.originalFilePath,
      'qualityCutoffNotMet': instance.qualityCutoffNotMet,
      'id': instance.id,
    };
