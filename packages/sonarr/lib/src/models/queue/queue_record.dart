import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:sonarr/models.dart';
import 'package:sonarr/types.dart';
import 'package:sonarr/utilities.dart';

part 'queue_record.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class SonarrQueueRecord {
  @JsonKey(name: 'seriesId')
  int? seriesId;

  @JsonKey(name: 'episodeId')
  int? episodeId;

  @JsonKey(name: 'series')
  SonarrSeries? series;

  @JsonKey(name: 'episode')
  SonarrEpisode? episode;

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

  @JsonKey(
    name: 'status',
    toJson: SonarrUtilities.queueStatusToJson,
    fromJson: SonarrUtilities.queueStatusFromJson,
  )
  SonarrQueueStatus? status;

  @JsonKey(
    name: 'trackedDownloadStatus',
    toJson: SonarrUtilities.queueTrackedDownloadStatusToJson,
    fromJson: SonarrUtilities.queueTrackedDownloadStatusFromJson,
  )
  SonarrTrackedDownloadStatus? trackedDownloadStatus;

  @JsonKey(
    name: 'trackedDownloadState',
    toJson: SonarrUtilities.queueTrackedDownloadStateToJson,
    fromJson: SonarrUtilities.queueTrackedDownloadStateFromJson,
  )
  SonarrTrackedDownloadState? trackedDownloadState;

  @JsonKey(name: 'statusMessages')
  List<SonarrQueueStatusMessage>? statusMessages;

  @JsonKey(name: 'errorMessage')
  String? errorMessage;

  @JsonKey(name: 'downloadId')
  String? downloadId;

  @JsonKey(
    name: 'protocol',
    toJson: SonarrUtilities.protocolToJson,
    fromJson: SonarrUtilities.protocolFromJson,
  )
  SonarrProtocol? protocol;

  @JsonKey(name: 'downloadClient')
  String? downloadClient;

  @JsonKey(name: 'indexer')
  String? indexer;

  @JsonKey(name: 'id')
  int? id;

  SonarrQueueRecord({
    this.seriesId,
    this.episodeId,
    this.series,
    this.episode,
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
    this.errorMessage,
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
