import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:lunasea/api/radarr/models.dart';

part 'manual_import.g.dart';

/// Model for manual import results from Radarr.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class RadarrManualImport {
  @JsonKey(name: 'path')
  String? path;

  @JsonKey(name: 'relativePath')
  String? relativePath;

  @JsonKey(name: 'folderName')
  String? folderName;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'size')
  int? size;

  @JsonKey(name: 'movie')
  RadarrMovie? movie;

  @JsonKey(name: 'quality')
  RadarrMovieFileQuality? quality;

  @JsonKey(name: 'languages')
  List<RadarrLanguage>? languages;

  @JsonKey(name: 'qualityWeight')
  int? qualityWeight;

  @JsonKey(name: 'rejections')
  List<RadarrManualImportRejection>? rejections;

  @JsonKey(name: 'id')
  int? id;

  RadarrManualImport({
    this.path,
    this.relativePath,
    this.folderName,
    this.name,
    this.size,
    this.movie,
    this.quality,
    this.languages,
    this.qualityWeight,
    this.rejections,
    this.id,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [RadarrManualImport] object.
  factory RadarrManualImport.fromJson(Map<String, dynamic> json) =>
      _$RadarrManualImportFromJson(json);

  /// Serialize a [RadarrManualImport] object to a JSON map.
  Map<String, dynamic> toJson() => _$RadarrManualImportToJson(this);
}
