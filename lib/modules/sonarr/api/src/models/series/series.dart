import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:lunasea/modules/sonarr.dart';

part 'series.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class SonarrSeries {
  @JsonKey(name: 'title')
  String? title;

  @JsonKey(name: 'alternateTitles')
  List<SonarrSeriesAlternateTitle>? alternateTitles;

  @JsonKey(name: 'sortTitle')
  String? sortTitle;

  @JsonKey(name: 'status')
  String? status;

  @JsonKey(name: 'ended')
  bool? ended;

  @JsonKey(name: 'overview')
  String? overview;

  @JsonKey(
    name: 'nextAiring',
    toJson: SonarrUtilities.dateTimeToJson,
    fromJson: SonarrUtilities.dateTimeFromJson,
  )
  DateTime? nextAiring;

  @JsonKey(
    name: 'previousAiring',
    toJson: SonarrUtilities.dateTimeToJson,
    fromJson: SonarrUtilities.dateTimeFromJson,
  )
  DateTime? previousAiring;

  @JsonKey(name: 'network')
  String? network;

  @JsonKey(name: 'airTime')
  String? airTime;

  @JsonKey(name: 'images')
  List<SonarrImage>? images;

  @JsonKey(name: 'remotePoster')
  String? remotePoster;

  @JsonKey(name: 'seasons')
  List<SonarrSeriesSeason>? seasons;

  @JsonKey(name: 'year')
  int? year;

  @JsonKey(name: 'path')
  String? path;

  @JsonKey(name: 'qualityProfileId')
  int? qualityProfileId;

  @JsonKey(name: 'languageProfileId')
  int? languageProfileId;

  @JsonKey(name: 'seasonFolder')
  bool? seasonFolder;

  @JsonKey(name: 'monitored')
  bool? monitored;

  @JsonKey(name: 'useSceneNumbering')
  bool? useSceneNumbering;

  @JsonKey(name: 'runtime')
  int? runtime;

  @JsonKey(name: 'tvdbId')
  int? tvdbId;

  @JsonKey(name: 'tvRageId')
  int? tvRageId;

  @JsonKey(name: 'tvMazeId')
  int? tvMazeId;

  @JsonKey(
    name: 'firstAired',
    toJson: SonarrUtilities.dateTimeToJson,
    fromJson: SonarrUtilities.dateTimeFromJson,
  )
  DateTime? firstAired;

  @JsonKey(
    name: 'seriesType',
    fromJson: SonarrUtilities.seriesTypeFromJson,
    toJson: SonarrUtilities.seriesTypeToJson,
  )
  SonarrSeriesType? seriesType;

  @JsonKey(name: 'cleanTitle')
  String? cleanTitle;

  @JsonKey(name: 'imdbId')
  String? imdbId;

  @JsonKey(name: 'titleSlug')
  String? titleSlug;

  @JsonKey(name: 'folder')
  String? folder;

  @JsonKey(name: 'rootFolderPath')
  String? rootFolderPath;

  @JsonKey(name: 'certification')
  String? certification;

  @JsonKey(name: 'genres')
  List<String>? genres;

  @JsonKey(name: 'tags')
  List<int>? tags;

  @JsonKey(
    name: 'added',
    toJson: SonarrUtilities.dateTimeToJson,
    fromJson: SonarrUtilities.dateTimeFromJson,
  )
  DateTime? added;

  @JsonKey(name: 'ratings')
  SonarrSeriesRating? ratings;

  @JsonKey(name: 'statistics')
  SonarrSeriesStatistics? statistics;

  @JsonKey(name: 'id')
  int? id;

  SonarrSeries({
    this.title,
    this.alternateTitles,
    this.sortTitle,
    this.status,
    this.ended,
    this.overview,
    this.nextAiring,
    this.previousAiring,
    this.network,
    this.airTime,
    this.images,
    this.remotePoster,
    this.seasons,
    this.year,
    this.path,
    this.qualityProfileId,
    this.languageProfileId,
    this.seasonFolder,
    this.monitored,
    this.useSceneNumbering,
    this.runtime,
    this.tvdbId,
    this.tvRageId,
    this.tvMazeId,
    this.firstAired,
    this.seriesType,
    this.cleanTitle,
    this.imdbId,
    this.titleSlug,
    this.folder,
    this.rootFolderPath,
    this.certification,
    this.genres,
    this.tags,
    this.added,
    this.ratings,
    this.statistics,
    this.id,
  });

  @override
  String toString() => json.encode(this.toJson());

  factory SonarrSeries.fromJson(Map<String, dynamic> json) =>
      _$SonarrSeriesFromJson(json);

  Map<String, dynamic> toJson() => _$SonarrSeriesToJson(this);
}
