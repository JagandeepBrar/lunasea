import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:lunasea/modules/sonarr.dart';

part 'history_record.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class SonarrHistoryRecord {
  @JsonKey(name: 'episodeId')
  int? episodeId;

  @JsonKey(name: 'seriesId')
  int? seriesId;

  @JsonKey(name: 'sourceTitle')
  String? sourceTitle;

  @JsonKey(name: 'language')
  SonarrEpisodeFileLanguage? language;

  @JsonKey(name: 'quality')
  SonarrEpisodeFileQuality? quality;

  @JsonKey(name: 'qualityCutoffNotMet')
  bool? qualityCutoffNotMet;

  @JsonKey(name: 'languageCutoffNotMet')
  bool? languageCutoffNotMet;

  @JsonKey(
    name: 'date',
    toJson: SonarrUtilities.dateTimeToJson,
    fromJson: SonarrUtilities.dateTimeFromJson,
  )
  DateTime? date;

  @JsonKey(name: 'downloadId')
  String? downloadId;

  @JsonKey(
    name: 'eventType',
    toJson: SonarrUtilities.eventTypeToJson,
    fromJson: SonarrUtilities.eventTypeFromJson,
  )
  SonarrEventType? eventType;

  @JsonKey(name: 'data')
  Map<String, dynamic>? data;

  @JsonKey(name: 'episode')
  SonarrEpisode? episode;

  @JsonKey(name: 'series')
  SonarrSeries? series;

  @JsonKey(name: 'id')
  int? id;

  SonarrHistoryRecord({
    this.episodeId,
    this.seriesId,
    this.sourceTitle,
    this.language,
    this.quality,
    this.qualityCutoffNotMet,
    this.languageCutoffNotMet,
    this.date,
    this.downloadId,
    this.eventType,
    this.data,
    this.episode,
    this.series,
    this.id,
  });

  @override
  String toString() => json.encode(this.toJson());

  factory SonarrHistoryRecord.fromJson(Map<String, dynamic> json) =>
      _$SonarrHistoryRecordFromJson(json);

  Map<String, dynamic> toJson() => _$SonarrHistoryRecordToJson(this);
}
