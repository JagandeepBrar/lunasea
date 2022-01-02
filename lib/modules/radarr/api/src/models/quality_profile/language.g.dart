// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RadarrLanguage _$RadarrLanguageFromJson(Map<String, dynamic> json) {
  return RadarrLanguage(
    id: json['id'] as int?,
    name: json['name'] as String?,
    nameLower: json['nameLower'] as String?,
  );
}

Map<String, dynamic> _$RadarrLanguageToJson(RadarrLanguage instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  writeNotNull('nameLower', instance.nameLower);
  return val;
}
