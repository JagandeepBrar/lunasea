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
      seasonNumber: json['seasonNumber'] as int?,
      seriesTitle: json['seriesTitle'] as String?,
      episodeNumbers: (json['episodeNumbers'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
      absoluteEpisodeNumbers: (json['absoluteEpisodeNumbers'] as List<dynamic>?)
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
      downloadAllowed: json['downloadAllowed'] as bool?,
      releaseWeight: json['releaseWeight'] as int?,
      protocol: json['protocol'] as String?,
      isDaily: json['isDaily'] as bool?,
      isAbsoluteNumbering: json['isAbsoluteNumbering'] as bool?,
      isPossibleSpecialEpisode: json['isPossibleSpecialEpisode'] as bool?,
      special: json['special'] as bool?,
      leechers: json['leechers'] as int?,
      seeders: json['seeders'] as int?,
    );

Map<String, dynamic> _$SonarrReleaseToJson(SonarrRelease instance) =>
    <String, dynamic>{
      'guid': instance.guid,
      'quality': instance.quality?.toJson(),
      'qualityWeight': instance.qualityWeight,
      'age': instance.age,
      'ageHours': instance.ageHours,
      'ageMinutes': instance.ageMinutes,
      'size': instance.size,
      'indexerId': instance.indexerId,
      'indexer': instance.indexer,
      'releaseGroup': instance.releaseGroup,
      'releaseHash': instance.releaseHash,
      'title': instance.title,
      'fullSeason': instance.fullSeason,
      'seasonNumber': instance.seasonNumber,
      'seriesTitle': instance.seriesTitle,
      'episodeNumbers': instance.episodeNumbers,
      'absoluteEpisodeNumbers': instance.absoluteEpisodeNumbers,
      'approved': instance.approved,
      'temporarilyRejected': instance.temporarilyRejected,
      'rejected': instance.rejected,
      'tvdbId': instance.tvdbId,
      'tvRageId': instance.tvRageId,
      'rejections': instance.rejections,
      'publishDate': SonarrUtilities.dateTimeToJson(instance.publishDate),
      'commentUrl': instance.commentUrl,
      'downloadUrl': instance.downloadUrl,
      'infoUrl': instance.infoUrl,
      'downloadAllowed': instance.downloadAllowed,
      'releaseWeight': instance.releaseWeight,
      'protocol': instance.protocol,
      'isDaily': instance.isDaily,
      'isAbsoluteNumbering': instance.isAbsoluteNumbering,
      'isPossibleSpecialEpisode': instance.isPossibleSpecialEpisode,
      'special': instance.special,
      'seeders': instance.seeders,
      'leechers': instance.leechers,
    };
