import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:lunasea/api/radarr/models.dart';

part 'quality_definition.g.dart';

/// Store details about a quality definition.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class RadarrQualityDefinition {
  @JsonKey(name: 'quality')
  RadarrQuality? quality;

  @JsonKey(name: 'title')
  String? title;

  @JsonKey(name: 'weight')
  int? weight;

  @JsonKey(name: 'minSize')
  double? minSize;

  @JsonKey(name: 'maxSize')
  double? maxSize;

  @JsonKey(name: 'preferredSize')
  double? preferredSize;

  @JsonKey(name: 'id')
  int? id;

  RadarrQualityDefinition({
    this.quality,
    this.title,
    this.weight,
    this.minSize,
    this.maxSize,
    this.preferredSize,
    this.id,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [RadarrQualityDefinition] object.
  factory RadarrQualityDefinition.fromJson(Map<String, dynamic> json) =>
      _$RadarrQualityDefinitionFromJson(json);

  /// Serialize a [RadarrQualityDefinition] object to a JSON map.
  Map<String, dynamic> toJson() => _$RadarrQualityDefinitionToJson(this);
}
