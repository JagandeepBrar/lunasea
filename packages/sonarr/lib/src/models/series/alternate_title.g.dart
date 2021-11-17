// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alternate_title.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SonarrSeriesAlternateTitle _$SonarrSeriesAlternateTitleFromJson(
        Map<String, dynamic> json) =>
    SonarrSeriesAlternateTitle(
      title: json['title'] as String?,
      sceneSeasonNumber: json['sceneSeasonNumber'] as int?,
      seasonNumber: json['seasonNumber'] as int?,
    );

Map<String, dynamic> _$SonarrSeriesAlternateTitleToJson(
    SonarrSeriesAlternateTitle instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('title', instance.title);
  writeNotNull('sceneSeasonNumber', instance.sceneSeasonNumber);
  writeNotNull('seasonNumber', instance.seasonNumber);
  return val;
}
