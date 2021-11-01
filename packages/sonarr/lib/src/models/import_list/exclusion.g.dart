// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exclusion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SonarrExclusion _$SonarrExclusionFromJson(Map<String, dynamic> json) =>
    SonarrExclusion(
      id: json['id'] as int?,
      tvdbId: json['tvdbId'] as int?,
      title: json['title'] as String?,
    );

Map<String, dynamic> _$SonarrExclusionToJson(SonarrExclusion instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('tvdbId', instance.tvdbId);
  writeNotNull('title', instance.title);
  return val;
}
