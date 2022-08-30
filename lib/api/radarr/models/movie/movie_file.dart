import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:lunasea/api/radarr/utilities.dart';
import 'package:lunasea/api/radarr/models.dart';

part 'movie_file.g.dart';

@JsonSerializable()
class RadarrMovieFile {
  @JsonKey()
  int? movieId;

  @JsonKey()
  String? relativePath;

  @JsonKey()
  String? path;

  @JsonKey()
  int? size;

  @JsonKey(
    toJson: RadarrUtilities.dateTimeToJson,
    fromJson: RadarrUtilities.dateTimeFromJson,
  )
  DateTime? dateAdded;

  @JsonKey()
  RadarrMovieFileQuality? quality;

  @JsonKey()
  List<RadarrCustomFormat>? customFormats;

  @JsonKey()
  RadarrMovieFileMediaInfo? mediaInfo;

  @JsonKey()
  bool? qualityCutoffNotMet;

  @JsonKey()
  List<RadarrLanguage>? languages;

  @JsonKey()
  String? edition;

  @JsonKey()
  int? id;

  RadarrMovieFile({
    this.movieId,
    this.relativePath,
    this.path,
    this.size,
    this.dateAdded,
    this.quality,
    this.customFormats,
    this.mediaInfo,
    this.qualityCutoffNotMet,
    this.languages,
    this.edition,
    this.id,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [RadarrMovieFile] object.
  factory RadarrMovieFile.fromJson(Map<String, dynamic> json) =>
      _$RadarrMovieFileFromJson(json);

  /// Serialize a [RadarrMovieFile] object to a JSON map.
  Map<String, dynamic> toJson() => _$RadarrMovieFileToJson(this);
}
