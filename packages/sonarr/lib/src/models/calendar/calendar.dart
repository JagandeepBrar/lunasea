
import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:sonarr/models.dart';
import 'package:sonarr/utilities.dart';

part 'calendar.g.dart';

/// Model for calendar entries from Sonarr.
@JsonSerializable(explicitToJson: true)
class SonarrCalendar {
    /// Series identifier
    @JsonKey(name: 'seriesId')
    int? seriesId;

    /// Episode file identifier
    @JsonKey(name: 'episodeFileId')
    int? episodeFileId;

    /// Season Number
    @JsonKey(name: 'seasonNumber')
    int? seasonNumber;

    /// Episode Number
    @JsonKey(name: 'episodeNumber')
    int? episodeNumber;

    /// Title
    @JsonKey(name: 'title')
    String? title;

    /// Air date
    @JsonKey(name: 'airDate')
    String? airDate;

    /// [DateTime] object containing the air date
    @JsonKey(name: 'airDateUtc', fromJson: SonarrUtilities.dateTimeFromJson, toJson: SonarrUtilities.dateTimeToJson)
    DateTime? airDateUtc;

    /// [SonarrEpisodeFile] object containing the episode file details (if available)
    @JsonKey(name: 'episodeFile')
    SonarrEpisodeFile? episodeFile;

    /// Overview of the episode
    @JsonKey(name: 'overview')
    String? overview;

    /// Does the episode have a file?
    @JsonKey(name: 'hasFile')
    bool? hasFile;

    /// Is the episode monitored?
    @JsonKey(name: 'monitored')
    bool? monitored;

    /// Absolute episode number
    @JsonKey(name: 'absoluteEpisodeNumber')
    int? absoluteEpisodeNumber;

    /// Scene absolute episode number
    @JsonKey(name: 'sceneAbsoluteEpisodeNumber')
    int? sceneAbsoluteEpisodeNumber;

    /// Scene episode number
    @JsonKey(name: 'sceneEpisodeNumber')
    int? sceneEpisodeNumber;

    /// Scene season number
    @JsonKey(name: 'sceneSeasonNumber')
    int? sceneSeasonNumber;

    /// Is the scene numbering unverified?
    @JsonKey(name: 'unverifiedSceneNumbering')
    bool? unverifiedSceneNumbering;

    /// [SonarrSeries] object containing details about the series
    @JsonKey(name: 'series')
    SonarrSeries? series;

    /// Episode identifier
    @JsonKey(name: 'id')
    int? id;

    SonarrCalendar({
        this.seriesId,
        this.episodeFileId,
        this.seasonNumber,
        this.episodeNumber,
        this.title,
        this.airDate,
        this.airDateUtc,
        this.episodeFile,
        this.overview,
        this.hasFile,
        this.monitored,
        this.absoluteEpisodeNumber,
        this.sceneAbsoluteEpisodeNumber,
        this.sceneEpisodeNumber,
        this.sceneSeasonNumber,
        this.unverifiedSceneNumbering,
        this.series,
        this.id,
    });

    /// Returns a JSON-encoded string version of this object.
    @override
    String toString() => json.encode(this.toJson());

    /// Deserialize a JSON map to a [SonarrCalendar] object.
    factory SonarrCalendar.fromJson(Map<String, dynamic> json) => _$SonarrCalendarFromJson(json);
    /// Serialize a [SonarrCalendar] object to a JSON map.
    Map<String, dynamic> toJson() => _$SonarrCalendarToJson(this);
}
