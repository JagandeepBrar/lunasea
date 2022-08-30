import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:lunasea/api/radarr/models.dart';

part 'manual_import_update_data.g.dart';

/// Model for an manual import update data that is attached to update requests.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class RadarrManualImportUpdateData {
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'path')
  String? path;

  @JsonKey(name: 'movieId')
  int? movieId;

  @JsonKey(name: 'quality')
  RadarrMovieFileQuality? quality;

  @JsonKey(name: 'languages')
  List<RadarrLanguage>? languages;

  RadarrManualImportUpdateData({
    this.id,
    this.path,
    this.movieId,
    this.quality,
    this.languages,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [RadarrManualImportUpdateData] object.
  factory RadarrManualImportUpdateData.fromJson(Map<String, dynamic> json) =>
      _$RadarrManualImportUpdateDataFromJson(json);

  /// Serialize a [RadarrManualImportUpdateData] object to a JSON map.
  Map<String, dynamic> toJson() => _$RadarrManualImportUpdateDataToJson(this);
}
