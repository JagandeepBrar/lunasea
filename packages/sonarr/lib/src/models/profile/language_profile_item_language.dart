import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'language_profile_item_language.g.dart';

/// Model for a quality profile's nested item's quality from Sonarr.
@JsonSerializable(explicitToJson: true)
class SonarrLanguageProfileItemLanguage {
    /// Identifier of the cutoff profile
    @JsonKey(name: 'id')
    int? id;

    /// Name of the cutoff profile
    @JsonKey(name: 'name')
    String? name;

    SonarrLanguageProfileItemLanguage({
        this.id,
        this.name,
    });

    /// Returns a JSON-encoded string version of this object.
    @override
    String toString() => json.encode(this.toJson());

    /// Deserialize a JSON map to a [SonarrLanguageProfileItemLanguage] object.
    factory SonarrLanguageProfileItemLanguage.fromJson(Map<String, dynamic> json) => _$SonarrLanguageProfileItemLanguageFromJson(json);
    /// Serialize a [SonarrLanguageProfileItemLanguage] object to a JSON map.
    Map<String, dynamic> toJson() => _$SonarrLanguageProfileItemLanguageToJson(this);
}
