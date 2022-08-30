import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:lunasea/api/radarr/models/root_folder/unmapped_folder.dart';

part 'root_folder.g.dart';

/// Model for root folders from Radarr.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class RadarrRootFolder {
  @JsonKey(name: 'path')
  String? path;

  @JsonKey(name: 'accessible')
  bool? accessible;

  @JsonKey(name: 'freeSpace')
  int? freeSpace;

  @JsonKey(name: 'unmappedFolders')
  List<RadarrUnmappedFolder>? unmappedFolders;

  @JsonKey(name: 'id')
  int? id;

  RadarrRootFolder({
    this.path,
    this.accessible,
    this.freeSpace,
    this.unmappedFolders,
    this.id,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [RadarrRootFolder] object.
  factory RadarrRootFolder.fromJson(Map<String, dynamic> json) =>
      _$RadarrRootFolderFromJson(json);

  /// Serialize a [RadarrRootFolder] object to a JSON map.
  Map<String, dynamic> toJson() => _$RadarrRootFolderToJson(this);
}
