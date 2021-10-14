import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'language_profile_cutoff.g.dart';

/// Model for a language profile cutoffs from Sonarr.
@JsonSerializable(explicitToJson: true)
class SonarrLanguageProfileCutoff {
    /// Identifier of the cutoff profile
    @JsonKey(name: 'id')
    int? id;

    /// Name of the cutoff profile
    @JsonKey(name: 'name')
    String? name;

    SonarrLanguageProfileCutoff({
        this.id,
        this.name,
    });

    /// Returns a JSON-encoded string version of this object.
    @override
    String toString() => json.encode(this.toJson());

    /// Deserialize a JSON map to a [SonarrLanguageProfileCutoff] object.
    factory SonarrLanguageProfileCutoff.fromJson(Map<String, dynamic> json) => _$SonarrLanguageProfileCutoffFromJson(json);
    /// Serialize a [SonarrLanguageProfileCutoff] object to a JSON map.
    Map<String, dynamic> toJson() => _$SonarrLanguageProfileCutoffToJson(this);
}
