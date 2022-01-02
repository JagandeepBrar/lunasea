// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'format_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RadarrQualityProfileFormatItem _$RadarrQualityProfileFormatItemFromJson(
    Map<String, dynamic> json) {
  return RadarrQualityProfileFormatItem(
    format: json['format'] as int?,
    name: json['name'] as String?,
    score: json['score'] as int?,
  );
}

Map<String, dynamic> _$RadarrQualityProfileFormatItemToJson(
    RadarrQualityProfileFormatItem instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('format', instance.format);
  writeNotNull('name', instance.name);
  writeNotNull('score', instance.score);
  return val;
}
