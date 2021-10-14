import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'episode_file_quality_quality.g.dart';

/// Model for an episode file's quality profile's quality from Sonarr.
@JsonSerializable(explicitToJson: true)
class SonarrEpisodeFileQualityQuality {
    /// Identifier of the quality profile
    @JsonKey(name: 'id')
    int? id;

    /// Name of the quality profile
    @JsonKey(name: 'name')
    String? name;

    /// Source
    @JsonKey(name: 'source')
    String? source;

    /// Source resolution
    @JsonKey(name: 'resolution')
    int? resolution;

    SonarrEpisodeFileQualityQuality({
        this.id,
        this.name,
        this.source,
        this.resolution,
    });

    /// Returns a JSON-encoded string version of this object.
    @override
    String toString() => json.encode(this.toJson());

    /// Deserialize a JSON map to a [SonarrEpisodeFileQualityQuality] object.
    factory SonarrEpisodeFileQualityQuality.fromJson(Map<String, dynamic> json) => _$SonarrEpisodeFileQualityQualityFromJson(json);
    /// Serialize a [SonarrEpisodeFileQualityQuality] object to a JSON map.
    Map<String, dynamic> toJson() => _$SonarrEpisodeFileQualityQualityToJson(this);
}
