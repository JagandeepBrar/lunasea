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
      language: json['language'] == null
          ? null
          : SonarrEpisodeFileLanguage.fromJson(
              json['language'] as Map<String, dynamic>),
      quality: json['quality'] == null
          ? null
          : SonarrEpisodeFileQuality.fromJson(
              json['quality'] as Map<String, dynamic>),
      qualityCutoffNotMet: json['qualityCutoffNotMet'] as bool?,
      languageCutoffNotMet: json['languageCutoffNotMet'] as bool?,
      date: SonarrUtilities.dateTimeFromJson(json['date'] as String?),
      downloadId: json['downloadId'] as String?,
      eventType:
          SonarrUtilities.eventTypeFromJson(json['eventType'] as String?),
      data: json['data'] as Map<String, dynamic>?,
      episode: json['episode'] == null
          ? null
          : SonarrEpisode.fromJson(json['episode'] as Map<String, dynamic>),
      series: json['series'] == null
          ? null
          : SonarrSeries.fromJson(json['series'] as Map<String, dynamic>),
      id: json['id'] as int?,
    );

Map<String, dynamic> _$SonarrHistoryRecordToJson(SonarrHistoryRecord instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('episodeId', instance.episodeId);
  writeNotNull('seriesId', instance.seriesId);
  writeNotNull('sourceTitle', instance.sourceTitle);
  writeNotNull('language', instance.language?.toJson());
  writeNotNull('quality', instance.quality?.toJson());
  writeNotNull('qualityCutoffNotMet', instance.qualityCutoffNotMet);
  writeNotNull('languageCutoffNotMet', instance.languageCutoffNotMet);
  writeNotNull('date', SonarrUtilities.dateTimeToJson(instance.date));
  writeNotNull('downloadId', instance.downloadId);
  writeNotNull(
      'eventType', SonarrUtilities.eventTypeToJson(instance.eventType));
  writeNotNull('data', instance.data);
  writeNotNull('episode', instance.episode?.toJson());
  writeNotNull('series', instance.series?.toJson());
  writeNotNull('id', instance.id);
  return val;
}
