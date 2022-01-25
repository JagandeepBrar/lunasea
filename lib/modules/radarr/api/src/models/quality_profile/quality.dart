import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'quality.g.dart';

/// Store details about a quality profile item.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class RadarrQuality {
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'source')
  String? source;

  @JsonKey(name: 'resolution')
  int? resolution;

  @JsonKey(name: 'modifier')
  String? modifier;

  RadarrQuality({
    this.id,
    this.name,
    this.source,
    this.resolution,
    this.modifier,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [RadarrQuality] object.
  factory RadarrQuality.fromJson(Map<String, dynamic> json) =>
      _$RadarrQualityFromJson(json);

  /// Serialize a [RadarrQuality] object to a JSON map.
  Map<String, dynamic> toJson() => _$RadarrQualityToJson(this);
}
