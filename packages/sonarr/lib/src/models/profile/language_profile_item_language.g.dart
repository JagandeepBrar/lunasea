// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language_profile_item_language.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SonarrLanguageProfileItemLanguage _$SonarrLanguageProfileItemLanguageFromJson(
        Map<String, dynamic> json) =>
    SonarrLanguageProfileItemLanguage(
      id: json['id'] as int?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$SonarrLanguageProfileItemLanguageToJson(
    SonarrLanguageProfileItemLanguage instance) {
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
