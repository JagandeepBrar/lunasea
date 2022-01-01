import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:lunasea/modules/sonarr.dart';

part 'missing_record.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class SonarrMissingRecord {
  @JsonKey(name: 'seriesId')
  int? seriesId;

  @JsonKey(name: 'episodeFileId')
  int? episodeFileId;

  @JsonKey(name: 'seasonNumber')
  int? seasonNumber;

  @JsonKey(name: 'episodeNumber')
  int? episodeNumber;

  @JsonKey(name: 'title')
  String? title;

  @JsonKey(name: 'airDate')
  String? airDate;

  @JsonKey(
      name: 'airDateUtc',
      toJson: SonarrUtilities.dateTimeToJson,
      fromJson: SonarrUtilities.dateTimeFromJson)
  DateTime? airDateUtc;

  @JsonKey(name: 'overview')
  String? overview;

  @JsonKey(name: 'hasFile')
  bool? hasFile;

  @JsonKey(name: 'monitored')
  bool? monitored;

  @JsonKey(name: 'unverifiedSceneNumbering')
  bool? unverifiedSceneNumbering;

  @JsonKey(name: 'images')
  List<SonarrImage?>? images;

  @JsonKey(name: 'series')
  SonarrSeries? series;

  @JsonKey(name: 'id')
  int? id;

  SonarrMissingRecord({
    this.seriesId,
    this.episodeFileId,
    this.seasonNumber,
    this.episodeNumber,
    this.title,
    this.airDate,
    this.airDateUtc,
    this.overview,
    this.hasFile,
    this.monitored,
    this.unverifiedSceneNumbering,
    this.images,
    this.series,
    this.id,
  });

  @override
  String toString() => json.encode(this.toJson());

  factory SonarrMissingRecord.fromJson(Map<String, dynamic> json) =>
      _$SonarrMissingRecordFromJson(json);
  Map<String, dynamic> toJson() => _$SonarrMissingRecordToJson(this);
}
