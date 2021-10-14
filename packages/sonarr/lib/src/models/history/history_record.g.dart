// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SonarrHistoryRecord _$SonarrHistoryRecordFromJson(Map<String, dynamic> json) =>
    SonarrHistoryRecord(
      episodeId: json['episodeId'] as int?,
      seriesId: json['seriesId'] as int?,
      sourceTitle: json['sourceTitle'] as String?,
      quality: json['quality'] == null
          ? null
          : SonarrEpisodeFileQuality.fromJson(
              json['quality'] as Map<String, dynamic>),
      qualityCutoffNotMet: json['qualityCutoffNotMet'] as bool?,
      date: SonarrUtilities.dateTimeFromJson(json['date'] as String?),
      downloadId: json['downloadId'] as String?,
      eventType: SonarrUtilities.historyEventTypeFromJson(
          json['eventType'] as String?),
      data: json['data'] == null
          ? null
          : SonarrHistoryRecordData.fromJson(
              json['data'] as Map<String, dynamic>),
      episode: json['episode'] == null
          ? null
          : SonarrEpisode.fromJson(json['episode'] as Map<String, dynamic>),
      series: json['series'] == null
          ? null
          : SonarrSeries.fromJson(json['series'] as Map<String, dynamic>),
      id: json['id'] as int?,
    );

Map<String, dynamic> _$SonarrHistoryRecordToJson(
        SonarrHistoryRecord instance) =>
    <String, dynamic>{
      'episodeId': instance.episodeId,
      'seriesId': instance.seriesId,
      'sourceTitle': instance.sourceTitle,
      'quality': instance.quality?.toJson(),
      'qualityCutoffNotMet': instance.qualityCutoffNotMet,
      'date': SonarrUtilities.dateTimeToJson(instance.date),
      'downloadId': instance.downloadId,
      'eventType': SonarrUtilities.historyEventTypeToJson(instance.eventType),
      'data': instance.data?.toJson(),
      'episode': instance.episode?.toJson(),
      'series': instance.series?.toJson(),
      'id': instance.id,
    };
