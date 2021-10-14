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
  return val;
}
