import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:lunasea/modules/sonarr.dart';

part 'release.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class SonarrRelease {
  @JsonKey(name: 'guid')
  String? guid;

  @JsonKey(name: 'quality')
  SonarrEpisodeFileQuality? quality;

  @JsonKey(name: 'qualityWeight')
  int? qualityWeight;

  @JsonKey(name: 'age')
  int? age;

  @JsonKey(name: 'ageHours')
  double? ageHours;

  @JsonKey(name: 'ageMinutes')
  double? ageMinutes;

  @JsonKey(name: 'size')
  int? size;

  @JsonKey(name: 'indexerId')
  int? indexerId;

  @JsonKey(name: 'indexer')
  String? indexer;

  @JsonKey(name: 'releaseGroup')
  String? releaseGroup;

  @JsonKey(name: 'releaseHash')
  String? releaseHash;

  @JsonKey(name: 'title')
  String? title;

  @JsonKey(name: 'fullSeason')
  bool? fullSeason;

  @JsonKey(name: 'sceneSource')
  bool? sceneSource;

  @JsonKey(name: 'seasonNumber')
  int? seasonNumber;

  @JsonKey(name: 'language')
  SonarrLanguageProfile? language;

  @JsonKey(name: 'languageWeight')
  int? languageWeight;

  @JsonKey(name: 'seriesTitle')
  String? seriesTitle;

  @JsonKey(name: 'episodeNumbers')
  List<int>? episodeNumbers;

  @JsonKey(name: 'absoluteEpisodeNumbers')
  List<int>? absoluteEpisodeNumbers;

  @JsonKey(name: 'mappedSeasonNumber')
  int? mappedSeasonNumber;

  @JsonKey(name: 'mappedEpisodeNumbers')
  List<int>? mappedEpisodeNumbers;

  @JsonKey(name: 'mappedAbsoluteEpisodeNumbers')
  List<int>? mappedAbsoluteEpisodeNumbers;

  @JsonKey(name: 'approved')
  bool? approved;

  @JsonKey(name: 'temporarilyRejected')
  bool? temporarilyRejected;

  @JsonKey(name: 'rejected')
  bool? rejected;

  @JsonKey(name: 'tvdbId')
  int? tvdbId;

  @JsonKey(name: 'tvRageId')
  int? tvRageId;

  @JsonKey(name: 'rejections')
  List<String>? rejections;

  @JsonKey(
    name: 'publishDate',
    fromJson: SonarrUtilities.dateTimeFromJson,
    toJson: SonarrUtilities.dateTimeToJson,
  )
  DateTime? publishDate;

  @JsonKey(name: 'commentUrl')
  String? commentUrl;

  @JsonKey(name: 'downloadUrl')
  String? downloadUrl;

  @JsonKey(name: 'infoUrl')
  String? infoUrl;

  @JsonKey(name: 'episodeRequested')
  bool? episodeRequested;

  @JsonKey(name: 'downloadAllowed')
  bool? downloadAllowed;

  @JsonKey(name: 'releaseWeight')
  int? releaseWeight;

  @JsonKey(name: 'preferredWordScore')
  int? preferredWordScore;

  @JsonKey(
    name: 'protocol',
    toJson: SonarrUtilities.protocolToJson,
    fromJson: SonarrUtilities.protocolFromJson,
  )
  SonarrProtocol? protocol;

  @JsonKey(name: 'isDaily')
  bool? isDaily;

  @JsonKey(name: 'isAbsoluteNumbering')
  bool? isAbsoluteNumbering;

  @JsonKey(name: 'isPossibleSpecialEpisode')
  bool? isPossibleSpecialEpisode;

  @JsonKey(name: 'special')
  bool? special;

  @JsonKey(name: 'seeders')
  int? seeders;

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
    this.sceneSource,
    this.seasonNumber,
    this.language,
    this.languageWeight,
    this.seriesTitle,
    this.episodeNumbers,
    this.absoluteEpisodeNumbers,
    this.mappedSeasonNumber,
    this.mappedEpisodeNumbers,
    this.mappedAbsoluteEpisodeNumbers,
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
    this.episodeRequested,
    this.downloadAllowed,
    this.releaseWeight,
    this.preferredWordScore,
    this.protocol,
    this.isDaily,
    this.isAbsoluteNumbering,
    this.isPossibleSpecialEpisode,
    this.special,
    this.leechers,
    this.seeders,
  });

  @override
  String toString() => json.encode(this.toJson());

  factory SonarrRelease.fromJson(Map<String, dynamic> json) =>
      _$SonarrReleaseFromJson(json);

  Map<String, dynamic> toJson() => _$SonarrReleaseToJson(this);
}
