import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'quality_revision.g.dart';

/// Model for an movie file's quality profile's revision.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class RadarrQualityRevision {
  @JsonKey(name: 'version')
  int? version;

  @JsonKey(name: 'real')
  int? real;

  @JsonKey(name: 'isRepack')
  bool? isRepack;

  RadarrQualityRevision({
    this.version,
    this.real,
    this.isRepack,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [RadarrQualityRevision] object.
  factory RadarrQualityRevision.fromJson(Map<String, dynamic> json) =>
      _$RadarrQualityRevisionFromJson(json);

  /// Serialize a [RadarrQualityRevision] object to a JSON map.
  Map<String, dynamic> toJson() => _$RadarrQualityRevisionToJson(this);
}
