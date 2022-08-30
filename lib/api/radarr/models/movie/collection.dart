import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:lunasea/api/radarr/models.dart';

part 'collection.g.dart';

/// Store details about a collection the movie is apart of.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class RadarrMovieCollection {
  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'tmdbId')
  int? tmdbId;

  @JsonKey(name: 'images')
  List<RadarrImage>? images;

  RadarrMovieCollection({
    this.name,
    this.tmdbId,
    this.images,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [RadarrMovieCollection] object.
  factory RadarrMovieCollection.fromJson(Map<String, dynamic> json) =>
      _$RadarrMovieCollectionFromJson(json);

  /// Serialize a [RadarrMovieCollection] object to a JSON map.
  Map<String, dynamic> toJson() => _$RadarrMovieCollectionToJson(this);
}
