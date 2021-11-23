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
      cutoff: json['cutoff'] as int?,
      items: (json['items'] as List<dynamic>?)
          ?.map((e) =>
              SonarrQualityProfileItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      id: json['id'] as int?,
    );

Map<String, dynamic> _$SonarrQualityProfileToJson(
    SonarrQualityProfile instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  writeNotNull('upgradeAllowed', instance.upgradeAllowed);
  writeNotNull('cutoff', instance.cutoff);
  writeNotNull('items', instance.items?.map((e) => e.toJson()).toList());
  writeNotNull('id', instance.id);
  return val;
}
