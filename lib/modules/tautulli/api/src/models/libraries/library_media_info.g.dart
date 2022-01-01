// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'library_media_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TautulliLibraryMediaInfo _$TautulliLibraryMediaInfoFromJson(
    Map<String, dynamic> json) {
  return TautulliLibraryMediaInfo(
    recordsFiltered:
        TautulliUtilities.ensureIntegerFromJson(json['recordsFiltered']),
    recordsTotal: TautulliUtilities.ensureIntegerFromJson(json['recordsTotal']),
    filteredFileSize:
        TautulliUtilities.ensureIntegerFromJson(json['filtered_file_size']),
    totalFileSize:
        TautulliUtilities.ensureIntegerFromJson(json['total_file_size']),
    draw: TautulliUtilities.ensureIntegerFromJson(json['draw']),
    mediaInfo: TautulliLibraryMediaInfo._infoFromJson(json['data']),
  );
}

Map<String, dynamic> _$TautulliLibraryMediaInfoToJson(
        TautulliLibraryMediaInfo instance) =>
    <String, dynamic>{
      'recordsFiltered': instance.recordsFiltered,
      'recordsTotal': instance.recordsTotal,
      'filtered_file_size': instance.filteredFileSize,
      'total_file_size': instance.totalFileSize,
      'draw': instance.draw,
      'data': TautulliLibraryMediaInfo._infoToJson(instance.mediaInfo),
    };
