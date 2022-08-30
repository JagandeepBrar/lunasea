import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'format_item.g.dart';

/// Store details about a quality profile's format item.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class RadarrQualityProfileFormatItem {
  @JsonKey(name: 'format')
  int? format;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'score')
  int? score;

  RadarrQualityProfileFormatItem({
    this.format,
    this.name,
    this.score,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [RadarrQualityProfileFormatItem] object.
  factory RadarrQualityProfileFormatItem.fromJson(Map<String, dynamic> json) =>
      _$RadarrQualityProfileFormatItemFromJson(json);

  /// Serialize a [RadarrQualityProfileFormatItem] object to a JSON map.
  Map<String, dynamic> toJson() => _$RadarrQualityProfileFormatItemToJson(this);
}
