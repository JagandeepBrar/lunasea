import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'language.g.dart';

/// Store details about a language.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class RadarrLanguage {
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'nameLower')
  String? nameLower;

  RadarrLanguage({
    this.id,
    this.name,
    this.nameLower,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [RadarrLanguage] object.
  factory RadarrLanguage.fromJson(Map<String, dynamic> json) =>
      _$RadarrLanguageFromJson(json);

  /// Serialize a [RadarrLanguage] object to a JSON map.
  Map<String, dynamic> toJson() => _$RadarrLanguageToJson(this);
}
