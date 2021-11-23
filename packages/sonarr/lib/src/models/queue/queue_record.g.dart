// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'queue_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SonarrQueueRecord _$SonarrQueueRecordFromJson(Map<String, dynamic> json) =>
    SonarrQueueRecord(
      seriesId: json['seriesId'] as int?,
      episodeId: json['episodeId'] as int?,
      language: json['language'] == null
          ? null
          : SonarrEpisodeFileLanguage.fromJson(
              json['language'] as Map<String, dynamic>),
      quality: json['quality'] == null
          ? null
          : SonarrEpisodeFileQuality.fromJson(
              json['quality'] as Map<String, dynamic>),
      size: (json['size'] as num?)?.toDouble(),
      title: json['title'] as String?,
      sizeLeft: (json['sizeleft'] as num?)?.toDouble(),
      timeLeft: json['timeleft'] as String?,
      estimatedCompletionTime: SonarrUtilities.dateTimeFromJson(
          json['estimatedCompletionTime'] as String?),
      status: json['status'] as String?,
      trackedDownloadStatus: json['trackedDownloadStatus'] as String?,
      trackedDownloadState: json['trackedDownloadState'] as String?,
      statusMessages: (json['statusMessages'] as List<dynamic>?)
          ?.map((e) =>
              SonarrQueueStatusMessage.fromJson(e as Map<String, dynamic>))
          .toList(),
      downloadId: json['downloadId'] as String?,
      protocol: json['protocol'] as String?,
      downloadClient: json['downloadClient'] as String?,
      indexer: json['indexer'] as String?,
      id: json['id'] as int?,
    );

Map<String, dynamic> _$SonarrQueueRecordToJson(SonarrQueueRecord instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('seriesId', instance.seriesId);
  writeNotNull('episodeId', instance.episodeId);
  writeNotNull('language', instance.language?.toJson());
  writeNotNull('quality', instance.quality?.toJson());
  writeNotNull('size', instance.size);
  writeNotNull('title', instance.title);
  writeNotNull('sizeleft', instance.sizeLeft);
  writeNotNull('timeleft', instance.timeLeft);
  writeNotNull('estimatedCompletionTime',
      SonarrUtilities.dateTimeToJson(instance.estimatedCompletionTime));
  writeNotNull('status', instance.status);
  writeNotNull('trackedDownloadStatus', instance.trackedDownloadStatus);
  writeNotNull('trackedDownloadState', instance.trackedDownloadState);
  writeNotNull('statusMessages',
      instance.statusMessages?.map((e) => e.toJson()).toList());
  writeNotNull('downloadId', instance.downloadId);
  writeNotNull('protocol', instance.protocol);
  writeNotNull('downloadClient', instance.downloadClient);
  writeNotNull('indexer', instance.indexer);
  writeNotNull('id', instance.id);
  return val;
}
