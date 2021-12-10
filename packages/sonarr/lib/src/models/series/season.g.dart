// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'season.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SonarrSeriesSeason _$SonarrSeriesSeasonFromJson(Map<String, dynamic> json) =>
    SonarrSeriesSeason(
      seasonNumber: json['seasonNumber'] as int?,
      monitored: json['monitored'] as bool?,
      statistics: json['statistics'] == null
          ? null
          : SonarrSeriesSeasonStatistics.fromJson(
              json['statistics'] as Map<String, dynamic>),
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => SonarrImage.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SonarrSeriesSeasonToJson(SonarrSeriesSeason instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('seasonNumber', instance.seasonNumber);
  writeNotNull('monitored', instance.monitored);
  writeNotNull('statistics', instance.statistics?.toJson());
  writeNotNull('images', instance.images?.map((e) => e.toJson()).toList());
  return val;
}
