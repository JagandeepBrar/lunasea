import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'episode_file_quality_revision.g.dart';

/// Model for an episode file's quality profile's revision from Sonarr.
@JsonSerializable(explicitToJson: true)
class SonarrEpisodeFileQualityRevision {
    /// Version of the file
    @JsonKey(name: 'version')
    int? version;

    /// Real (?)
    @JsonKey(name: 'real')
    int? real;

    /// Is the file source a repack?
    @JsonKey(name: 'isRepack')
    bool? isRepack;

    SonarrEpisodeFileQualityRevision({
        this.version,
        this.real,
        this.isRepack,
    });

    /// Returns a JSON-encoded string version of this object.
    @override
    String toString() => json.encode(this.toJson());

    /// Deserialize a JSON map to a [SonarrEpisodeFileQualityRevision] object.
    factory SonarrEpisodeFileQualityRevision.fromJson(Map<String, dynamic> json) => _$SonarrEpisodeFileQualityRevisionFromJson(json);
    /// Serialize a [SonarrEpisodeFileQualityRevision] object to a JSON map.
    Map<String, dynamic> toJson() => _$SonarrEpisodeFileQualityRevisionToJson(this);
}
