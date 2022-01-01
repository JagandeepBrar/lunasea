// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TautulliHistory _$TautulliHistoryFromJson(Map<String, dynamic> json) {
  return TautulliHistory(
    records: TautulliHistory._entriesFromJson(json['data'] as List),
    draw: TautulliUtilities.ensureIntegerFromJson(json['draw']),
    recordsTotal: TautulliUtilities.ensureIntegerFromJson(json['recordsTotal']),
    recordsFiltered:
        TautulliUtilities.ensureIntegerFromJson(json['recordsFiltered']),
    totalDuration:
        TautulliUtilities.ensureStringFromJson(json['total_duration']),
    filterDuration:
        TautulliUtilities.ensureStringFromJson(json['filter_duration']),
  );
}

Map<String, dynamic> _$TautulliHistoryToJson(TautulliHistory instance) =>
    <String, dynamic>{
      'data': TautulliHistory._entriesToJson(instance.records),
      'draw': instance.draw,
      'recordsTotal': instance.recordsTotal,
      'recordsFiltered': instance.recordsFiltered,
      'total_duration': instance.totalDuration,
      'filter_duration': instance.filterDuration,
    };
