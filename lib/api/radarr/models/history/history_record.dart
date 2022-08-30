import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:lunasea/api/radarr/types.dart';
import 'package:lunasea/api/radarr/utilities.dart';
import 'package:lunasea/api/radarr/models.dart';

part 'history_record.g.dart';

/// Model for a history record from Radarr.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class RadarrHistoryRecord {
  @JsonKey(name: 'movieId')
  int? movieId;

  @JsonKey(name: 'sourceTitle')
  String? sourceTitle;

  @JsonKey(name: 'languages')
  List<RadarrLanguage>? languages;

  @JsonKey(name: 'quality')
  RadarrMovieFileQuality? quality;

  @JsonKey(name: 'customFormats')
  List<RadarrCustomFormat>? customFormats;

  @JsonKey(name: 'qualityCutoffNotMet')
  bool? qualityCutoffNotMet;

  @JsonKey(
      name: 'date',
      toJson: RadarrUtilities.dateTimeToJson,
      fromJson: RadarrUtilities.dateTimeFromJson)
  DateTime? date;

  @JsonKey(name: 'downloadId')
  String? downloadId;

  @JsonKey(
      name: 'eventType',
      toJson: RadarrUtilities.eventTypeToJson,
      fromJson: RadarrUtilities.eventTypeFromJson)
  RadarrEventType? eventType;

  @JsonKey(name: 'data')
  Map<String, dynamic>? data;

  @JsonKey(name: 'id')
  int? id;

  RadarrHistoryRecord({
    this.movieId,
    this.sourceTitle,
    this.languages,
    this.quality,
    this.customFormats,
    this.qualityCutoffNotMet,
    this.date,
    this.downloadId,
    this.eventType,
    this.data,
    this.id,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [RadarrHistoryRecord] object.
  factory RadarrHistoryRecord.fromJson(Map<String, dynamic> json) =>
      _$RadarrHistoryRecordFromJson(json);

  /// Serialize a [RadarrHistoryRecord] object to a JSON map.
  Map<String, dynamic> toJson() => _$RadarrHistoryRecordToJson(this);
}
