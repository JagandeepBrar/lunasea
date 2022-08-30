import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:lunasea/api/radarr/models.dart';

part 'filesystem.g.dart';

/// Model for a call to the filesystem from Radarr.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class RadarrFileSystem {
  @JsonKey(name: 'parent')
  String? parent;

  @JsonKey(name: 'directories')
  List<RadarrFileSystemDirectory>? directories;

  @JsonKey(name: 'files')
  List<RadarrFileSystemFile>? files;

  RadarrFileSystem({
    this.parent,
    this.directories,
    this.files,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [RadarrFileSystem] object.
  factory RadarrFileSystem.fromJson(Map<String, dynamic> json) =>
      _$RadarrFileSystemFromJson(json);

  /// Serialize a [RadarrFileSystem] object to a JSON map.
  Map<String, dynamic> toJson() => _$RadarrFileSystemToJson(this);
}
