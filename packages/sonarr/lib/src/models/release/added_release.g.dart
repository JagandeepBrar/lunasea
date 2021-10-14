// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'added_release.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SonarrAddedRelease _$SonarrAddedReleaseFromJson(Map<String, dynamic> json) =>
    SonarrAddedRelease(
      guid: json['guid'] as String?,
      qualityWeight: json['qualityWeight'] as int?,
      age: json['age'] as int?,
      ageHours: (json['ageHours'] as num?)?.toDouble(),
      ageMinutes: (json['ageMinutes'] as num?)?.toDouble(),
      size: json['size'] as int?,
      indexerId: json['indexerId'] as int?,
      fullSeason: json['fullSeason'] as bool?,
      seasonNumber: json['seasonNumber'] as int?,
      approved: json['approved'] as bool?,
      temporarilyRejected: json['temporarilyRejected'] as bool?,
      rejected: json['rejected'] as bool?,
      tvdbId: json['tvdbId'] as int?,
      tvRageId: json['tvRageId'] as int?,
      publishDate:
          SonarrUtilities.dateTimeFromJson(json['publishDate'] as String?),
      downloadAllowed: json['downloadAllowed'] as bool?,
      releaseWeight: json['releaseWeight'] as int?,
      protocol: json['protocol'] as String?,
      isDaily: json['isDaily'] as bool?,
      isAbsoluteNumbering: json['isAbsoluteNumbering'] as bool?,
      isPossibleSpecialEpisode: json['isPossibleSpecialEpisode'] as bool?,
      special: json['special'] as bool?,
    );

Map<String, dynamic> _$SonarrAddedReleaseToJson(SonarrAddedRelease instance) =>
    <String, dynamic>{
      'guid': instance.guid,
      'qualityWeight': instance.qualityWeight,
      'age': instance.age,
      'ageHours': instance.ageHours,
      'ageMinutes': instance.ageMinutes,
      'size': instance.size,
      'indexerId': instance.indexerId,
      'fullSeason': instance.fullSeason,
      'seasonNumber': instance.seasonNumber,
      'approved': instance.approved,
      'temporarilyRejected': instance.temporarilyRejected,
      'rejected': instance.rejected,
      'tvdbId': instance.tvdbId,
      'tvRageId': instance.tvRageId,
      'publishDate': SonarrUtilities.dateTimeToJson(instance.publishDate),
      'downloadAllowed': instance.downloadAllowed,
      'releaseWeight': instance.releaseWeight,
      'protocol': instance.protocol,
      'isDaily': instance.isDaily,
      'isAbsoluteNumbering': instance.isAbsoluteNumbering,
      'isPossibleSpecialEpisode': instance.isPossibleSpecialEpisode,
      'special': instance.special,
    };
