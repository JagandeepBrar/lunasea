// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SonarrCalendar _$SonarrCalendarFromJson(Map<String, dynamic> json) =>
    SonarrCalendar(
      seriesId: json['seriesId'] as int?,
      episodeFileId: json['episodeFileId'] as int?,
      seasonNumber: json['seasonNumber'] as int?,
      episodeNumber: json['episodeNumber'] as int?,
      title: json['title'] as String?,
      airDate: json['airDate'] as String?,
      airDateUtc:
          SonarrUtilities.dateTimeFromJson(json['airDateUtc'] as String?),
      episodeFile: json['episodeFile'] == null
          ? null
          : SonarrEpisodeFile.fromJson(
              json['episodeFile'] as Map<String, dynamic>),
      overview: json['overview'] as String?,
      hasFile: json['hasFile'] as bool?,
      monitored: json['monitored'] as bool?,
      absoluteEpisodeNumber: json['absoluteEpisodeNumber'] as int?,
      sceneAbsoluteEpisodeNumber: json['sceneAbsoluteEpisodeNumber'] as int?,
      sceneEpisodeNumber: json['sceneEpisodeNumber'] as int?,
      sceneSeasonNumber: json['sceneSeasonNumber'] as int?,
      unverifiedSceneNumbering: json['unverifiedSceneNumbering'] as bool?,
      series: json['series'] == null
          ? null
          : SonarrSeries.fromJson(json['series'] as Map<String, dynamic>),
      id: json['id'] as int?,
    );

Map<String, dynamic> _$SonarrCalendarToJson(SonarrCalendar instance) =>
    <String, dynamic>{
      'seriesId': instance.seriesId,
      'episodeFileId': instance.episodeFileId,
      'seasonNumber': instance.seasonNumber,
      'episodeNumber': instance.episodeNumber,
      'title': instance.title,
      'airDate': instance.airDate,
      'airDateUtc': SonarrUtilities.dateTimeToJson(instance.airDateUtc),
      'episodeFile': instance.episodeFile?.toJson(),
      'overview': instance.overview,
      'hasFile': instance.hasFile,
      'monitored': instance.monitored,
      'absoluteEpisodeNumber': instance.absoluteEpisodeNumber,
      'sceneAbsoluteEpisodeNumber': instance.sceneAbsoluteEpisodeNumber,
      'sceneEpisodeNumber': instance.sceneEpisodeNumber,
      'sceneSeasonNumber': instance.sceneSeasonNumber,
      'unverifiedSceneNumbering': instance.unverifiedSceneNumbering,
      'series': instance.series?.toJson(),
      'id': instance.id,
    };
