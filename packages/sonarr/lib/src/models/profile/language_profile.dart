import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'language_profile_cutoff.dart';
import 'language_profile_item.dart';

part 'language_profile.g.dart';

/// Model for a language profile from Sonarr.
@JsonSerializable(explicitToJson: true)
class SonarrLanguageProfile {
    /// Name of the profile
    @JsonKey(name: 'name')
    String? name;

    /// Are upgrades allowed?
    @JsonKey(name: 'upgradeAllowed')
    bool? upgradeAllowed;

    /// Cutoff profile information
    @JsonKey(name: 'cutoff')
    SonarrLanguageProfileCutoff? cutoff;

    /// Nested profile languages
    @JsonKey(name: 'languages')
    List<SonarrLanguageProfileItem>? languages;

    /// Identifier of the language profile
    @JsonKey(name: 'id')
    int? id;

    SonarrLanguageProfile({
        this.name,
        this.upgradeAllowed,
        this.cutoff,
        this.languages,
        this.id,
    });

    /// Returns a JSON-encoded string version of this object.
    @override
    String toString() => json.encode(this.toJson());

    /// Deserialize a JSON map to a [SonarrLanguageProfile] object.
    factory SonarrLanguageProfile.fromJson(Map<String, dynamic> json) => _$SonarrLanguageProfileFromJson(json);
    /// Serialize a [SonarrLanguageProfile] object to a JSON map.
    Map<String, dynamic> toJson() => _$SonarrLanguageProfileToJson(this);
}
