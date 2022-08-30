import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:lunasea/api/radarr/models.dart';

part 'manual_import_file.g.dart';

/// Model for an manual import file.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class RadarrManualImportFile {
  @JsonKey(name: 'path')
  String? path;

  @JsonKey(name: 'movieId')
  int? movieId;

  @JsonKey(name: 'quality')
  RadarrMovieFileQuality? quality;

  @JsonKey(name: 'languages')
  List<RadarrLanguage>? languages;

  RadarrManualImportFile({
    this.path,
    this.movieId,
    this.quality,
    this.languages,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [RadarrManualImportFile] object.
  factory RadarrManualImportFile.fromJson(Map<String, dynamic> json) =>
      _$RadarrManualImportFileFromJson(json);

  /// Serialize a [RadarrManualImportFile] object to a JSON map.
  Map<String, dynamic> toJson() => _$RadarrManualImportFileToJson(this);
}
