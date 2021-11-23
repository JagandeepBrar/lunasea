// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language_profile_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SonarrLanguageProfileItem _$SonarrLanguageProfileItemFromJson(
        Map<String, dynamic> json) =>
    SonarrLanguageProfileItem(
      allowed: json['allowed'] as bool?,
    )..language = json['language'] == null
        ? null
        : SonarrLanguageProfileItemLanguage.fromJson(
            json['language'] as Map<String, dynamic>);

Map<String, dynamic> _$SonarrLanguageProfileItemToJson(
    SonarrLanguageProfileItem instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('allowed', instance.allowed);
  writeNotNull('language', instance.language?.toJson());
  return val;
}
