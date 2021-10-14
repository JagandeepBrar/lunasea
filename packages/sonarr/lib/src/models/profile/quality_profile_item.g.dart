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
        SonarrQualityProfileItem instance) =>
    <String, dynamic>{
      'allowed': instance.allowed,
      'quality': instance.quality?.toJson(),
    };
