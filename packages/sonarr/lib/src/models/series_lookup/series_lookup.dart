import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:sonarr/models.dart';
import 'package:sonarr/types.dart';
import 'package:sonarr/utilities.dart';

part 'series_lookup.g.dart';

/// Model for series lookup (new series searches) from Sonarr.
@JsonSerializable(explicitToJson: true)
class SonarrSeriesLookup {
    /// Title of the series
    @JsonKey(name: 'title')
    String? title;

    /// Title used for sorting
    @JsonKey(name: 'sortTitle')
    String? sortTitle;

    /// Number of seasons
    @JsonKey(name: 'seasonCount')
    int? seasonCount;

    /// Status of the series
    @JsonKey(name: 'status')
    String? status;

    /// Overview of the series
    @JsonKey(name: 'overview')
    String? overview;

    /// Network that the series aired/airs on
    @JsonKey(name: 'network')
    String? network;

    /// Time that the series aired/airs
    @JsonKey(name: 'airTime')
    String? airTime;

    /// List of images available for this series
    @JsonKey(name: 'images')
    List<SonarrSeriesImage>? images;

    /// URL to a remote poster
    @JsonKey(name: 'remotePoster')
    String? remotePoster;

    /// List of seasons for the series
    @JsonKey(name: 'seasons')
    List<SonarrSeriesSeason>? seasons;

    /// Year the season was released
    @JsonKey(name: 'year')
    int? year;

    /// If the series is already added, the path to the series
    @JsonKey(name: 'path')
    String? path;

    /// If the series is already added, the quality profile identifier
    @JsonKey(name: 'profileId')
    int? profileId;

    /// If the series is already added, the language profile identifier
    @JsonKey(name: 'languageProfileId')
    int? languageProfileId;

    /// Are season folders being used?
    @JsonKey(name: 'seasonFolder')
    bool? seasonFolder;

    /// Is the series monitored?
    @JsonKey(name: 'monitored')
    bool? monitored;

    /// Is the series using scene numbering?
    @JsonKey(name: 'useSceneNumbering')
    bool? useSceneNumbering;

    /// Runtime of an average episode in the series, in minutes
    @JsonKey(name: 'runtime')
    int? runtime;

    /// TVDB ID for the series
    @JsonKey(name: 'tvdbId')
    int? tvdbId;

    /// TVRage ID for the series
    @JsonKey(name: 'tvRageId')
    int? tvRageId;

    /// TVMaze ID for the series
    @JsonKey(name: 'tvMazeId')
    int? tvMazeId;

    /// Date that the series premiered
    @JsonKey(name: 'firstAired', toJson: SonarrUtilities.dateTimeToJson, fromJson: SonarrUtilities.dateTimeFromJson)
    DateTime? firstAired;

    /// If the series is already added, date that the series was last refreshed in Sonarr
    @JsonKey(name: 'lastInfoSync', toJson: SonarrUtilities.dateTimeToJson, fromJson: SonarrUtilities.dateTimeFromJson)
    DateTime? lastInfoSync;

    /// [SonarrSeriesType] to store the type of the series
    @JsonKey(name: 'seriesType', fromJson: SonarrUtilities.seriesTypeFromJson, toJson: SonarrUtilities.seriesTypeToJson)
    SonarrSeriesType? seriesType;

    /// Title with any special characters removed
    @JsonKey(name: 'cleanTitle')
    String? cleanTitle;

    /// IMDB ID of the series
    @JsonKey(name: 'imdbId')
    String? imdbId;

    /// Title slug, used for routing to the series via URL
    @JsonKey(name: 'titleSlug')
    String? titleSlug;

    /// Content rating of the series
    @JsonKey(name: 'certification')
    String? certification;

    /// List of genres for the series
    @JsonKey(name: 'genres')
    List<String>? genres;

    /// List of tag IDs associated with the series
    @JsonKey(name: 'tags')
    List<int>? tags;

    /// If the series is already added, date that the series was added to Sonarr
    @JsonKey(name: 'added', toJson: SonarrUtilities.dateTimeToJson, fromJson: SonarrUtilities.dateTimeFromJson)
    DateTime? added;

    /// [SonarrSeriesRating] object to store rating information
    @JsonKey(name: 'ratings')
    SonarrSeriesRating? ratings;

    /// Quality profile ID for the series
    @JsonKey(name: 'qualityProfileId')
    int? qualityProfileId;

    /// If the series is already added, the unique ID for the series in Sonarr
    @JsonKey(name: 'id')
    int? id;

    /// Store the root folder path
    String? rootFolderPath;

    SonarrSeriesLookup({
        this.title,
        this.sortTitle,
        this.seasonCount,
        this.status,
        this.overview,
        this.network,
        this.airTime,
        this.images,
        this.remotePoster,
        this.seasons,
        this.year,
        this.path,
        this.profileId,
        this.languageProfileId,
        this.seasonFolder,
        this.monitored,
        this.useSceneNumbering,
        this.runtime,
        this.tvdbId,
        this.tvRageId,
        this.tvMazeId,
        this.firstAired,
        this.lastInfoSync,
        this.seriesType,
        this.cleanTitle,
        this.imdbId,
        this.titleSlug,
        this.certification,
        this.genres,
        this.tags,
        this.added,
        this.ratings,
        this.qualityProfileId,
        this.id,
    });

    /// Returns a JSON-encoded string version of this object.
    @override
    String toString() => json.encode(this.toJson());

    /// Deserialize a JSON map to a [SonarrSeriesLookup] object.
    factory SonarrSeriesLookup.fromJson(Map<String, dynamic> json) => _$SonarrSeriesLookupFromJson(json);
    /// Serialize a [SonarrSeriesLookup] object to a JSON map.
    Map<String, dynamic> toJson() => _$SonarrSeriesLookupToJson(this);
}
