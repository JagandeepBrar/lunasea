// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'queue_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SonarrQueueRecord _$SonarrQueueRecordFromJson(Map<String, dynamic> json) =>
    SonarrQueueRecord(
      series: json['series'] == null
          ? null
          : SonarrSeries.fromJson(json['series'] as Map<String, dynamic>),
      episode: json['episode'] == null
          ? null
          : SonarrEpisode.fromJson(json['episode'] as Map<String, dynamic>),
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
      statusMessages: (json['statusMessages'] as List<dynamic>?)
          ?.map((e) =>
              SonarrQueueStatusMessage.fromJson(e as Map<String, dynamic>))
          .toList(),
      id: json['id'] as int?,
    )..protocol = json['protocol'] as String?;

Map<String, dynamic> _$SonarrQueueRecordToJson(SonarrQueueRecord instance) =>
    <String, dynamic>{
      'series': instance.series?.toJson(),
      'episode': instance.episode?.toJson(),
      'quality': instance.quality?.toJson(),
      'size': instance.size,
      'title': instance.title,
      'sizeleft': instance.sizeLeft,
      'timeleft': instance.timeLeft,
      'estimatedCompletionTime':
          SonarrUtilities.dateTimeToJson(instance.estimatedCompletionTime),
      'status': instance.status,
      'trackedDownloadStatus': instance.trackedDownloadStatus,
      'statusMessages':
          instance.statusMessages?.map((e) => e.toJson()).toList(),
      'protocol': instance.protocol,
      'id': instance.id,
    };
