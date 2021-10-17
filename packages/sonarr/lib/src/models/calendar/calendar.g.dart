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
      overview: json['overview'] as String?,
      episodeFile: json['episodeFile'] == null
          ? null
          : SonarrEpisodeFile.fromJson(
              json['episodeFile'] as Map<String, dynamic>),
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
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => SonarrImage.fromJson(e as Map<String, dynamic>))
          .toList(),
      id: json['id'] as int?,
    );

Map<String, dynamic> _$SonarrCalendarToJson(SonarrCalendar instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('seriesId', instance.seriesId);
  writeNotNull('episodeFileId', instance.episodeFileId);
  writeNotNull('seasonNumber', instance.seasonNumber);
  writeNotNull('episodeNumber', instance.episodeNumber);
  writeNotNull('title', instance.title);
  writeNotNull('airDate', instance.airDate);
  writeNotNull(
      'airDateUtc', SonarrUtilities.dateTimeToJson(instance.airDateUtc));
  writeNotNull('overview', instance.overview);
  writeNotNull('episodeFile', instance.episodeFile?.toJson());
  writeNotNull('hasFile', instance.hasFile);
  writeNotNull('monitored', instance.monitored);
  writeNotNull('absoluteEpisodeNumber', instance.absoluteEpisodeNumber);
  writeNotNull(
      'sceneAbsoluteEpisodeNumber', instance.sceneAbsoluteEpisodeNumber);
  writeNotNull('sceneEpisodeNumber', instance.sceneEpisodeNumber);
  writeNotNull('sceneSeasonNumber', instance.sceneSeasonNumber);
  writeNotNull('unverifiedSceneNumbering', instance.unverifiedSceneNumbering);
  writeNotNull('series', instance.series?.toJson());
  writeNotNull('images', instance.images?.map((e) => e.toJson()).toList());
  writeNotNull('id', instance.id);
  return val;
}
