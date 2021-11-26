// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'queue_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SonarrQueueRecord _$SonarrQueueRecordFromJson(Map<String, dynamic> json) =>
    SonarrQueueRecord(
      seriesId: json['seriesId'] as int?,
      episodeId: json['episodeId'] as int?,
      series: json['series'] == null
          ? null
          : SonarrSeries.fromJson(json['series'] as Map<String, dynamic>),
      episode: json['episode'] == null
          ? null
          : SonarrEpisode.fromJson(json['episode'] as Map<String, dynamic>),
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
      sizeleft: (json['sizeleft'] as num?)?.toDouble(),
      timeleft: json['timeleft'] as String?,
      estimatedCompletionTime: SonarrUtilities.dateTimeFromJson(
          json['estimatedCompletionTime'] as String?),
      status: SonarrUtilities.queueStatusFromJson(json['status'] as String?),
      trackedDownloadStatus: SonarrUtilities.queueTrackedDownloadStatusFromJson(
          json['trackedDownloadStatus'] as String?),
      trackedDownloadState: SonarrUtilities.queueTrackedDownloadStateFromJson(
          json['trackedDownloadState'] as String?),
      statusMessages: (json['statusMessages'] as List<dynamic>?)
          ?.map((e) =>
              SonarrQueueStatusMessage.fromJson(e as Map<String, dynamic>))
          .toList(),
      errorMessage: json['errorMessage'] as String?,
      downloadId: json['downloadId'] as String?,
      protocol: SonarrUtilities.protocolFromJson(json['protocol'] as String?),
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
  writeNotNull('series', instance.series?.toJson());
  writeNotNull('episode', instance.episode?.toJson());
  writeNotNull('language', instance.language?.toJson());
  writeNotNull('quality', instance.quality?.toJson());
  writeNotNull('size', instance.size);
  writeNotNull('title', instance.title);
  writeNotNull('sizeleft', instance.sizeleft);
  writeNotNull('timeleft', instance.timeleft);
  writeNotNull('estimatedCompletionTime',
      SonarrUtilities.dateTimeToJson(instance.estimatedCompletionTime));
  writeNotNull('status', SonarrUtilities.queueStatusToJson(instance.status));
  writeNotNull(
      'trackedDownloadStatus',
      SonarrUtilities.queueTrackedDownloadStatusToJson(
          instance.trackedDownloadStatus));
  writeNotNull(
      'trackedDownloadState',
      SonarrUtilities.queueTrackedDownloadStateToJson(
          instance.trackedDownloadState));
  writeNotNull('statusMessages',
      instance.statusMessages?.map((e) => e.toJson()).toList());
  writeNotNull('errorMessage', instance.errorMessage);
  writeNotNull('downloadId', instance.downloadId);
  writeNotNull('protocol', SonarrUtilities.protocolToJson(instance.protocol));
  writeNotNull('downloadClient', instance.downloadClient);
  writeNotNull('indexer', instance.indexer);
  writeNotNull('id', instance.id);
  return val;
}
