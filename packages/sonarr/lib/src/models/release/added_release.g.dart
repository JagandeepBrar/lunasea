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

Map<String, dynamic> _$SonarrAddedReleaseToJson(SonarrAddedRelease instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('guid', instance.guid);
  writeNotNull('qualityWeight', instance.qualityWeight);
  writeNotNull('age', instance.age);
  writeNotNull('ageHours', instance.ageHours);
  writeNotNull('ageMinutes', instance.ageMinutes);
  writeNotNull('size', instance.size);
  writeNotNull('indexerId', instance.indexerId);
  writeNotNull('fullSeason', instance.fullSeason);
  writeNotNull('seasonNumber', instance.seasonNumber);
  writeNotNull('approved', instance.approved);
  writeNotNull('temporarilyRejected', instance.temporarilyRejected);
  writeNotNull('rejected', instance.rejected);
  writeNotNull('tvdbId', instance.tvdbId);
  writeNotNull('tvRageId', instance.tvRageId);
  writeNotNull(
      'publishDate', SonarrUtilities.dateTimeToJson(instance.publishDate));
  writeNotNull('downloadAllowed', instance.downloadAllowed);
  writeNotNull('releaseWeight', instance.releaseWeight);
  writeNotNull('protocol', instance.protocol);
  writeNotNull('isDaily', instance.isDaily);
  writeNotNull('isAbsoluteNumbering', instance.isAbsoluteNumbering);
  writeNotNull('isPossibleSpecialEpisode', instance.isPossibleSpecialEpisode);
  writeNotNull('special', instance.special);
  return val;
}
