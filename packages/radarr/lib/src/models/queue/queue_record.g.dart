// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'queue_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RadarrQueueRecord _$RadarrQueueRecordFromJson(Map<String, dynamic> json) {
  return RadarrQueueRecord(
    movieId: json['movieId'] as int?,
    languages: (json['languages'] as List<dynamic>?)
        ?.map((e) => RadarrLanguage.fromJson(e as Map<String, dynamic>))
        .toList(),
    quality: json['quality'] == null
        ? null
        : RadarrMovieFileQuality.fromJson(
            json['quality'] as Map<String, dynamic>),
    customFormats: (json['customFormats'] as List<dynamic>?)
        ?.map((e) => RadarrCustomFormat.fromJson(e as Map<String, dynamic>))
        .toList(),
    size: (json['size'] as num?)?.toDouble(),
    title: json['title'] as String?,
    sizeLeft: (json['sizeleft'] as num?)?.toDouble(),
    timeLeft: json['timeleft'] as String?,
    estimatedCompletionTime: RadarrUtilities.dateTimeFromJson(
        json['estimatedCompletionTime'] as String?),
    status:
        RadarrUtilities.queueRecordStatusFromJson(json['status'] as String?),
    trackedDownloadStatus: RadarrUtilities.trackedDownloadStatusFromJson(
        json['trackedDownloadStatus'] as String?),
    trackedDownloadState: RadarrUtilities.trackedDownloadStateFromJson(
        json['trackedDownloadState'] as String?),
    statusMessages: (json['statusMessages'] as List<dynamic>?)
        ?.map(
            (e) => RadarrQueueStatusMessage.fromJson(e as Map<String, dynamic>))
        .toList(),
    downloadId: json['downloadId'] as String?,
    protocol: RadarrUtilities.protocolFromJson(json['protocol'] as String?),
    downloadClient: json['downloadClient'] as String?,
    indexer: json['indexer'] as String?,
    outputPath: json['outputPath'] as String?,
    id: json['id'] as int?,
  );
}

Map<String, dynamic> _$RadarrQueueRecordToJson(RadarrQueueRecord instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('movieId', instance.movieId);
  writeNotNull(
      'languages', instance.languages?.map((e) => e.toJson()).toList());
  writeNotNull('quality', instance.quality?.toJson());
  writeNotNull(
      'customFormats', instance.customFormats?.map((e) => e.toJson()).toList());
  writeNotNull('size', instance.size);
  writeNotNull('title', instance.title);
  writeNotNull('sizeleft', instance.sizeLeft);
  writeNotNull('timeleft', instance.timeLeft);
  writeNotNull('estimatedCompletionTime',
      RadarrUtilities.dateTimeToJson(instance.estimatedCompletionTime));
  writeNotNull(
      'status', RadarrUtilities.queueRecordStatusToJson(instance.status));
  writeNotNull(
      'trackedDownloadStatus',
      RadarrUtilities.trackedDownloadStatusToJson(
          instance.trackedDownloadStatus));
  writeNotNull(
      'trackedDownloadState',
      RadarrUtilities.trackedDownloadStateToJson(
          instance.trackedDownloadState));
  writeNotNull('statusMessages',
      instance.statusMessages?.map((e) => e.toJson()).toList());
  writeNotNull('downloadId', instance.downloadId);
  writeNotNull('protocol', RadarrUtilities.protocolToJson(instance.protocol));
  writeNotNull('downloadClient', instance.downloadClient);
  writeNotNull('indexer', instance.indexer);
  writeNotNull('outputPath', instance.outputPath);
  writeNotNull('id', instance.id);
  return val;
}
