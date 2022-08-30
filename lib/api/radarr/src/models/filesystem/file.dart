import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:lunasea/api/radarr/types.dart';
import 'package:lunasea/api/radarr/utilities.dart';

part 'file.g.dart';

/// Model for a file from the filesystem from Radarr.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class RadarrFileSystemFile {
  @JsonKey(
      name: 'type',
      fromJson: RadarrUtilities.fileSystemTypeFromJson,
      toJson: RadarrUtilities.fileSystemTypeToJson)
  RadarrFileSystemType? type;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'path')
  String? path;

  @JsonKey(name: 'extension')
  String? extension;

  @JsonKey(name: 'size')
  int? size;

  @JsonKey(
      name: 'lastModified',
      fromJson: RadarrUtilities.dateTimeFromJson,
      toJson: RadarrUtilities.dateTimeToJson)
  DateTime? lastModified;

  RadarrFileSystemFile({
    this.type,
    this.name,
    this.path,
    this.extension,
    this.size,
    this.lastModified,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [RadarrFileSystemFile] object.
  factory RadarrFileSystemFile.fromJson(Map<String, dynamic> json) =>
      _$RadarrFileSystemFileFromJson(json);

  /// Serialize a [RadarrFileSystemFile] object to a JSON map.
  Map<String, dynamic> toJson() => _$RadarrFileSystemFileToJson(this);
}
