import 'package:lunasea/core.dart';

part 'movie_releases.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class OverseerrMovieReleases {
  @JsonKey()
  List<OverseerrMovieReleaseResult>? results;

  OverseerrMovieReleases({
    this.results,
  });

  @override
  String toString() => json.encode(this.toJson());

  factory OverseerrMovieReleases.fromJson(Map<String, dynamic> json) =>
      _$OverseerrMovieReleasesFromJson(json);

  Map<String, dynamic> toJson() => _$OverseerrMovieReleasesToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class OverseerrMovieReleaseResult {
  @JsonKey(name: 'iso_3166_1')
  String? iso31661;

  @JsonKey(name: 'release_dates')
  List<OverseerrMovieReleaseResultDate>? releaseDates;

  OverseerrMovieReleaseResult({
    this.iso31661,
    this.releaseDates,
  });

  @override
  String toString() => json.encode(this.toJson());

  factory OverseerrMovieReleaseResult.fromJson(Map<String, dynamic> json) =>
      _$OverseerrMovieReleaseResultFromJson(json);

  Map<String, dynamic> toJson() => _$OverseerrMovieReleaseResultToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class OverseerrMovieReleaseResultDate {
  @JsonKey()
  String? certification;

  @JsonKey(name: 'iso_639_1')
  String? iso6391;

  @JsonKey()
  String? note;

  @JsonKey(name: 'release_date')
  String? releaseDate;

  @JsonKey()
  int? type;

  OverseerrMovieReleaseResultDate({
    this.certification,
    this.iso6391,
    this.note,
    this.releaseDate,
    this.type,
  });

  @override
  String toString() => json.encode(this.toJson());

  factory OverseerrMovieReleaseResultDate.fromJson(Map<String, dynamic> json) =>
      _$OverseerrMovieReleaseResultDateFromJson(json);

  Map<String, dynamic> toJson() =>
      _$OverseerrMovieReleaseResultDateToJson(this);
}
