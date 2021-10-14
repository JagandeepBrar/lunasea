
import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:sonarr/models.dart';
import 'package:sonarr/utilities.dart';

part 'episode_file.g.dart';

/// Model for an episode file from Sonarr.
@JsonSerializable(explicitToJson: true)
class SonarrEpisodeFile {
    /// Series identifier
    @JsonKey(name: 'seriesId')
    int? seriesId;

    /// Season number of the episode
    @JsonKey(name: 'seasonNumber')
    int? seasonNumber;

    /// Relative path to the root folder of series
    @JsonKey(name: 'relativePath')
    String? relativePath;

    /// Full path to the episode
    @JsonKey(name: 'path')
    String? path;

    /// Size in bytes
    @JsonKey(name: 'size')
    int? size;

    /// [DateTime] object for when the episode was added
    @JsonKey(name: 'dateAdded', fromJson: SonarrUtilities.dateTimeFromJson, toJson: SonarrUtilities.dateTimeToJson)
    DateTime? dateAdded;

    /// Scene name of the downloaded episode
    @JsonKey(name: 'sceneName')
    String? sceneName;

    /// [SonarrEpisodeFileQuality] object containing the quality profile of the file
    @JsonKey(name: 'quality')
    SonarrEpisodeFileQuality? quality;

    /// [SonarrEpisodeFileLanguage] object containing the language profile of the file
    @JsonKey(name: 'language')
    SonarrEpisodeFileLanguage? language;

    /// [SonarrEpisodeFileMediaInfo] object containing the media info for the file
    @JsonKey(name: 'mediaInfo')
    SonarrEpisodeFileMediaInfo? mediaInfo;

    /// Original downloaded file name/path
    @JsonKey(name: 'originalFilePath')
    String? originalFilePath;

    /// Is the quality cutoff not met?
    @JsonKey(name: 'qualityCutoffNotMet')
    bool? qualityCutoffNotMet;

    /// Episode identifier
    @JsonKey(name: 'id')
    int? id;

    SonarrEpisodeFile({
        this.seriesId,
        this.seasonNumber,
        this.relativePath,
        this.path,
        this.size,
        this.dateAdded,
        this.sceneName,
        this.quality,
        this.language,
        this.mediaInfo,
        this.originalFilePath,
        this.qualityCutoffNotMet,
        this.id,
    });

    /// Returns a JSON-encoded string version of this object.
    @override
    String toString() => json.encode(this.toJson());

    /// Deserialize a JSON map to a [SonarrEpisodeFile] object.
    factory SonarrEpisodeFile.fromJson(Map<String, dynamic> json) => _$SonarrEpisodeFileFromJson(json);
    /// Serialize a [SonarrEpisodeFile] object to a JSON map.
    Map<String, dynamic> toJson() => _$SonarrEpisodeFileToJson(this);
}
