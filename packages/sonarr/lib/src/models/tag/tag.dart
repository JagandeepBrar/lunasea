import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'tag.g.dart';

/// Model for a series tag from Sonarr.
@JsonSerializable(explicitToJson: true)
class SonarrTag {
    /// Tag identifier
    @JsonKey(name: 'id')
    int? id;

    /// Label of the tag
    @JsonKey(name: 'label')
    String? label;

    SonarrTag({
        this.id,
        this.label,
    });

    /// Returns a JSON-encoded string version of this object.
    @override
    String toString() => json.encode(this.toJson());

    /// Deserialize a JSON map to a [SonarrTag] object.
    factory SonarrTag.fromJson(Map<String, dynamic> json) => _$SonarrTagFromJson(json);
    /// Serialize a [SonarrTag] object to a JSON map.
    Map<String, dynamic> toJson() => _$SonarrTagToJson(this);
}
