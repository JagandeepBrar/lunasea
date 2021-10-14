// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SonarrLanguageProfile _$SonarrLanguageProfileFromJson(
        Map<String, dynamic> json) =>
    SonarrLanguageProfile(
      name: json['name'] as String?,
      upgradeAllowed: json['upgradeAllowed'] as bool?,
      cutoff: json['cutoff'] == null
          ? null
          : SonarrLanguageProfileCutoff.fromJson(
              json['cutoff'] as Map<String, dynamic>),
      languages: (json['languages'] as List<dynamic>?)
          ?.map((e) =>
              SonarrLanguageProfileItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      id: json['id'] as int?,
    );

Map<String, dynamic> _$SonarrLanguageProfileToJson(
        SonarrLanguageProfile instance) =>
    <String, dynamic>{
      'name': instance.name,
      'upgradeAllowed': instance.upgradeAllowed,
      'cutoff': instance.cutoff?.toJson(),
      'languages': instance.languages?.map((e) => e.toJson()).toList(),
      'id': instance.id,
    };
