import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:lunasea/api/radarr/models.dart';

part 'item.g.dart';

/// Store details about a quality profile item.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class RadarrQualityProfileItem {
  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'quality')
  RadarrQuality? quality;

  @JsonKey(name: 'items')
  List<RadarrQualityProfileItem>? items;

  @JsonKey(name: 'allowed')
  bool? allowed;

  @JsonKey(name: 'id')
  int? id;

  RadarrQualityProfileItem({
    this.name,
    this.quality,
    this.items,
    this.allowed,
    this.id,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [RadarrQualityProfileItem] object.
  factory RadarrQualityProfileItem.fromJson(Map<String, dynamic> json) =>
      _$RadarrQualityProfileItemFromJson(json);

  /// Serialize a [RadarrQualityProfileItem] object to a JSON map.
  Map<String, dynamic> toJson() => _$RadarrQualityProfileItemToJson(this);
}
