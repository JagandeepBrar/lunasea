import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:lunasea/modules/sonarr.dart';

part 'episode.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class SonarrEpisode {
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
    fromJson: SonarrUtilities.dateTimeFromJson,
  )
  DateTime? airDateUtc;

  @JsonKey(name: 'overview')
  String? overview;

  @JsonKey(name: 'episodeFile')
  SonarrEpisodeFile? episodeFile;

  @JsonKey(name: 'hasFile')
  bool? hasFile;

  @JsonKey(name: 'monitored')
  bool? monitored;

  @JsonKey(name: 'absoluteEpisodeNumber')
  int? absoluteEpisodeNumber;

  @JsonKey(name: 'unverifiedSceneNumbering')
  bool? unverifiedSceneNumbering;

  @JsonKey(name: 'series')
  SonarrSeries? series;

  @JsonKey(name: 'images')
  List<SonarrImage>? images;

  @JsonKey(name: 'id')
  int? id;

  SonarrEpisode({
    this.seriesId,
    this.episodeFileId,
    this.seasonNumber,
    this.episodeNumber,
    this.title,
    this.airDate,
    this.airDateUtc,
    this.overview,
    this.episodeFile,
    this.hasFile,
    this.monitored,
    this.absoluteEpisodeNumber,
    this.unverifiedSceneNumbering,
    this.series,
    this.id,
  });

  @override
  String toString() => json.encode(this.toJson());

  factory SonarrEpisode.fromJson(Map<String, dynamic> json) =>
      _$SonarrEpisodeFromJson(json);
  Map<String, dynamic> toJson() => _$SonarrEpisodeToJson(this);
}
