import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:lunasea/api/radarr/models.dart';

part 'movie_file_quality.g.dart';

/// Model for an movie file's quality profile.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class RadarrMovieFileQuality {
  @JsonKey(name: 'quality')
  RadarrQuality? quality;

  @JsonKey(name: 'revision')
  RadarrQualityRevision? revision;

  RadarrMovieFileQuality({
    this.quality,
    this.revision,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [RadarrMovieFileQuality] object.
  factory RadarrMovieFileQuality.fromJson(Map<String, dynamic> json) =>
      _$RadarrMovieFileQualityFromJson(json);

  /// Serialize a [RadarrMovieFileQuality] object to a JSON map.
  Map<String, dynamic> toJson() => _$RadarrMovieFileQualityToJson(this);
}
