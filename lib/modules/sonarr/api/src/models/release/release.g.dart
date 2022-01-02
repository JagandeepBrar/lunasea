// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'release.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SonarrRelease _$SonarrReleaseFromJson(Map<String, dynamic> json) =>
    SonarrRelease(
      guid: json['guid'] as String?,
      quality: json['quality'] == null
          ? null
          : SonarrEpisodeFileQuality.fromJson(
              json['quality'] as Map<String, dynamic>),
      qualityWeight: json['qualityWeight'] as int?,
      age: json['age'] as int?,
      ageHours: (json['ageHours'] as num?)?.toDouble(),
      ageMinutes: (json['ageMinutes'] as num?)?.toDouble(),
      size: json['size'] as int?,
      indexerId: json['indexerId'] as int?,
      indexer: json['indexer'] as String?,
      releaseGroup: json['releaseGroup'] as String?,
      releaseHash: json['releaseHash'] as String?,
      title: json['title'] as String?,
      fullSeason: json['fullSeason'] as bool?,
      sceneSource: json['sceneSource'] as bool?,
      seasonNumber: json['seasonNumber'] as int?,
      language: json['language'] == null
          ? null
          : SonarrLanguageProfile.fromJson(
              json['language'] as Map<String, dynamic>),
      languageWeight: json['languageWeight'] as int?,
      seriesTitle: json['seriesTitle'] as String?,
      episodeNumbers: (json['episodeNumbers'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
      absoluteEpisodeNumbers: (json['absoluteEpisodeNumbers'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
      mappedSeasonNumber: json['mappedSeasonNumber'] as int?,
      mappedEpisodeNumbers: (json['mappedEpisodeNumbers'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
      mappedAbsoluteEpisodeNumbers:
          (json['mappedAbsoluteEpisodeNumbers'] as List<dynamic>?)
              ?.map((e) => e as int)
              .toList(),
      approved: json['approved'] as bool?,
      temporarilyRejected: json['temporarilyRejected'] as bool?,
      rejected: json['rejected'] as bool?,
      tvdbId: json['tvdbId'] as int?,
      tvRageId: json['tvRageId'] as int?,
      rejections: (json['rejections'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      publishDate:
          SonarrUtilities.dateTimeFromJson(json['publishDate'] as String?),
      commentUrl: json['commentUrl'] as String?,
      downloadUrl: json['downloadUrl'] as String?,
      infoUrl: json['infoUrl'] as String?,
      episodeRequested: json['episodeRequested'] as bool?,
      downloadAllowed: json['downloadAllowed'] as bool?,
      releaseWeight: json['releaseWeight'] as int?,
      preferredWordScore: json['preferredWordScore'] as int?,
      protocol: SonarrUtilities.protocolFromJson(json['protocol'] as String?),
      isDaily: json['isDaily'] as bool?,
      isAbsoluteNumbering: json['isAbsoluteNumbering'] as bool?,
      isPossibleSpecialEpisode: json['isPossibleSpecialEpisode'] as bool?,
      special: json['special'] as bool?,
      leechers: json['leechers'] as int?,
      seeders: json['seeders'] as int?,
    );

Map<String, dynamic> _$SonarrReleaseToJson(SonarrRelease instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('guid', instance.guid);
  writeNotNull('quality', instance.quality?.toJson());
  writeNotNull('qualityWeight', instance.qualityWeight);
  writeNotNull('age', instance.age);
  writeNotNull('ageHours', instance.ageHours);
  writeNotNull('ageMinutes', instance.ageMinutes);
  writeNotNull('size', instance.size);
  writeNotNull('indexerId', instance.indexerId);
  writeNotNull('indexer', instance.indexer);
  writeNotNull('releaseGroup', instance.releaseGroup);
  writeNotNull('releaseHash', instance.releaseHash);
  writeNotNull('title', instance.title);
  writeNotNull('fullSeason', instance.fullSeason);
  writeNotNull('sceneSource', instance.sceneSource);
  writeNotNull('seasonNumber', instance.seasonNumber);
  writeNotNull('language', instance.language?.toJson());
  writeNotNull('languageWeight', instance.languageWeight);
  writeNotNull('seriesTitle', instance.seriesTitle);
  writeNotNull('episodeNumbers', instance.episodeNumbers);
  writeNotNull('absoluteEpisodeNumbers', instance.absoluteEpisodeNumbers);
  writeNotNull('mappedSeasonNumber', instance.mappedSeasonNumber);
  writeNotNull('mappedEpisodeNumbers', instance.mappedEpisodeNumbers);
  writeNotNull(
      'mappedAbsoluteEpisodeNumbers', instance.mappedAbsoluteEpisodeNumbers);
  writeNotNull('approved', instance.approved);
  writeNotNull('temporarilyRejected', instance.temporarilyRejected);
  writeNotNull('rejected', instance.rejected);
  writeNotNull('tvdbId', instance.tvdbId);
  writeNotNull('tvRageId', instance.tvRageId);
  writeNotNull('rejections', instance.rejections);
  writeNotNull(
      'publishDate', SonarrUtilities.dateTimeToJson(instance.publishDate));
  writeNotNull('commentUrl', instance.commentUrl);
  writeNotNull('downloadUrl', instance.downloadUrl);
  writeNotNull('infoUrl', instance.infoUrl);
  writeNotNull('episodeRequested', instance.episodeRequested);
  writeNotNull('downloadAllowed', instance.downloadAllowed);
  writeNotNull('releaseWeight', instance.releaseWeight);
  writeNotNull('preferredWordScore', instance.preferredWordScore);
  writeNotNull('protocol', SonarrUtilities.protocolToJson(instance.protocol));
  writeNotNull('isDaily', instance.isDaily);
  writeNotNull('isAbsoluteNumbering', instance.isAbsoluteNumbering);
  writeNotNull('isPossibleSpecialEpisode', instance.isPossibleSpecialEpisode);
  writeNotNull('special', instance.special);
  writeNotNull('seeders', instance.seeders);
  writeNotNull('leechers', instance.leechers);
  return val;
}
