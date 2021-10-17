// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'series.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SonarrSeries _$SonarrSeriesFromJson(Map<String, dynamic> json) => SonarrSeries(
      title: json['title'] as String?,
      alternateTitles: (json['alternateTitles'] as List<dynamic>?)
          ?.map((e) =>
              SonarrSeriesAlternateTitle.fromJson(e as Map<String, dynamic>))
          .toList(),
      sortTitle: json['sortTitle'] as String?,
      status: json['status'] as String?,
      ended: json['ended'] as bool?,
      overview: json['overview'] as String?,
      nextAiring:
          SonarrUtilities.dateTimeFromJson(json['nextAiring'] as String?),
      previousAiring:
          SonarrUtilities.dateTimeFromJson(json['previousAiring'] as String?),
      network: json['network'] as String?,
      airTime: json['airTime'] as String?,
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => SonarrImage.fromJson(e as Map<String, dynamic>))
          .toList(),
      seasons: (json['seasons'] as List<dynamic>?)
          ?.map((e) => SonarrSeriesSeason.fromJson(e as Map<String, dynamic>))
          .toList(),
      year: json['year'] as int?,
      path: json['path'] as String?,
      qualityProfileId: json['qualityProfileId'] as int?,
      languageProfileId: json['languageProfileId'] as int?,
      seasonFolder: json['seasonFolder'] as bool?,
      monitored: json['monitored'] as bool?,
      useSceneNumbering: json['useSceneNumbering'] as bool?,
      runtime: json['runtime'] as int?,
      tvdbId: json['tvdbId'] as int?,
      tvRageId: json['tvRageId'] as int?,
      tvMazeId: json['tvMazeId'] as int?,
      firstAired:
          SonarrUtilities.dateTimeFromJson(json['firstAired'] as String?),
      seriesType:
          SonarrUtilities.seriesTypeFromJson(json['seriesType'] as String?),
      cleanTitle: json['cleanTitle'] as String?,
      imdbId: json['imdbId'] as String?,
      titleSlug: json['titleSlug'] as String?,
      rootFolderPath: json['rootFolderPath'] as String?,
      certification: json['certification'] as String?,
      genres:
          (json['genres'] as List<dynamic>?)?.map((e) => e as String).toList(),
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as int).toList(),
      added: SonarrUtilities.dateTimeFromJson(json['added'] as String?),
      ratings: json['ratings'] == null
          ? null
          : SonarrSeriesRating.fromJson(
              json['ratings'] as Map<String, dynamic>),
      statistics: json['statistics'] == null
          ? null
          : SonarrSeriesStatistics.fromJson(
              json['statistics'] as Map<String, dynamic>),
      id: json['id'] as int?,
    );

Map<String, dynamic> _$SonarrSeriesToJson(SonarrSeries instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('title', instance.title);
  writeNotNull('alternateTitles',
      instance.alternateTitles?.map((e) => e.toJson()).toList());
  writeNotNull('sortTitle', instance.sortTitle);
  writeNotNull('status', instance.status);
  writeNotNull('ended', instance.ended);
  writeNotNull('overview', instance.overview);
  writeNotNull(
      'nextAiring', SonarrUtilities.dateTimeToJson(instance.nextAiring));
  writeNotNull('previousAiring',
      SonarrUtilities.dateTimeToJson(instance.previousAiring));
  writeNotNull('network', instance.network);
  writeNotNull('airTime', instance.airTime);
  writeNotNull('images', instance.images?.map((e) => e.toJson()).toList());
  writeNotNull('seasons', instance.seasons?.map((e) => e.toJson()).toList());
  writeNotNull('year', instance.year);
  writeNotNull('path', instance.path);
  writeNotNull('qualityProfileId', instance.qualityProfileId);
  writeNotNull('languageProfileId', instance.languageProfileId);
  writeNotNull('seasonFolder', instance.seasonFolder);
  writeNotNull('monitored', instance.monitored);
  writeNotNull('useSceneNumbering', instance.useSceneNumbering);
  writeNotNull('runtime', instance.runtime);
  writeNotNull('tvdbId', instance.tvdbId);
  writeNotNull('tvRageId', instance.tvRageId);
  writeNotNull('tvMazeId', instance.tvMazeId);
  writeNotNull(
      'firstAired', SonarrUtilities.dateTimeToJson(instance.firstAired));
  writeNotNull(
      'seriesType', SonarrUtilities.seriesTypeToJson(instance.seriesType));
  writeNotNull('cleanTitle', instance.cleanTitle);
  writeNotNull('imdbId', instance.imdbId);
  writeNotNull('titleSlug', instance.titleSlug);
  writeNotNull('rootFolderPath', instance.rootFolderPath);
  writeNotNull('certification', instance.certification);
  writeNotNull('genres', instance.genres);
  writeNotNull('tags', instance.tags);
  writeNotNull('added', SonarrUtilities.dateTimeToJson(instance.added));
  writeNotNull('ratings', instance.ratings?.toJson());
  writeNotNull('statistics', instance.statistics?.toJson());
  writeNotNull('id', instance.id);
  return val;
}
