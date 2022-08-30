import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:lunasea/api/radarr/utilities.dart';
import 'package:lunasea/api/radarr/models.dart';
import 'package:lunasea/api/radarr/types.dart';

part 'release.g.dart';

/// Model for a movie release from Radarr.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class RadarrRelease {
  @JsonKey(name: 'guid')
  String? guid;

  @JsonKey(name: 'quality')
  RadarrMovieFileQuality? quality;

  @JsonKey(name: 'customFormats')
  List<RadarrCustomFormat>? customFormats;

  @JsonKey(name: 'customFormatScore')
  int? customFormatScore;

  @JsonKey(name: 'qualityWeight')
  int? qualityWeight;

  @JsonKey(name: 'age')
  int? age;

  @JsonKey(name: 'ageHours')
  double? ageHours;

  @JsonKey(name: 'ageMinutes')
  double? ageMinutes;

  @JsonKey(name: 'size')
  int? size;

  @JsonKey(name: 'indexerId')
  int? indexerId;

  @JsonKey(name: 'indexer')
  String? indexer;

  @JsonKey(name: 'releaseGroup')
  String? releaseGroup;

  @JsonKey(name: 'releaseHash')
  String? releaseHash;

  @JsonKey(name: 'title')
  String? title;

  @JsonKey(name: 'sceneSource')
  bool? sceneSource;

  @JsonKey(name: 'movieTitle')
  String? movieTitle;

  @JsonKey(name: 'languages')
  List<RadarrLanguage>? languages;

  @JsonKey(name: 'approved')
  bool? approved;

  @JsonKey(name: 'temporarilyRejected')
  bool? temporarilyRejected;

  @JsonKey(name: 'rejected')
  bool? rejected;

  @JsonKey(name: 'imdbId')
  int? imdbId;

  @JsonKey(name: 'rejections')
  List<String>? rejections;

  @JsonKey(
      name: 'publishDate',
      toJson: RadarrUtilities.dateTimeToJson,
      fromJson: RadarrUtilities.dateTimeFromJson)
  DateTime? publishDate;

  @JsonKey(name: 'commentUrl')
  String? commentUrl;

  @JsonKey(name: 'downloadUrl')
  String? downloadUrl;

  @JsonKey(name: 'infoUrl')
  String? infoUrl;

  @JsonKey(name: 'downloadAllowed')
  bool? downloadAllowed;

  @JsonKey(name: 'releaseWeight')
  int? releaseWeight;

  @JsonKey(name: 'edition')
  String? edition;

  @JsonKey(name: 'seeders')
  int? seeders;

  @JsonKey(name: 'leechers')
  int? leechers;

  @JsonKey(
      name: 'protocol',
      toJson: RadarrUtilities.protocolToJson,
      fromJson: RadarrUtilities.protocolFromJson)
  RadarrProtocol? protocol;

  RadarrRelease({
    this.guid,
    this.quality,
    this.customFormats,
    this.customFormatScore,
    this.qualityWeight,
    this.age,
    this.ageHours,
    this.ageMinutes,
    this.size,
    this.indexerId,
    this.indexer,
    this.releaseGroup,
    this.releaseHash,
    this.title,
    this.sceneSource,
    this.movieTitle,
    this.languages,
    this.approved,
    this.temporarilyRejected,
    this.rejected,
    this.imdbId,
    this.rejections,
    this.publishDate,
    this.commentUrl,
    this.downloadUrl,
    this.infoUrl,
    this.downloadAllowed,
    this.releaseWeight,
    this.edition,
    this.seeders,
    this.leechers,
    this.protocol,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [RadarrRelease] object.
  factory RadarrRelease.fromJson(Map<String, dynamic> json) =>
      _$RadarrReleaseFromJson(json);

  /// Serialize a [RadarrRelease] object to a JSON map.
  Map<String, dynamic> toJson() => _$RadarrReleaseToJson(this);
}
