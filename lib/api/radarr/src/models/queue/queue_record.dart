import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:lunasea/api/radarr/utilities.dart';
import 'package:lunasea/api/radarr/models.dart';
import 'package:lunasea/api/radarr/types.dart';

part 'queue_record.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class RadarrQueueRecord {
  @JsonKey(name: 'movieId')
  int? movieId;

  @JsonKey(name: 'languages')
  List<RadarrLanguage>? languages;

  @JsonKey(name: 'quality')
  RadarrMovieFileQuality? quality;

  @JsonKey(name: 'customFormats')
  List<RadarrCustomFormat>? customFormats;

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
      fromJson: RadarrUtilities.dateTimeFromJson,
      toJson: RadarrUtilities.dateTimeToJson)
  DateTime? estimatedCompletionTime;

  @JsonKey(
      name: 'status',
      fromJson: RadarrUtilities.queueRecordStatusFromJson,
      toJson: RadarrUtilities.queueRecordStatusToJson)
  RadarrQueueRecordStatus? status;

  @JsonKey(
      name: 'trackedDownloadStatus',
      fromJson: RadarrUtilities.trackedDownloadStatusFromJson,
      toJson: RadarrUtilities.trackedDownloadStatusToJson)
  RadarrTrackedDownloadStatus? trackedDownloadStatus;

  @JsonKey(
      name: 'trackedDownloadState',
      fromJson: RadarrUtilities.trackedDownloadStateFromJson,
      toJson: RadarrUtilities.trackedDownloadStateToJson)
  RadarrTrackedDownloadState? trackedDownloadState;

  @JsonKey(name: 'statusMessages')
  List<RadarrQueueStatusMessage>? statusMessages;

  @JsonKey(name: 'downloadId')
  String? downloadId;

  @JsonKey(
      name: 'protocol',
      fromJson: RadarrUtilities.protocolFromJson,
      toJson: RadarrUtilities.protocolToJson)
  RadarrProtocol? protocol;

  @JsonKey(name: 'downloadClient')
  String? downloadClient;

  @JsonKey(name: 'indexer')
  String? indexer;

  @JsonKey(name: 'outputPath')
  String? outputPath;

  @JsonKey(name: 'id')
  int? id;

  RadarrQueueRecord({
    this.movieId,
    this.languages,
    this.quality,
    this.customFormats,
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
    this.outputPath,
    this.id,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [RadarrQueueRecord] object.
  factory RadarrQueueRecord.fromJson(Map<String, dynamic> json) =>
      _$RadarrQueueRecordFromJson(json);

  /// Serialize a [RadarrQueueRecord] object to a JSON map.
  Map<String, dynamic> toJson() => _$RadarrQueueRecordToJson(this);
}
