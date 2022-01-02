import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:lunasea/modules/radarr.dart';

part 'movie.g.dart';

/// Model for a single movie data from Radarr.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class RadarrMovie {
  @JsonKey(name: 'title')
  String? title;

  @JsonKey(name: 'originalTitle')
  String? originalTitle;

  @JsonKey(name: 'alternateTitles')
  List<RadarrMovieAlternateTitles>? alternateTitles;

  @JsonKey(name: 'secondaryYearSourceId')
  int? secondaryYearSourceId;

  @JsonKey(name: 'sortTitle')
  String? sortTitle;

  @JsonKey(name: 'sizeOnDisk')
  int? sizeOnDisk;

  @JsonKey(
      name: 'status',
      toJson: RadarrUtilities.availabilityToJson,
      fromJson: RadarrUtilities.availabilityFromJson)
  RadarrAvailability? status;

  @JsonKey(name: 'overview')
  String? overview;

  @JsonKey(
      name: 'inCinemas',
      toJson: RadarrUtilities.dateTimeToJson,
      fromJson: RadarrUtilities.dateTimeFromJson)
  DateTime? inCinemas;

  @JsonKey(
      name: 'physicalRelease',
      toJson: RadarrUtilities.dateTimeToJson,
      fromJson: RadarrUtilities.dateTimeFromJson)
  DateTime? physicalRelease;

  @JsonKey(
      name: 'digitalRelease',
      toJson: RadarrUtilities.dateTimeToJson,
      fromJson: RadarrUtilities.dateTimeFromJson)
  DateTime? digitalRelease;

  @JsonKey(name: 'images')
  List<RadarrImage>? images;

  @JsonKey(name: 'website')
  String? website;

  @JsonKey(name: 'remotePoster')
  String? remotePoster;

  @JsonKey(name: 'year')
  int? year;

  @JsonKey(name: 'hasFile')
  bool? hasFile;

  @JsonKey(name: 'youTubeTrailerId')
  String? youTubeTrailerId;

  @JsonKey(name: 'studio')
  String? studio;

  @JsonKey(name: 'path')
  String? path;

  @JsonKey(name: 'qualityProfileId')
  int? qualityProfileId;

  @JsonKey(name: 'monitored')
  bool? monitored;

  @JsonKey(
      name: 'minimumAvailability',
      toJson: RadarrUtilities.availabilityToJson,
      fromJson: RadarrUtilities.availabilityFromJson)
  RadarrAvailability? minimumAvailability;

  @JsonKey(name: 'isAvailable')
  bool? isAvailable;

  @JsonKey(name: 'folderName')
  String? folderName;

  @JsonKey(name: 'runtime')
  int? runtime;

  @JsonKey(name: 'cleanTitle')
  String? cleanTitle;

  @JsonKey(name: 'imdbId')
  String? imdbId;

  @JsonKey(name: 'tmdbId')
  int? tmdbId;

  @JsonKey(name: 'titleSlug')
  String? titleSlug;

  @JsonKey(name: 'certification')
  String? certification;

  @JsonKey(name: 'genres')
  List<String>? genres;

  @JsonKey(name: 'tags')
  List<int?>? tags;

  @JsonKey(
      name: 'added',
      toJson: RadarrUtilities.dateTimeToJson,
      fromJson: RadarrUtilities.dateTimeFromJson)
  DateTime? added;

  @JsonKey(name: 'ratings')
  RadarrMovieRating? ratings;

  @JsonKey(name: 'movieFile')
  RadarrMovieFile? movieFile;

  @JsonKey(name: 'collection')
  RadarrMovieCollection? collection;

  @JsonKey(name: 'id')
  int? id;

  RadarrMovie({
    this.title,
    this.originalTitle,
    this.alternateTitles,
    this.secondaryYearSourceId,
    this.sortTitle,
    this.sizeOnDisk,
    this.status,
    this.overview,
    this.inCinemas,
    this.physicalRelease,
    this.digitalRelease,
    this.images,
    this.website,
    this.remotePoster,
    this.year,
    this.hasFile,
    this.youTubeTrailerId,
    this.studio,
    this.path,
    this.qualityProfileId,
    this.monitored,
    this.minimumAvailability,
    this.isAvailable,
    this.folderName,
    this.runtime,
    this.cleanTitle,
    this.imdbId,
    this.tmdbId,
    this.titleSlug,
    this.certification,
    this.genres,
    this.tags,
    this.added,
    this.ratings,
    this.movieFile,
    this.collection,
    this.id,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [RadarrMovie] object.
  factory RadarrMovie.fromJson(Map<String, dynamic> json) =>
      _$RadarrMovieFromJson(json);

  /// Serialize a [RadarrMovie] object to a JSON map.
  Map<String, dynamic> toJson() => _$RadarrMovieToJson(this);
}
