import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'quality_profile_item_quality.dart';

part 'quality_profile_item.g.dart';

/// Model for a quality profile nested item from Sonarr.
@JsonSerializable(explicitToJson: true)
class SonarrQualityProfileItem {
    /// Is this profile allowed/enabled?
    @JsonKey(name: 'allowed')
    bool? allowed;

    @JsonKey(name: 'quality')
    SonarrQualityProfileItemQuality? quality;

    SonarrQualityProfileItem({
        this.allowed,
        this.quality,
    });

    /// Returns a JSON-encoded string version of this object.
    @override
    String toString() => json.encode(this.toJson());

    /// Deserialize a JSON map to a [SonarrQualityProfileItem] object.
    factory SonarrQualityProfileItem.fromJson(Map<String, dynamic> json) => _$SonarrQualityProfileItemFromJson(json);
    /// Serialize a [SonarrQualityProfileItem] object to a JSON map.
    Map<String, dynamic> toJson() => _$SonarrQualityProfileItemToJson(this);
}
