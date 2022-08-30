import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'exclusion.g.dart';

/// Model for exclusion details from Radarr.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class RadarrExclusion {
  @JsonKey(name: 'tmdbId')
  int? tmdbId;

  @JsonKey(name: 'movieTitle')
  String? movieTitle;

  @JsonKey(name: 'movieYear')
  int? movieYear;

  @JsonKey(name: 'id')
  int? id;

  RadarrExclusion({
    this.tmdbId,
    this.movieTitle,
    this.movieYear,
    this.id,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [RadarrExclusion] object.
  factory RadarrExclusion.fromJson(Map<String, dynamic> json) =>
      _$RadarrExclusionFromJson(json);

  /// Serialize a [RadarrExclusion] object to a JSON map.
  Map<String, dynamic> toJson() => _$RadarrExclusionToJson(this);
}
