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
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : SonarrImage.fromJson(e as Map<String, dynamic>))
          .toList(),
      series: json['series'] == null
          ? null
          : SonarrSeries.fromJson(json['series'] as Map<String, dynamic>),
      id: json['id'] as int?,
    );

Map<String, dynamic> _$SonarrMissingRecordToJson(SonarrMissingRecord instance) {
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
  writeNotNull('hasFile', instance.hasFile);
  writeNotNull('monitored', instance.monitored);
  writeNotNull('unverifiedSceneNumbering', instance.unverifiedSceneNumbering);
  writeNotNull('images', instance.images?.map((e) => e?.toJson()).toList());
  writeNotNull('series', instance.series?.toJson());
  writeNotNull('id', instance.id);
  return val;
}
