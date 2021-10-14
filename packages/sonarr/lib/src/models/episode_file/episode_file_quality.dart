import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:sonarr/models.dart';

part 'episode_file_quality.g.dart';

/// Model for an episode file's quality profile from Sonarr.
@JsonSerializable(explicitToJson: true)
class SonarrEpisodeFileQuality {
    /// [SonarrEpisodeFileQualityQuality] object containing the quality profile
    @JsonKey(name: 'quality')
    SonarrEpisodeFileQualityQuality? quality;

    /// [SonarrEpisodeFileQualityRevision] object containing the revision information
    @JsonKey(name: 'revision')
    SonarrEpisodeFileQualityRevision? revision;

    SonarrEpisodeFileQuality({
        this.quality,
        this.revision,
    });

    /// Returns a JSON-encoded string version of this object.
    @override
    String toString() => json.encode(this.toJson());

    /// Deserialize a JSON map to a [SonarrEpisodeFileQuality] object.
    factory SonarrEpisodeFileQuality.fromJson(Map<String, dynamic> json) => _$SonarrEpisodeFileQualityFromJson(json);
    /// Serialize a [SonarrEpisodeFileQuality] object to a JSON map.
    Map<String, dynamic> toJson() => _$SonarrEpisodeFileQualityToJson(this);
}
