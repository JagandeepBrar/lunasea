import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'tag.g.dart';

/// Model for a series tag from Radarr.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class RadarrTag {
  /// Tag identifier
  @JsonKey(name: 'id')
  int? id;

  /// Label of the tag
  @JsonKey(name: 'label')
  String? label;

  RadarrTag({
    this.id,
    this.label,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [RadarrTag] object.
  factory RadarrTag.fromJson(Map<String, dynamic> json) =>
      _$RadarrTagFromJson(json);

  /// Serialize a [RadarrTag] object to a JSON map.
  Map<String, dynamic> toJson() => _$RadarrTagToJson(this);
}
