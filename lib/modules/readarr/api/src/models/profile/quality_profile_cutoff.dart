import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'quality_profile_cutoff.g.dart';

/// Model for a quality profile cutoffs from Readarr.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ReadarrQualityProfileCutoff {
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

  ReadarrQualityProfileCutoff({
    this.id,
    this.name,
    this.source,
    this.resolution,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [ReadarrQualityProfileCutoff] object.
  factory ReadarrQualityProfileCutoff.fromJson(Map<String, dynamic> json) =>
      _$ReadarrQualityProfileCutoffFromJson(json);

  /// Serialize a [ReadarrQualityProfileCutoff] object to a JSON map.
  Map<String, dynamic> toJson() => _$ReadarrQualityProfileCutoffToJson(this);
}
