// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language_profile_cutoff.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SonarrLanguageProfileCutoff _$SonarrLanguageProfileCutoffFromJson(
        Map<String, dynamic> json) =>
    SonarrLanguageProfileCutoff(
      id: json['id'] as int?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$SonarrLanguageProfileCutoffToJson(
    SonarrLanguageProfileCutoff instance) {
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
