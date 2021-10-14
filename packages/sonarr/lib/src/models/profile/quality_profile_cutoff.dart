import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'quality_profile_cutoff.g.dart';

/// Model for a quality profile cutoffs from Sonarr.
@JsonSerializable(explicitToJson: true)
class SonarrQualityProfileCutoff {
    /// Identifier of the cutoff profile
    @JsonKey(name: 'id')
    int? id;

    /// Name of the cutoff profile
    @JsonKey(name: 'name')
    String? name;

    /// Typical source medium of the cutoff profile
    @JsonKey(name: 'source')
    String? source;

    /// Resolution of the cutoff profile
    @JsonKey(name: 'resolution')
    int? resolution;

    SonarrQualityProfileCutoff({
        this.id,
        this.name,
        this.source,
        this.resolution,
    });

    /// Returns a JSON-encoded string version of this object.
    @override
    String toString() => json.encode(this.toJson());

    /// Deserialize a JSON map to a [SonarrQualityProfileCutoff] object.
    factory SonarrQualityProfileCutoff.fromJson(Map<String, dynamic> json) => _$SonarrQualityProfileCutoffFromJson(json);
    /// Serialize a [SonarrQualityProfileCutoff] object to a JSON map.
    Map<String, dynamic> toJson() => _$SonarrQualityProfileCutoffToJson(this);
}
