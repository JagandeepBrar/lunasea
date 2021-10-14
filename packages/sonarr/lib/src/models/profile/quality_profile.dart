import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'quality_profile_cutoff.dart';
import 'quality_profile_item.dart';

part 'quality_profile.g.dart';

/// Model for a quality profile from Sonarr.
@JsonSerializable(explicitToJson: true)
class SonarrQualityProfile {
    /// Name of the profile
    @JsonKey(name: 'name')
    String? name;

    /// Are upgrades allowed?
    @JsonKey(name: 'upgradeAllowed')
    bool? upgradeAllowed;

    /// Cutoff profile information
    @JsonKey(name: 'cutoff')
    SonarrQualityProfileCutoff? cutoff;

    /// Nested profile items
    @JsonKey(name: 'items')
    List<SonarrQualityProfileItem>? items;

    /// Identifier of the quality profile
    @JsonKey(name: 'id')
    int? id;

    SonarrQualityProfile({
        this.name,
        this.upgradeAllowed,
        this.cutoff,
        this.items,
        this.id,
    });

    /// Returns a JSON-encoded string version of this object.
    @override
    String toString() => json.encode(this.toJson());

    /// Deserialize a JSON map to a [SonarrQualityProfile] object.
    factory SonarrQualityProfile.fromJson(Map<String, dynamic> json) => _$SonarrQualityProfileFromJson(json);
    /// Serialize a [SonarrQualityProfile] object to a JSON map.
    Map<String, dynamic> toJson() => _$SonarrQualityProfileToJson(this);
}
