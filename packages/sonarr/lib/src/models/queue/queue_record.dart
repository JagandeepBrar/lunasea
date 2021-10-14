import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:sonarr/models.dart';
import 'package:sonarr/utilities.dart';

part 'queue_record.g.dart';

/// Model for the from Sonarr.
@JsonSerializable(explicitToJson: true)
class SonarrQueueRecord {
    /// [SonarrSeries] object containing series information
    @JsonKey(name: 'series')
    SonarrSeries? series;

    /// [SonarrEpisode] object containing episode information
    @JsonKey(name: 'episode')
    SonarrEpisode? episode;

    /// [SonarrEpisodeFileQuality] object containing quality information
    @JsonKey(name: 'quality')
    SonarrEpisodeFileQuality? quality;

    /// Size of the queued item
    @JsonKey(name: 'size')
    double? size;

    /// Title of the queued item
    @JsonKey(name: 'title')
    String? title;

    /// Size of the download remaining
    @JsonKey(name: 'sizeleft')
    double? sizeLeft;

    /// Estimated remaining time left
    @JsonKey(name: 'timeleft')
    String? timeLeft;

    /// Estimated time of completion
    @JsonKey(name: 'estimatedCompletionTime', toJson: SonarrUtilities.dateTimeToJson, fromJson: SonarrUtilities.dateTimeFromJson)
    DateTime? estimatedCompletionTime;

    /// Status of the queued item (Delay, Completed, etc.)
    @JsonKey(name: 'status')
    String? status;

    /// Status of the download
    @JsonKey(name: 'trackedDownloadStatus')
    String? trackedDownloadStatus;

    @JsonKey(name: 'statusMessages')
    List<SonarrQueueStatusMessage>? statusMessages;

    /// Protocol being used (torrent, usenet)
    @JsonKey(name: 'protocol')
    String? protocol;

    /// Queue item identifier
    @JsonKey(name: 'id')
    int? id;

    SonarrQueueRecord({
        this.series,
        this.episode,
        this.quality,
        this.size,
        this.title,
        this.sizeLeft,
        this.timeLeft,
        this.estimatedCompletionTime,
        this.status,
        this.trackedDownloadStatus,
        this.statusMessages,
        this.id,
    });

    /// Returns a JSON-encoded string version of this object.
    @override
    String toString() => json.encode(this.toJson());

    /// Deserialize a JSON map to a [SonarrQueueRecord] object.
    factory SonarrQueueRecord.fromJson(Map<String, dynamic> json) => _$SonarrQueueRecordFromJson(json);
    /// Serialize a [SonarrQueueRecord] object to a JSON map.
    Map<String, dynamic> toJson() => _$SonarrQueueRecordToJson(this);
}
