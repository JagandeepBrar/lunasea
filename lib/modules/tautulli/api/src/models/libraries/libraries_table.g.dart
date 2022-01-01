// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'libraries_table.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TautulliLibrariesTable _$TautulliLibrariesTableFromJson(
    Map<String, dynamic> json) {
  return TautulliLibrariesTable(
    libraries: TautulliLibrariesTable._librariesFromJson(json['data'] as List),
    draw: TautulliUtilities.ensureIntegerFromJson(json['draw']),
    recordsTotal: TautulliUtilities.ensureIntegerFromJson(json['recordsTotal']),
    recordsFiltered:
        TautulliUtilities.ensureIntegerFromJson(json['recordsFiltered']),
  );
}

Map<String, dynamic> _$TautulliLibrariesTableToJson(
        TautulliLibrariesTable instance) =>
    <String, dynamic>{
      'data': TautulliLibrariesTable._librariesToJson(instance.libraries),
      'draw': instance.draw,
      'recordsTotal': instance.recordsTotal,
      'recordsFiltered': instance.recordsFiltered,
    };
