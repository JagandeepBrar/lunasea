import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:sonarr/utilities.dart';

part 'added_release.g.dart';

/// Model for an episode release that was added to Sonarr.
@JsonSerializable(explicitToJson: true)
class SonarrAddedRelease {
    /// GUID of the release
    @JsonKey(name: 'guid')
    String? guid;

    /// Quality weight
    @JsonKey(name: 'qualityWeight')
    int? qualityWeight;

    /// Release age (in days)
    @JsonKey(name: 'age')
    int? age;

    /// Release age (in hours)
    @JsonKey(name: 'ageHours')
    double? ageHours;

    /// Release age (in minutes)
    @JsonKey(name: 'ageMinutes')
    double? ageMinutes;

    /// File size
    @JsonKey(name: 'size')
    int? size;

    /// Indexer identifier
    @JsonKey(name: 'indexerId')
    int? indexerId;

    /// Is this the full season?
    @JsonKey(name: 'fullSeason')
    bool? fullSeason;

    /// Season of the release
    @JsonKey(name: 'seasonNumber')
    int? seasonNumber;

    /// Is this release approved?
    @JsonKey(name: 'approved')
    bool? approved;

    /// Is this release temporarily rejected?
    @JsonKey(name: 'temporarilyRejected')
    bool? temporarilyRejected;

    /// Is this release rejected?
    @JsonKey(name: 'rejected')
    bool? rejected;

    /// TVDB identifier
    @JsonKey(name: 'tvdbId')
    int? tvdbId;

    /// TVRage identifier
    @JsonKey(name: 'tvRageId')
    int? tvRageId;

    /// [DateTime] object for when the release was published
    @JsonKey(name: 'publishDate', fromJson: SonarrUtilities.dateTimeFromJson, toJson: SonarrUtilities.dateTimeToJson)
    DateTime? publishDate;

    /// Is the download allowed?
    @JsonKey(name: 'downloadAllowed')
    bool? downloadAllowed;

    /// Weight of the release
    @JsonKey(name: 'releaseWeight')
    int? releaseWeight;

    /// The protocol used to download the release
    @JsonKey(name: 'protocol')
    String? protocol;

    /// Is the release formatted as a daily episode?
    @JsonKey(name: 'isDaily')
    bool? isDaily;

    /// Is this release absolute numbered?
    @JsonKey(name: 'isAbsoluteNumbering')
    bool? isAbsoluteNumbering;

    /// Is this *possibly* a special episode?
    @JsonKey(name: 'isPossibleSpecialEpisode')
    bool? isPossibleSpecialEpisode;

    /// Is this a specials episode?
    @JsonKey(name: 'special')
    bool? special;

    SonarrAddedRelease({
        this.guid,
        this.qualityWeight,
        this.age,
        this.ageHours,
        this.ageMinutes,
        this.size,
        this.indexerId,
        this.fullSeason,
        this.seasonNumber,
        this.approved,
        this.temporarilyRejected,
        this.rejected,
        this.tvdbId,
        this.tvRageId,
        this.publishDate,
        this.downloadAllowed,
        this.releaseWeight,
        this.protocol,
        this.isDaily,
        this.isAbsoluteNumbering,
        this.isPossibleSpecialEpisode,
        this.special,
    });

    /// Returns a JSON-encoded string version of this object.
    @override
    String toString() => json.encode(this.toJson());

    /// Deserialize a JSON map to a [SonarrAddedRelease] object.
    factory SonarrAddedRelease.fromJson(Map<String, dynamic> json) => _$SonarrAddedReleaseFromJson(json);
    /// Serialize a [SonarrAddedRelease] object to a JSON map.
    Map<String, dynamic> toJson() => _$SonarrAddedReleaseToJson(this);
}
