// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quality_definition.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RadarrQualityDefinition _$RadarrQualityDefinitionFromJson(
    Map<String, dynamic> json) {
  return RadarrQualityDefinition(
    quality: json['quality'] == null
        ? null
        : RadarrQuality.fromJson(json['quality'] as Map<String, dynamic>),
    title: json['title'] as String?,
    weight: json['weight'] as int?,
    minSize: (json['minSize'] as num?)?.toDouble(),
    maxSize: (json['maxSize'] as num?)?.toDouble(),
    preferredSize: (json['preferredSize'] as num?)?.toDouble(),
    id: json['id'] as int?,
  );
}

Map<String, dynamic> _$RadarrQualityDefinitionToJson(
    RadarrQualityDefinition instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('quality', instance.quality?.toJson());
  writeNotNull('title', instance.title);
  writeNotNull('weight', instance.weight);
  writeNotNull('minSize', instance.minSize);
  writeNotNull('maxSize', instance.maxSize);
  writeNotNull('preferredSize', instance.preferredSize);
  writeNotNull('id', instance.id);
  return val;
}
