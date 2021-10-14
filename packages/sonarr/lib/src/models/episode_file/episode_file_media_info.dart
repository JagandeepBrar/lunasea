import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'episode_file_media_info.g.dart';

/// Model for an episode file's media info from Sonarr.
@JsonSerializable(explicitToJson: true)
class SonarrEpisodeFileMediaInfo {
    /// Audio channels in the file
    @JsonKey(name: 'audioChannels')
    double? audioChannels;

    /// Audio codec of the file
    @JsonKey(name: 'audioCodec')
    String? audioCodec;

    /// Video codec of the file
    @JsonKey(name: 'videoCodec')
    String? videoCodec;

    SonarrEpisodeFileMediaInfo({
        this.audioChannels,
        this.audioCodec,
        this.videoCodec,
    });

    /// Returns a JSON-encoded string version of this object.
    @override
    String toString() => json.encode(this.toJson());

    /// Deserialize a JSON map to a [SonarrEpisodeFileMediaInfo] object.
    factory SonarrEpisodeFileMediaInfo.fromJson(Map<String, dynamic> json) => _$SonarrEpisodeFileMediaInfoFromJson(json);
    /// Serialize a [SonarrEpisodeFileMediaInfo] object to a JSON map.
    Map<String, dynamic> toJson() => _$SonarrEpisodeFileMediaInfoToJson(this);
}
