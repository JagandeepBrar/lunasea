import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:lunasea/api/radarr/types.dart';
import 'package:lunasea/api/radarr/utilities.dart';

part 'directory.g.dart';

/// Model for a directory from the filesystem from Radarr.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class RadarrFileSystemDirectory {
  @JsonKey(
      name: 'type',
      fromJson: RadarrUtilities.fileSystemTypeFromJson,
      toJson: RadarrUtilities.fileSystemTypeToJson)
  RadarrFileSystemType? type;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'path')
  String? path;

  @JsonKey(name: 'size')
  int? size;

  @JsonKey(
      name: 'lastModified',
      fromJson: RadarrUtilities.dateTimeFromJson,
      toJson: RadarrUtilities.dateTimeToJson)
  DateTime? lastModified;

  RadarrFileSystemDirectory({
    this.type,
    this.name,
    this.path,
    this.size,
    this.lastModified,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [RadarrFileSystemDirectory] object.
  factory RadarrFileSystemDirectory.fromJson(Map<String, dynamic> json) =>
      _$RadarrFileSystemDirectoryFromJson(json);

  /// Serialize a [RadarrFileSystemDirectory] object to a JSON map.
  Map<String, dynamic> toJson() => _$RadarrFileSystemDirectoryToJson(this);
}
