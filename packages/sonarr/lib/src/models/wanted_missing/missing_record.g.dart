// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'missing_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SonarrMissingRecord _$SonarrMissingRecordFromJson(Map<String, dynamic> json) =>
    SonarrMissingRecord(
      seriesId: json['seriesId'] as int?,
      episodeFileId: json['episodeFileId'] as int?,
      seasonNumber: json['seasonNumber'] as int?,
      episodeNumber: json['episodeNumber'] as int?,
      title: json['title'] as String?,
      airDate: json['airDate'] as String?,
      airDateUtc:
          SonarrUtilities.dateTimeFromJson(json['airDateUtc'] as String?),
      overview: json['overview'] as String?,
      hasFile: json['hasFile'] as bool?,
      monitored: json['monitored'] as bool?,
      unverifiedSceneNumbering: json['unverifiedSceneNumbering'] as bool?,
      series: json['series'] == null
          ? null
          : SonarrSeries.fromJson(json['series'] as Map<String, dynamic>),
      id: json['id'] as int?,
    );

Map<String, dynamic> _$SonarrMissingRecordToJson(
        SonarrMissingRecord instance) =>
    <String, dynamic>{
      'seriesId': instance.seriesId,
      'episodeFileId': instance.episodeFileId,
      'seasonNumber': instance.seasonNumber,
      'episodeNumber': instance.episodeNumber,
      'title': instance.title,
      'airDate': instance.airDate,
      'airDateUtc': SonarrUtilities.dateTimeToJson(instance.airDateUtc),
      'overview': instance.overview,
      'hasFile': instance.hasFile,
      'monitored': instance.monitored,
      'unverifiedSceneNumbering': instance.unverifiedSceneNumbering,
      'series': instance.series?.toJson(),
      'id': instance.id,
    };
