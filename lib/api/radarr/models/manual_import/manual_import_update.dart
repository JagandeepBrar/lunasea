import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:lunasea/api/radarr/models.dart';

part 'manual_import_update.g.dart';

/// Model for manual import update results from Radarr.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class RadarrManualImportUpdate {
  @JsonKey(name: 'path')
  String? path;

  @JsonKey(name: 'movieId')
  int? movieId;

  @JsonKey(name: 'movie')
  RadarrMovie? movie;

  @JsonKey(name: 'rejections')
  List<RadarrManualImportRejection>? rejections;

  @JsonKey(name: 'id')
  int? id;

  RadarrManualImportUpdate({
    this.path,
    this.movieId,
    this.movie,
    this.rejections,
    this.id,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [RadarrManualImportUpdate] object.
  factory RadarrManualImportUpdate.fromJson(Map<String, dynamic> json) =>
      _$RadarrManualImportUpdateFromJson(json);

  /// Serialize a [RadarrManualImportUpdate] object to a JSON map.
  Map<String, dynamic> toJson() => _$RadarrManualImportUpdateToJson(this);
}
