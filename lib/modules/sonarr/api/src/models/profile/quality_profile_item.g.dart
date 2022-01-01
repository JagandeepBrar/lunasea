// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quality_profile_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SonarrQualityProfileItem _$SonarrQualityProfileItemFromJson(
        Map<String, dynamic> json) =>
    SonarrQualityProfileItem(
      allowed: json['allowed'] as bool?,
      quality: json['quality'] == null
          ? null
          : SonarrQualityProfileItemQuality.fromJson(
              json['quality'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SonarrQualityProfileItemToJson(
    SonarrQualityProfileItem instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('allowed', instance.allowed);
  writeNotNull('quality', instance.quality?.toJson());
  return val;
}
