import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:sonarr/utilities.dart';

part 'calendar.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class SonarrCalendar {
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
    fromJson: SonarrUtilities.dateTimeFromJson,
    toJson: SonarrUtilities.dateTimeToJson,
  )
  DateTime? airDateUtc;

  @JsonKey(name: 'overview')
  String? overview;

  @JsonKey(name: 'hasFile')
  bool? hasFile;

  @JsonKey(name: 'monitored')
  bool? monitored;

  @JsonKey(name: 'absoluteEpisodeNumber')
  int? absoluteEpisodeNumber;

  @JsonKey(name: 'sceneAbsoluteEpisodeNumber')
  int? sceneAbsoluteEpisodeNumber;

  @JsonKey(name: 'sceneEpisodeNumber')
  int? sceneEpisodeNumber;

  @JsonKey(name: 'sceneSeasonNumber')
  int? sceneSeasonNumber;

  @JsonKey(name: 'unverifiedSceneNumbering')
  bool? unverifiedSceneNumbering;

  @JsonKey(name: 'id')
  int? id;

  SonarrCalendar({
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
    this.absoluteEpisodeNumber,
    this.sceneAbsoluteEpisodeNumber,
    this.sceneEpisodeNumber,
    this.sceneSeasonNumber,
    this.unverifiedSceneNumbering,
    this.id,
  });

  @override
  String toString() => json.encode(this.toJson());

  factory SonarrCalendar.fromJson(Map<String, dynamic> json) =>
      _$SonarrCalendarFromJson(json);
  Map<String, dynamic> toJson() => _$SonarrCalendarToJson(this);
}
