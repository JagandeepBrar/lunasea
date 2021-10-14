// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SonarrHistory _$SonarrHistoryFromJson(Map<String, dynamic> json) =>
    SonarrHistory(
      page: json['page'] as int?,
      pageSize: json['pageSize'] as int?,
      sortKey:
          SonarrUtilities.historySortKeyFromJson(json['sortKey'] as String?),
      sortDirection: json['sortDirection'] as String?,
      totalRecords: json['totalRecords'] as int?,
    )..records = (json['records'] as List<dynamic>?)
        ?.map((e) => SonarrHistoryRecord.fromJson(e as Map<String, dynamic>))
        .toList();

Map<String, dynamic> _$SonarrHistoryToJson(SonarrHistory instance) =>
    <String, dynamic>{
      'page': instance.page,
      'pageSize': instance.pageSize,
      'sortKey': SonarrUtilities.historySortKeyToJson(instance.sortKey),
      'sortDirection': instance.sortDirection,
      'totalRecords': instance.totalRecords,
      'records': instance.records?.map((e) => e.toJson()).toList(),
    };
