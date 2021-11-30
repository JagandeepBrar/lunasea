// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'queue.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SonarrQueue _$SonarrQueueFromJson(Map<String, dynamic> json) => SonarrQueue(
      page: json['page'] as int?,
      pageSize: json['pageSize'] as int?,
      sortKey: json['sortKey'] as String?,
      sortDirection: json['sortDirection'] as String?,
      totalRecords: json['totalRecords'] as int?,
      records: (json['records'] as List<dynamic>?)
          ?.map((e) => SonarrQueueRecord.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SonarrQueueToJson(SonarrQueue instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('page', instance.page);
  writeNotNull('pageSize', instance.pageSize);
  writeNotNull('sortKey', instance.sortKey);
  writeNotNull('sortDirection', instance.sortDirection);
  writeNotNull('totalRecords', instance.totalRecords);
  writeNotNull('records', instance.records?.map((e) => e.toJson()).toList());
  return val;
}
