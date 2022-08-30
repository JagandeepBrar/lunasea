import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:lunasea/api/radarr/models/custom_format/custom_format_specifications.dart';

part 'custom_format.g.dart';

/// Model for a custom format from Radarr.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class RadarrCustomFormat {
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'includeCustomFormatWhenRenaming')
  bool? includeCustomFormatWhenRenaming;

  @JsonKey(name: 'specifications')
  List<RadarrCustomFormatSpecifications>? specifications;

  RadarrCustomFormat({
    this.id,
    this.name,
    this.includeCustomFormatWhenRenaming,
    this.specifications,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [RadarrCustomFormat] object.
  factory RadarrCustomFormat.fromJson(Map<String, dynamic> json) =>
      _$RadarrCustomFormatFromJson(json);

  /// Serialize a [RadarrCustomFormat] object to a JSON map.
  Map<String, dynamic> toJson() => _$RadarrCustomFormatToJson(this);
}
