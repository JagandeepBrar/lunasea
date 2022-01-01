// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_stats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TautulliHomeStats _$TautulliHomeStatsFromJson(Map<String, dynamic> json) {
  return TautulliHomeStats(
    id: TautulliUtilities.ensureStringFromJson(json['stat_id']),
    title: TautulliUtilities.ensureStringFromJson(json['stat_title']),
    type: TautulliUtilities.ensureStringFromJson(json['stat_type']),
    data: (json['rows'] as List<dynamic>?)
        ?.map((e) => e as Map<String, dynamic>)
        .toList(),
  );
}

Map<String, dynamic> _$TautulliHomeStatsToJson(TautulliHomeStats instance) =>
    <String, dynamic>{
      'stat_id': instance.id,
      'stat_type': instance.type,
      'stat_title': instance.title,
      'rows': instance.data,
    };
