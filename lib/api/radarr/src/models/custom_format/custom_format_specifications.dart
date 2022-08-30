import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'custom_format_specifications.g.dart';

/// Model for a custom format from Radarr.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class RadarrCustomFormatSpecifications {
  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'implementation')
  String? implementation;

  @JsonKey(name: 'implementationName')
  String? implementationName;

  @JsonKey(name: 'infoLink')
  String? infoLink;

  @JsonKey(name: 'negate')
  bool? negate;

  @JsonKey(name: 'required')
  bool? required;

  @JsonKey(name: 'fields')
  List<Map<dynamic, dynamic>>? fields;

  RadarrCustomFormatSpecifications({
    this.name,
    this.implementation,
    this.implementationName,
    this.infoLink,
    this.negate,
    this.required,
    this.fields,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [RadarrCustomFormatSpecifications] object.
  factory RadarrCustomFormatSpecifications.fromJson(
          Map<String, dynamic> json) =>
      _$RadarrCustomFormatSpecificationsFromJson(json);

  /// Serialize a [RadarrCustomFormatSpecifications] object to a JSON map.
  Map<String, dynamic> toJson() =>
      _$RadarrCustomFormatSpecificationsToJson(this);
}
