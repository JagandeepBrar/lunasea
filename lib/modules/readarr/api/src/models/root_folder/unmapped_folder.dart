import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'unmapped_folder.g.dart';

/// Model for unmapped folders within a root folder from Readarr.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ReadarrUnmappedFolder {
  /// Folder name
  @JsonKey(name: 'name')
  String? name;

  /// Root folder's path
  @JsonKey(name: 'path')
  String? path;

  ReadarrUnmappedFolder({
    this.name,
    this.path,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [ReadarrUnmappedFolder] object.
  factory ReadarrUnmappedFolder.fromJson(Map<String, dynamic> json) =>
      _$ReadarrUnmappedFolderFromJson(json);

  /// Serialize a [ReadarrUnmappedFolder] object to a JSON map.
  Map<String, dynamic> toJson() => _$ReadarrUnmappedFolderToJson(this);
}
