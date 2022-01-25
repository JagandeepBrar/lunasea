import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'unmapped_folder.g.dart';

/// Model for unmapped folders within a root folder from Radarr.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class RadarrUnmappedFolder {
  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'path')
  String? path;

  RadarrUnmappedFolder({
    this.name,
    this.path,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [RadarrUnmappedFolder] object.
  factory RadarrUnmappedFolder.fromJson(Map<String, dynamic> json) =>
      _$RadarrUnmappedFolderFromJson(json);

  /// Serialize a [RadarrUnmappedFolder] object to a JSON map.
  Map<String, dynamic> toJson() => _$RadarrUnmappedFolderToJson(this);
}
