// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_record_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SonarrHistoryRecordData _$SonarrHistoryRecordDataFromJson(
        Map<String, dynamic> json) =>
    SonarrHistoryRecordData(
      droppedPath: json['droppedPath'] as String?,
      importedPath: json['importedPath'] as String?,
      downloadClient: json['downloadClient'] as String?,
      downloadClientName: json['downloadClientName'] as String?,
      indexer: json['indexer'] as String?,
      nzbInfoUrl: json['nzbInfoUrl'] as String?,
      releaseGroup: json['releaseGroup'] as String?,
      downloadUrl: json['downloadUrl'] as String?,
      guid: json['guid'] as String?,
      reason: json['reason'] as String?,
      message: json['message'] as String?,
      sourcePath: json['sourcePath'] as String?,
      sourceRelativePath: json['sourceRelativePath'] as String?,
      path: json['path'] as String?,
      relativePath: json['relativePath'] as String?,
    );

Map<String, dynamic> _$SonarrHistoryRecordDataToJson(
        SonarrHistoryRecordData instance) =>
    <String, dynamic>{
      'droppedPath': instance.droppedPath,
      'importedPath': instance.importedPath,
      'downloadClient': instance.downloadClient,
      'downloadClientName': instance.downloadClientName,
      'indexer': instance.indexer,
      'nzbInfoUrl': instance.nzbInfoUrl,
      'releaseGroup': instance.releaseGroup,
      'downloadUrl': instance.downloadUrl,
      'guid': instance.guid,
      'reason': instance.reason,
      'message': instance.message,
      'sourcePath': instance.sourcePath,
      'sourceRelativePath': instance.sourceRelativePath,
      'path': instance.path,
      'relativePath': instance.relativePath,
    };
