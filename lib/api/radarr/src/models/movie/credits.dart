import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:lunasea/api/radarr/types.dart';
import 'package:lunasea/api/radarr/utilities.dart';
import 'package:lunasea/api/radarr/models.dart';

part 'credits.g.dart';

/// Store details about credits for a person who has worked on the movie.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class RadarrMovieCredits {
  @JsonKey(name: 'personName')
  String? personName;

  @JsonKey(name: 'creditTmdbId')
  String? creditTmdbId;

  @JsonKey(name: 'personTmdbId')
  int? personTmdbId;

  @JsonKey(name: 'movieId')
  int? movieId;

  @JsonKey(name: 'images')
  List<RadarrImage>? images;

  @JsonKey(name: 'character')
  String? character;

  @JsonKey(name: 'department')
  String? department;

  @JsonKey(name: 'job')
  String? job;

  @JsonKey(name: 'order')
  int? order;

  @JsonKey(
      name: 'type',
      toJson: RadarrUtilities.creditTypeToJson,
      fromJson: RadarrUtilities.creditTypeFromJson)
  RadarrCreditType? type;

  @JsonKey(name: 'id')
  int? id;

  RadarrMovieCredits({
    this.personName,
    this.creditTmdbId,
    this.personTmdbId,
    this.movieId,
    this.images,
    this.character,
    this.department,
    this.job,
    this.order,
    this.type,
    this.id,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [RadarrMovieCredits] object.
  factory RadarrMovieCredits.fromJson(Map<String, dynamic> json) =>
      _$RadarrMovieCreditsFromJson(json);

  /// Serialize a [RadarrMovieCredits] object to a JSON map.
  Map<String, dynamic> toJson() => _$RadarrMovieCreditsToJson(this);
}
