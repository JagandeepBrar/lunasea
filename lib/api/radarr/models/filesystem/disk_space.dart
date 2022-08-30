import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'disk_space.g.dart';

/// Model for disk space details from Radarr.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class RadarrDiskSpace {
  @JsonKey(name: 'path')
  String? path;

  @JsonKey(name: 'label')
  String? label;

  @JsonKey(name: 'freeSpace')
  int? freeSpace;

  @JsonKey(name: 'totalSpace')
  int? totalSpace;

  RadarrDiskSpace({
    this.path,
    this.label,
    this.freeSpace,
    this.totalSpace,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [RadarrDiskSpace] object.
  factory RadarrDiskSpace.fromJson(Map<String, dynamic> json) =>
      _$RadarrDiskSpaceFromJson(json);

  /// Serialize a [RadarrDiskSpace] object to a JSON map.
  Map<String, dynamic> toJson() => _$RadarrDiskSpaceToJson(this);
}
