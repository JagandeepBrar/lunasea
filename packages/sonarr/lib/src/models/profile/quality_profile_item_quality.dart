import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'quality_profile_item_quality.g.dart';

/// Model for a quality profile's nested item's quality from Sonarr.
@JsonSerializable(explicitToJson: true)
class SonarrQualityProfileItemQuality {
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

    SonarrQualityProfileItemQuality({
        this.id,
        this.name,
        this.source,
        this.resolution,
    });

    /// Returns a JSON-encoded string version of this object.
    @override
    String toString() => json.encode(this.toJson());

    /// Deserialize a JSON map to a [SonarrQualityProfileItemQuality] object.
    factory SonarrQualityProfileItemQuality.fromJson(Map<String, dynamic> json) => _$SonarrQualityProfileItemQualityFromJson(json);
    /// Serialize a [SonarrQualityProfileItemQuality] object to a JSON map.
    Map<String, dynamic> toJson() => _$SonarrQualityProfileItemQualityToJson(this);
}
