import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'extra_file.g.dart';

/// Model for a movies' extra file information from Radarr.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class RadarrExtraFile {
  @JsonKey(name: 'movieId')
  int? movieId;

  @JsonKey(name: 'movieFileId')
  int? movieFileId;

  @JsonKey(name: 'relativePath')
  String? relativePath;

  @JsonKey(name: 'extension')
  String? extension;

  @JsonKey(name: 'type')
  String? type;

  @JsonKey(name: 'id')
  int? id;

  RadarrExtraFile({
    this.movieId,
    this.movieFileId,
    this.relativePath,
    this.extension,
    this.type,
    this.id,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [RadarrExtraFile] object.
  factory RadarrExtraFile.fromJson(Map<String, dynamic> json) =>
      _$RadarrExtraFileFromJson(json);

  /// Serialize a [RadarrExtraFile] object to a JSON map.
  Map<String, dynamic> toJson() => _$RadarrExtraFileToJson(this);
}
