// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'episode_file_quality_revision.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SonarrEpisodeFileQualityRevision _$SonarrEpisodeFileQualityRevisionFromJson(
        Map<String, dynamic> json) =>
    SonarrEpisodeFileQualityRevision(
      version: json['version'] as int?,
      real: json['real'] as int?,
      isRepack: json['isRepack'] as bool?,
    );

Map<String, dynamic> _$SonarrEpisodeFileQualityRevisionToJson(
    SonarrEpisodeFileQualityRevision instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('version', instance.version);
  writeNotNull('real', instance.real);
  writeNotNull('isRepack', instance.isRepack);
  return val;
}
