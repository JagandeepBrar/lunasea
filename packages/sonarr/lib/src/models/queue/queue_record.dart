import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:sonarr/models.dart';
import 'package:sonarr/utilities.dart';

part 'queue_record.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class SonarrQueueRecord {
  @JsonKey(name: 'seriesId')
  int? seriesId;

  @JsonKey(name: 'episodeId')
  int? episodeId;

  @JsonKey(name: 'language')
  SonarrEpisodeFileLanguage? language;

  @JsonKey(name: 'quality')
  SonarrEpisodeFileQuality? quality;

  @JsonKey(name: 'size')
  double? size;

  @JsonKey(name: 'title')
  String? title;

  @JsonKey(name: 'sizeleft')
  double? sizeLeft;

  @JsonKey(name: 'timeleft')
  String? timeLeft;

  @JsonKey(
    name: 'estimatedCompletionTime',
    toJson: SonarrUtilities.dateTimeToJson,
    fromJson: SonarrUtilities.dateTimeFromJson,
  )
  DateTime? estimatedCompletionTime;

  @JsonKey(name: 'status')
  String? status;

  @JsonKey(name: 'trackedDownloadStatus')
  String? trackedDownloadStatus;

  @JsonKey(name: 'trackedDownloadState')
  String? trackedDownloadState;

  @JsonKey(name: 'statusMessages')
  List<SonarrQueueStatusMessage>? statusMessages;

  @JsonKey(name: 'downloadId')
  String? downloadId;

  @JsonKey(name: 'protocol')
  String? protocol;

  @JsonKey(name: 'downloadClient')
  String? downloadClient;

  @JsonKey(name: 'indexer')
  String? indexer;

  @JsonKey(name: 'id')
  int? id;

  SonarrQueueRecord({
    this.seriesId,
    this.episodeId,
    this.language,
    this.quality,
    this.size,
    this.title,
    this.sizeLeft,
    this.timeLeft,
    this.estimatedCompletionTime,
    this.status,
    this.trackedDownloadStatus,
    this.trackedDownloadState,
    this.statusMessages,
    this.downloadId,
    this.protocol,
    this.downloadClient,
    this.indexer,
    this.id,
  });

  @override
  String toString() => json.encode(this.toJson());

  factory SonarrQueueRecord.fromJson(Map<String, dynamic> json) =>
      _$SonarrQueueRecordFromJson(json);

  Map<String, dynamic> toJson() => _$SonarrQueueRecordToJson(this);
}
