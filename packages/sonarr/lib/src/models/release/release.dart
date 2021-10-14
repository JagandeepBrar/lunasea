import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:sonarr/models.dart';
import 'package:sonarr/utilities.dart';

part 'release.g.dart';

/// Model for an episode release from Sonarr.
@JsonSerializable(explicitToJson: true)
class SonarrRelease {
    /// GUID of the release
    @JsonKey(name: 'guid')
    String? guid;

    /// [SonarrEpisodeFileQuality] object containing the quality profile details
    @JsonKey(name: 'quality')
    SonarrEpisodeFileQuality? quality;

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

    /// Indexer name
    @JsonKey(name: 'indexer')
    String? indexer;

    /// Group that released the file
    @JsonKey(name: 'releaseGroup')
    String? releaseGroup;

    /// Hash of the release
    @JsonKey(name: 'releaseHash')
    String? releaseHash;

    /// Release title
    @JsonKey(name: 'title')
    String? title;

    /// Is this the full season?
    @JsonKey(name: 'fullSeason')
    bool? fullSeason;

    /// Season of the release
    @JsonKey(name: 'seasonNumber')
    int? seasonNumber;

    /// Series title
    @JsonKey(name: 'seriesTitle')
    String? seriesTitle;

    /// Episode numbers contained in this release
    @JsonKey(name: 'episodeNumbers')
    List<int>? episodeNumbers;

    /// Absolute episode numbers contained in this release
    @JsonKey(name: 'absoluteEpisodeNumbers')
    List<int>? absoluteEpisodeNumbers;

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

    /// List of reasons why the release got rejected
    @JsonKey(name: 'rejections')
    List<String>? rejections;

    /// [DateTime] object for when the release was published
    @JsonKey(name: 'publishDate', fromJson: SonarrUtilities.dateTimeFromJson, toJson: SonarrUtilities.dateTimeToJson)
    DateTime? publishDate;

    /// Link to the comments on the indexer
    @JsonKey(name: 'commentUrl')
    String? commentUrl;

    /// Link to the release on the indexer
    @JsonKey(name: 'downloadUrl')
    String? downloadUrl;

    /// Link to the information on the indexer
    @JsonKey(name: 'infoUrl')
    String? infoUrl;

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

    /// If the protocol is torrent, the number of seeders
    @JsonKey(name: 'seeders')
    int? seeders;

    /// If the protocol is torrent, the number of leechers
    @JsonKey(name: 'leechers')
    int? leechers;

    SonarrRelease({
        this.guid,
        this.quality,
        this.qualityWeight,
        this.age,
        this.ageHours,
        this.ageMinutes,
        this.size,
        this.indexerId,
        this.indexer,
        this.releaseGroup,
        this.releaseHash,
        this.title,
        this.fullSeason,
        this.seasonNumber,
        this.seriesTitle,
        this.episodeNumbers,
        this.absoluteEpisodeNumbers,
        this.approved,
        this.temporarilyRejected,
        this.rejected,
        this.tvdbId,
        this.tvRageId,
        this.rejections,
        this.publishDate,
        this.commentUrl,
        this.downloadUrl,
        this.infoUrl,
        this.downloadAllowed,
        this.releaseWeight,
        this.protocol,
        this.isDaily,
        this.isAbsoluteNumbering,
        this.isPossibleSpecialEpisode,
        this.special,
        this.leechers,
        this.seeders,
    });

    /// Returns a JSON-encoded string version of this object.
    @override
    String toString() => json.encode(this.toJson());

    /// Deserialize a JSON map to a [SonarrRelease] object.
    factory SonarrRelease.fromJson(Map<String, dynamic> json) => _$SonarrReleaseFromJson(json);
    /// Serialize a [SonarrRelease] object to a JSON map.
    Map<String, dynamic> toJson() => _$SonarrReleaseToJson(this);
}
