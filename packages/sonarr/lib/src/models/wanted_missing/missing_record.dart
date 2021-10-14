import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:sonarr/models.dart';
import 'package:sonarr/utilities.dart';

part 'missing_record.g.dart';

/// Model for an individual missing episode record from Sonarr.
@JsonSerializable(explicitToJson: true)
class SonarrMissingRecord {
    /// Series identifier
    @JsonKey(name: 'seriesId')
    int? seriesId;

    /// If available, the episode file identifier
    @JsonKey(name: 'episodeFileId')
    int? episodeFileId;

    /// Season number of the missing episode
    @JsonKey(name: 'seasonNumber')
    int? seasonNumber;

    /// Episode number of the missing episode
    @JsonKey(name: 'episodeNumber')
    int? episodeNumber;

    /// Episode title
    @JsonKey(name: 'title')
    String? title;

    /// Episode airdate
    @JsonKey(name: 'airDate')
    String? airDate;

    /// Episode airdate as a [DateTime] object
    @JsonKey(name: 'airDateUtc', toJson: SonarrUtilities.dateTimeToJson, fromJson: SonarrUtilities.dateTimeFromJson)
    DateTime? airDateUtc;

    /// Episode overview
    @JsonKey(name: 'overview')
    String? overview;

    /// Is there a file available?
    @JsonKey(name: 'hasFile')
    bool? hasFile;

    /// Is the episode monitored?
    @JsonKey(name: 'monitored')
    bool? monitored;

    /// Does the episode have an unverified scene number?
    @JsonKey(name: 'unverifiedSceneNumbering')
    bool? unverifiedSceneNumbering;

    /// [SonarrSeries] object, for the series of the episode.
    /// 
    /// *Please note that many of the fields will return null when accessing series information from this object.*
    @JsonKey(name: 'series')
    SonarrSeries? series;

    /// Episode identifier
    @JsonKey(name: 'id')
    int? id;

    SonarrMissingRecord({
        this.seriesId,
        this.episodeFileId,
        this.seasonNumber,
        this.episodeNumber,
        this.title,
        this.airDate,
        this.airDateUtc,
        this.overview,
        this.hasFile,
        this.monitored,
        this.unverifiedSceneNumbering,
        this.series,
        this.id,
    });

    /// Returns a JSON-encoded string version of this object.
    @override
    String toString() => json.encode(this.toJson());

    /// Deserialize a JSON map to a [SonarrMissingRecord] object.
    factory SonarrMissingRecord.fromJson(Map<String, dynamic> json) => _$SonarrMissingRecordFromJson(json);
    /// Serialize a [SonarrMissingRecord] object to a JSON map.
    Map<String, dynamic> toJson() => _$SonarrMissingRecordToJson(this);
}
