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
      releaseGroup: json['releaseGroup'] as String?,
      language: json['language'] == null
          ? null
          : SonarrEpisodeFileLanguage.fromJson(
              json['language'] as Map<String, dynamic>),
      quality: json['quality'] == null
          ? null
          : SonarrEpisodeFileQuality.fromJson(
              json['quality'] as Map<String, dynamic>),
      mediaInfo: json['mediaInfo'] == null
          ? null
          : SonarrEpisodeFileMediaInfo.fromJson(
              json['mediaInfo'] as Map<String, dynamic>),
      qualityCutoffNotMet: json['qualityCutoffNotMet'] as bool?,
      languageCutoffNotMet: json['languageCutoffNotMet'] as bool?,
      id: json['id'] as int?,
    );

Map<String, dynamic> _$SonarrEpisodeFileToJson(SonarrEpisodeFile instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('seriesId', instance.seriesId);
  writeNotNull('seasonNumber', instance.seasonNumber);
  writeNotNull('relativePath', instance.relativePath);
  writeNotNull('path', instance.path);
  writeNotNull('size', instance.size);
  writeNotNull('dateAdded', SonarrUtilities.dateTimeToJson(instance.dateAdded));
  writeNotNull('sceneName', instance.sceneName);
  writeNotNull('releaseGroup', instance.releaseGroup);
  writeNotNull('language', instance.language?.toJson());
  writeNotNull('quality', instance.quality?.toJson());
  writeNotNull('mediaInfo', instance.mediaInfo?.toJson());
  writeNotNull('qualityCutoffNotMet', instance.qualityCutoffNotMet);
  writeNotNull('languageCutoffNotMet', instance.languageCutoffNotMet);
  writeNotNull('id', instance.id);
  return val;
}
