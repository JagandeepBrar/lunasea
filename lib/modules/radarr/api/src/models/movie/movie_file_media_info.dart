import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'movie_file_media_info.g.dart';

/// Store details about the language of the movie.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class RadarrMovieFileMediaInfo {
    @JsonKey(name: 'audioAdditionalFeatures')
    String? audioAdditionalFeatures;

    @JsonKey(name: 'audioBitrate')
    int? audioBitrate;

    @JsonKey(name: 'audioChannels')
    double? audioChannels;

    @JsonKey(name: 'audioCodec')
    String? audioCodec;

    @JsonKey(name: 'audioLanguages')
    String? audioLanguages;

    @JsonKey(name: 'audioStreamCount')
    int? audioStreamCount;

    @JsonKey(name: 'videoBitDepth')
    int? videoBitDepth;

    @JsonKey(name: 'videoBitrate')
    int? videoBitrate;

    @JsonKey(name: 'videoCodec')
    String? videoCodec;

    @JsonKey(name: 'videoFps')
    double? videoFps;

    @JsonKey(name: 'resolution')
    String? resolution;

    @JsonKey(name: 'runTime')
    String? runTime;

    @JsonKey(name: 'scanType')
    String? scanType;

    @JsonKey(name: 'subtitles')
    String? subtitles;

    RadarrMovieFileMediaInfo({
        this.audioAdditionalFeatures,
        this.audioBitrate,
        this.audioChannels,
        this.audioCodec,
        this.audioLanguages,
        this.audioStreamCount,
        this.videoBitDepth,
        this.videoBitrate,
        this.videoCodec,
        this.videoFps,
        this.resolution,
        this.runTime,
        this.scanType,
        this.subtitles,
    });

    /// Returns a JSON-encoded string version of this object.
    @override
    String toString() => json.encode(this.toJson());

    /// Deserialize a JSON map to a [RadarrMovieFileMediaInfo] object.
    factory RadarrMovieFileMediaInfo.fromJson(Map<String, dynamic> json) => _$RadarrMovieFileMediaInfoFromJson(json);
    /// Serialize a [RadarrMovieFileMediaInfo] object to a JSON map.
    Map<String, dynamic> toJson() => _$RadarrMovieFileMediaInfoToJson(this);
}
