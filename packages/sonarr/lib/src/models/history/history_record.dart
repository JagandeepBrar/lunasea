import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:sonarr/models.dart';
import 'package:sonarr/types.dart';
import 'package:sonarr/utilities.dart';

part 'history_record.g.dart';

/// Model to store an individual history record from Sonarr.
@JsonSerializable(explicitToJson: true)
class SonarrHistoryRecord {
    @JsonKey(name: 'episodeId')
    int? episodeId;

    @JsonKey(name: 'seriesId')
    int? seriesId;

    @JsonKey(name: 'sourceTitle')
    String? sourceTitle;

    @JsonKey(name: 'quality')
    SonarrEpisodeFileQuality? quality;

    @JsonKey(name: 'qualityCutoffNotMet')
    bool? qualityCutoffNotMet;

    @JsonKey(name: 'date', toJson: SonarrUtilities.dateTimeToJson, fromJson: SonarrUtilities.dateTimeFromJson)
    DateTime? date;

    @JsonKey(name: 'downloadId')
    String? downloadId;

    @JsonKey(name: 'eventType', toJson: SonarrUtilities.historyEventTypeToJson, fromJson: SonarrUtilities.historyEventTypeFromJson)
    SonarrHistoryEventType? eventType;

    @JsonKey(name: 'data')
    SonarrHistoryRecordData? data;

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
        this.quality,
        this.qualityCutoffNotMet,
        this.date,
        this.downloadId,
        this.eventType,
        this.data,
        this.episode,
        this.series,
        this.id,
    });

    /// Returns a JSON-encoded string version of this object.
    @override
    String toString() => json.encode(this.toJson());

    /// Deserialize a JSON map to a [SonarrHistoryRecord] object.
    factory SonarrHistoryRecord.fromJson(Map<String, dynamic> json) => _$SonarrHistoryRecordFromJson(json);
    /// Serialize a [SonarrHistoryRecord] object to a JSON map.
    Map<String, dynamic> toJson() => _$SonarrHistoryRecordToJson(this);
}
