// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quality_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SonarrQualityProfile _$SonarrQualityProfileFromJson(
        Map<String, dynamic> json) =>
    SonarrQualityProfile(
      name: json['name'] as String?,
      upgradeAllowed: json['upgradeAllowed'] as bool?,
      cutoff: json['cutoff'] == null
          ? null
          : SonarrQualityProfileCutoff.fromJson(
              json['cutoff'] as Map<String, dynamic>),
      items: (json['items'] as List<dynamic>?)
          ?.map((e) =>
              SonarrQualityProfileItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      id: json['id'] as int?,
    );

Map<String, dynamic> _$SonarrQualityProfileToJson(
        SonarrQualityProfile instance) =>
    <String, dynamic>{
      'name': instance.name,
      'upgradeAllowed': instance.upgradeAllowed,
      'cutoff': instance.cutoff?.toJson(),
      'items': instance.items?.map((e) => e.toJson()).toList(),
      'id': instance.id,
    };
