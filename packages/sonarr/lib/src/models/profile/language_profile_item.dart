import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'language_profile_item_language.dart';

part 'language_profile_item.g.dart';

/// Model for a language profile nested item from Sonarr.
@JsonSerializable(explicitToJson: true)
class SonarrLanguageProfileItem {
    /// Is this profile allowed/enabled?
    @JsonKey(name: 'allowed')
    bool? allowed;

    @JsonKey(name: 'language')
    SonarrLanguageProfileItemLanguage? language;

    SonarrLanguageProfileItem({
        this.allowed,
    });

    /// Returns a JSON-encoded string version of this object.
    @override
    String toString() => json.encode(this.toJson());

    /// Deserialize a JSON map to a [SonarrLanguageProfileItem] object.
    factory SonarrLanguageProfileItem.fromJson(Map<String, dynamic> json) => _$SonarrLanguageProfileItemFromJson(json);
    /// Serialize a [SonarrLanguageProfileItem] object to a JSON map.
    Map<String, dynamic> toJson() => _$SonarrLanguageProfileItemToJson(this);
}
