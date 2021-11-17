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

Map<String, dynamic> _$SonarrQueueRecordToJson(SonarrQueueRecord instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('series', instance.series?.toJson());
  writeNotNull('episode', instance.episode?.toJson());
  writeNotNull('quality', instance.quality?.toJson());
  writeNotNull('size', instance.size);
  writeNotNull('title', instance.title);
  writeNotNull('sizeleft', instance.sizeLeft);
  writeNotNull('timeleft', instance.timeLeft);
  writeNotNull('estimatedCompletionTime',
      SonarrUtilities.dateTimeToJson(instance.estimatedCompletionTime));
  writeNotNull('status', instance.status);
  writeNotNull('trackedDownloadStatus', instance.trackedDownloadStatus);
  writeNotNull('statusMessages',
      instance.statusMessages?.map((e) => e.toJson()).toList());
  writeNotNull('protocol', instance.protocol);
  writeNotNull('id', instance.id);
  return val;
}
