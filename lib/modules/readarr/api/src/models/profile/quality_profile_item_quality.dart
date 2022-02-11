import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'quality_profile_item_quality.g.dart';

/// Model for a quality profile's nested item's quality from Readarr.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ReadarrQualityProfileItemQuality {
  /// Identifier of the cutoff profile
  @JsonKey(name: 'id')
  int? id;

  /// Name of the cutoff profile
  @JsonKey(name: 'name')
  String? name;

  /// Typical source medium of the cutoff profile
  @JsonKey(name: 'source')
  String? source;

  /// Resolution of the cutoff profile
  @JsonKey(name: 'resolution')
  int? resolution;

  ReadarrQualityProfileItemQuality({
    this.id,
    this.name,
    this.source,
    this.resolution,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [ReadarrQualityProfileItemQuality] object.
  factory ReadarrQualityProfileItemQuality.fromJson(Map<String, dynamic> json) =>
      _$ReadarrQualityProfileItemQualityFromJson(json);

  /// Serialize a [ReadarrQualityProfileItemQuality] object to a JSON map.
  Map<String, dynamic> toJson() =>
      _$ReadarrQualityProfileItemQualityToJson(this);
}
