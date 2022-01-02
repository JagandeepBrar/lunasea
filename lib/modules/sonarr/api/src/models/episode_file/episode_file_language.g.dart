// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'episode_file_language.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SonarrEpisodeFileLanguage _$SonarrEpisodeFileLanguageFromJson(
        Map<String, dynamic> json) =>
    SonarrEpisodeFileLanguage(
      id: json['id'] as int?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$SonarrEpisodeFileLanguageToJson(
    SonarrEpisodeFileLanguage instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  return val;
}
