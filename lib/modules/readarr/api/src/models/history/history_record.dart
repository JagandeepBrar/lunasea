import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:lunasea/modules/readarr.dart';

part 'history_record.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ReadarrHistoryRecord {
  @JsonKey(name: 'bookId')
  int? bookId;

  @JsonKey(name: 'authorId')
  int? authorId;

  @JsonKey(name: 'sourceTitle')
  String? sourceTitle;

  @JsonKey(name: 'quality')
  ReadarrBookFileQuality? quality;

  @JsonKey(name: 'qualityCutoffNotMet')
  bool? qualityCutoffNotMet;

  @JsonKey(
    name: 'date',
    toJson: ReadarrUtilities.dateTimeToJson,
    fromJson: ReadarrUtilities.dateTimeFromJson,
  )
  DateTime? date;

  @JsonKey(name: 'downloadId')
  String? downloadId;

  @JsonKey(
    name: 'eventType',
    toJson: ReadarrUtilities.eventTypeToJson,
    fromJson: ReadarrUtilities.eventTypeFromJson,
  )
  ReadarrEventType? eventType;

  @JsonKey(name: 'data')
  Map<String, dynamic>? data;

  @JsonKey(name: 'book')
  ReadarrBook? episode;

  @JsonKey(name: 'author')
  ReadarrAuthor? series;

  @JsonKey(name: 'id')
  int? id;

  ReadarrHistoryRecord({
    this.bookId,
    this.authorId,
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

  @override
  String toString() => json.encode(this.toJson());

  factory ReadarrHistoryRecord.fromJson(Map<String, dynamic> json) =>
      _$ReadarrHistoryRecordFromJson(json);

  Map<String, dynamic> toJson() => _$ReadarrHistoryRecordToJson(this);
}
