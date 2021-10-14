// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RadarrQualityProfileItem _$RadarrQualityProfileItemFromJson(
    Map<String, dynamic> json) {
  return RadarrQualityProfileItem(
    name: json['name'] as String?,
    quality: json['quality'] == null
        ? null
        : RadarrQuality.fromJson(json['quality'] as Map<String, dynamic>),
    items: (json['items'] as List<dynamic>?)
        ?.map(
            (e) => RadarrQualityProfileItem.fromJson(e as Map<String, dynamic>))
        .toList(),
    allowed: json['allowed'] as bool?,
    id: json['id'] as int?,
  );
}

Map<String, dynamic> _$RadarrQualityProfileItemToJson(
    RadarrQualityProfileItem instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  writeNotNull('quality', instance.quality?.toJson());
  writeNotNull('items', instance.items?.map((e) => e.toJson()).toList());
  writeNotNull('allowed', instance.allowed);
  writeNotNull('id', instance.id);
  return val;
}
