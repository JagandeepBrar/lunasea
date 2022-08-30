import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:lunasea/api/radarr/models.dart';

part 'alternate_titles.g.dart';

/// Store details about alternate titles available for a movie.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class RadarrMovieAlternateTitles {
  @JsonKey(name: 'sourceType')
  String? sourceType;

  @JsonKey(name: 'movieId')
  int? movieId;

  @JsonKey(name: 'title')
  String? title;

  @JsonKey(name: 'sourceId')
  int? sourceId;

  @JsonKey(name: 'votes')
  int? votes;

  @JsonKey(name: 'voteCount')
  int? voteCount;

  @JsonKey(name: 'language')
  RadarrLanguage? language;

  @JsonKey(name: 'id')
  int? id;

  RadarrMovieAlternateTitles({
    this.sourceType,
    this.movieId,
    this.title,
    this.sourceId,
    this.votes,
    this.voteCount,
    this.language,
    this.id,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [RadarrMovieAlternateTitles] object.
  factory RadarrMovieAlternateTitles.fromJson(Map<String, dynamic> json) =>
      _$RadarrMovieAlternateTitlesFromJson(json);

  /// Serialize a [RadarrMovieAlternateTitles] object to a JSON map.
  Map<String, dynamic> toJson() => _$RadarrMovieAlternateTitlesToJson(this);
}
