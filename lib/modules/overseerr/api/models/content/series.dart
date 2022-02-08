import 'package:lunasea/core.dart';
import 'package:lunasea/modules/overseerr.dart';

part 'series.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class OverseerrSeries {
  @JsonKey()
  int? id;

  @JsonKey()
  List<OverseerrCreatedBy>? createdBy;

  @JsonKey()
  String? homepage;

  @JsonKey()
  String? name;

  @JsonKey()
  List<int>? episodeRunTime;

  @JsonKey()
  String? firstAirDate;

  @JsonKey()
  String? lastAirDate;

  @JsonKey()
  List<OverseerrGenre>? genres;

  @JsonKey()
  String? backdropPath;

  @JsonKey()
  String? posterPath;

  @JsonKey()
  bool? inProduction;

  @JsonKey()
  List<String>? languages;

  @JsonKey()
  int? numberOfEpisodes;

  @JsonKey()
  int? numberOfSeasons;

  @JsonKey()
  List<String>? originCountry;

  @JsonKey()
  String? originalLanguage;

  @JsonKey()
  String? originalName;

  @JsonKey()
  String? overview;

  @JsonKey()
  double? popularity;

  @JsonKey()
  List<OverseerrProductionCompany>? productionCompanies;

  @JsonKey()
  List<OverseerrProductionCountry>? productionCountries;

  @JsonKey()
  List<OverseerrSpokenLanguage>? spokenLanguages;

  @JsonKey()
  List<OverseerrRelatedVideo>? relatedVideos;

  @JsonKey()
  List<OverseerrNetwork>? networks;

  @JsonKey()
  String? status;

  @JsonKey()
  String? type;

  @JsonKey()
  double? voteAverage;

  @JsonKey()
  int? voteCount;

  @JsonKey()
  String? tagline;

  @JsonKey()
  OverseerrCredits? credits;

  @JsonKey()
  List<OverseerrWatchProvider>? watchProviders;

  @JsonKey()
  List<OverseerrKeyword>? keywords;

  @JsonKey()
  OverseerrExternalIds? externalIds;

  @JsonKey()
  OverseerrContentRatings? contentRatings;

  @JsonKey()
  List<OverseerrMediaSeason>? seasons;

  @JsonKey()
  OverseerrMedia? mediaInfo;

  @JsonKey()
  OverseerrEpisode? lastEpisodeToAir;

  @JsonKey()
  OverseerrEpisode? nextEpisodeToAir;

  OverseerrSeries({
    this.id,
    this.createdBy,
    this.homepage,
    this.name,
    this.episodeRunTime,
    this.firstAirDate,
    this.lastAirDate,
    this.genres,
    this.backdropPath,
    this.posterPath,
    this.inProduction,
    this.languages,
    this.numberOfEpisodes,
    this.numberOfSeasons,
    this.originCountry,
    this.originalLanguage,
    this.originalName,
    this.overview,
    this.popularity,
    this.productionCompanies,
    this.productionCountries,
    this.relatedVideos,
    this.spokenLanguages,
    this.networks,
    this.status,
    this.type,
    this.voteAverage,
    this.voteCount,
    this.tagline,
    this.credits,
    this.watchProviders,
    this.keywords,
    this.externalIds,
    this.seasons,
    this.mediaInfo,
  });

  @override
  String toString() => json.encode(this.toJson());

  factory OverseerrSeries.fromJson(Map<String, dynamic> json) =>
      _$OverseerrSeriesFromJson(json);

  Map<String, dynamic> toJson() => _$OverseerrSeriesToJson(this);
}
