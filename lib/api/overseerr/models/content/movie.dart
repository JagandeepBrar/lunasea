import 'package:lunasea/api/overseerr/models.dart';
import 'package:lunasea/core.dart';

part 'movie.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class OverseerrMovie {
  @JsonKey()
  int? id;

  @JsonKey()
  String? imdbId;

  @JsonKey()
  bool? adult;

  @JsonKey()
  String? backdropPath;

  @JsonKey()
  int? budget;

  @JsonKey()
  List<OverseerrGenre>? genres;

  @JsonKey()
  String? homepage;

  @JsonKey()
  String? originalLanguage;

  @JsonKey()
  String? originalTitle;

  @JsonKey()
  String? overview;

  @JsonKey()
  double? popularity;

  @JsonKey()
  List<OverseerrRelatedVideo>? relatedVideos;

  @JsonKey()
  String? posterPath;

  @JsonKey()
  List<OverseerrProductionCompany>? productionCompanies;

  @JsonKey()
  List<OverseerrProductionCountry>? productionCountries;

  @JsonKey()
  String? releaseDate;

  @JsonKey()
  int? revenue;

  @JsonKey()
  int? runtime;

  @JsonKey()
  String? status;

  @JsonKey()
  String? tagline;

  @JsonKey()
  String? title;

  @JsonKey()
  bool? video;

  @JsonKey()
  double? voteAverage;

  @JsonKey()
  int? voteCount;

  @JsonKey()
  String? plexUrl;

  @JsonKey()
  OverseerrCollection? collection;

  @JsonKey()
  OverseerrExternalIds? externalIds;

  @JsonKey()
  OverseerrMedia? mediaInfo;

  @JsonKey()
  List<OverseerrWatchProvider>? watchProviders;

  @JsonKey()
  OverseerrCredits? credits;

  @JsonKey()
  List<OverseerrSpokenLanguage>? spokenLanguages;

  @JsonKey()
  OverseerrMovieReleases? releases;

  OverseerrMovie({
    this.id,
    this.imdbId,
    this.adult,
    this.backdropPath,
    this.budget,
    this.genres,
    this.homepage,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.relatedVideos,
    this.posterPath,
    this.productionCompanies,
    this.productionCountries,
    this.releaseDate,
    this.revenue,
    this.runtime,
    this.status,
    this.tagline,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
    this.plexUrl,
    this.collection,
    this.externalIds,
    this.mediaInfo,
    this.watchProviders,
    this.credits,
    this.spokenLanguages,
  });

  @override
  String toString() => json.encode(this.toJson());

  factory OverseerrMovie.fromJson(Map<String, dynamic> json) =>
      _$OverseerrMovieFromJson(json);

  Map<String, dynamic> toJson() => _$OverseerrMovieToJson(this);
}
