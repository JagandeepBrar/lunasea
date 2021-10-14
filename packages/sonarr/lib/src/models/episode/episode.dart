import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:sonarr/models.dart';
import 'package:sonarr/utilities.dart';

part 'episode.g.dart';

/// Model for an episode from Sonarr.
@JsonSerializable(explicitToJson: true)
class SonarrEpisode {
    /// Series identifier
    @JsonKey(name: 'seriesId')
    int? seriesId;

    /// Episode file identifier (if there is a file available)
    @JsonKey(name: 'episodeFileId')
    int? episodeFileId;

    /// Episode season number
    @JsonKey(name: 'seasonNumber')
    int? seasonNumber;

    /// Episode number
    @JsonKey(name: 'episodeNumber')
    int? episodeNumber;

    /// Episode title
    @JsonKey(name: 'title')
    String? title;

    /// Episode airdate (as a string)
    @JsonKey(name: 'airDate')
    String? airDate;

    /// [DateTime] object containing the airdate in UTC timezone
    @JsonKey(name: 'airDateUtc', toJson: SonarrUtilities.dateTimeToJson, fromJson: SonarrUtilities.dateTimeFromJson)
    DateTime? airDateUtc;

    /// Episode overview
    @JsonKey(name: 'overview')
    String? overview;

    /// If there is a file available, a [SonarrEpisodeFile] object containing episode file details
    @JsonKey(name: 'episodeFile')
    SonarrEpisodeFile? episodeFile;

    /// Is there a file available?
    @JsonKey(name: 'hasFile')
    bool? hasFile;

    /// Is the episode monitored?
    @JsonKey(name: 'monitored')
    bool? monitored;

    /// Absolute episode number
    @JsonKey(name: 'absoluteEpisodeNumber')
    int? absoluteEpisodeNumber;

    /// Is the scene number verified?
    @JsonKey(name: 'unverifiedSceneNumbering')
    bool? unverifiedSceneNumbering;

    /// [DateTime] object for when the episode was last searched
    @JsonKey(name: 'lastSearchTime', toJson: SonarrUtilities.dateTimeToJson, fromJson: SonarrUtilities.dateTimeFromJson)
    DateTime? lastSearchTime;

    /// Episode identifier
    @JsonKey(name: 'id')
    int? id;

    SonarrEpisode({
        this.seriesId,
        this.episodeFileId,
        this.seasonNumber,
        this.episodeNumber,
        this.title,
        this.airDate,
        this.airDateUtc,
        this.overview,
        this.episodeFile,
        this.hasFile,
        this.monitored,
        this.absoluteEpisodeNumber,
        this.unverifiedSceneNumbering,
        this.lastSearchTime,
        this.id,
    });

    /// Returns a JSON-encoded string version of this object.
    @override
    String toString() => json.encode(this.toJson());

    /// Deserialize a JSON map to a [SonarrEpisode] object.
    factory SonarrEpisode.fromJson(Map<String, dynamic> json) => _$SonarrEpisodeFromJson(json);
    /// Serialize a [SonarrEpisode] object to a JSON map.
    Map<String, dynamic> toJson() => _$SonarrEpisodeToJson(this);
}
