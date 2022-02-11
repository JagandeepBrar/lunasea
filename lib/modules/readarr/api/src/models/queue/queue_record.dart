import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:lunasea/modules/readarr.dart';

part 'queue_record.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ReadarrQueueRecord {
  @JsonKey(name: 'authorId')
  int? authorId;

  @JsonKey(name: 'bookId')
  int? bookId;

  @JsonKey(name: 'author')
  ReadarrAuthor? series;

  @JsonKey(name: 'book')
  ReadarrBook? episode;

  @JsonKey(name: 'quality')
  ReadarrBookFileQuality? quality;

  @JsonKey(name: 'size')
  double? size;

  @JsonKey(name: 'title')
  String? title;

  @JsonKey(name: 'sizeleft')
  double? sizeleft;

  @JsonKey(name: 'timeleft')
  String? timeleft;

  @JsonKey(
    name: 'estimatedCompletionTime',
    toJson: ReadarrUtilities.dateTimeToJson,
    fromJson: ReadarrUtilities.dateTimeFromJson,
  )
  DateTime? estimatedCompletionTime;

  @JsonKey(
    name: 'status',
    toJson: ReadarrUtilities.queueStatusToJson,
    fromJson: ReadarrUtilities.queueStatusFromJson,
  )
  ReadarrQueueStatus? status;

  @JsonKey(
    name: 'trackedDownloadStatus',
    toJson: ReadarrUtilities.queueTrackedDownloadStatusToJson,
    fromJson: ReadarrUtilities.queueTrackedDownloadStatusFromJson,
  )
  ReadarrTrackedDownloadStatus? trackedDownloadStatus;

  @JsonKey(
    name: 'trackedDownloadState',
    toJson: ReadarrUtilities.queueTrackedDownloadStateToJson,
    fromJson: ReadarrUtilities.queueTrackedDownloadStateFromJson,
  )
  ReadarrTrackedDownloadState? trackedDownloadState;

  @JsonKey(name: 'statusMessages')
  List<ReadarrQueueStatusMessage>? statusMessages;

  @JsonKey(name: 'errorMessage')
  String? errorMessage;

  @JsonKey(name: 'downloadId')
  String? downloadId;

  @JsonKey(
    name: 'protocol',
    toJson: ReadarrUtilities.protocolToJson,
    fromJson: ReadarrUtilities.protocolFromJson,
  )
  ReadarrProtocol? protocol;

  @JsonKey(name: 'downloadClient')
  String? downloadClient;

  @JsonKey(name: 'indexer')
  String? indexer;

  @JsonKey(name: 'outputPath')
  String? outputPath;

  @JsonKey(name: 'id')
  int? id;

  ReadarrQueueRecord({
    this.authorId,
    this.bookId,
    this.series,
    this.episode,
    this.quality,
    this.size,
    this.title,
    this.sizeleft,
    this.timeleft,
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
    this.outputPath,
    this.id,
  });

  @override
  String toString() => json.encode(this.toJson());

  factory ReadarrQueueRecord.fromJson(Map<String, dynamic> json) =>
      _$ReadarrQueueRecordFromJson(json);

  Map<String, dynamic> toJson() => _$ReadarrQueueRecordToJson(this);
}
