import 'package:lunasea/core.dart';

part 'season.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class OverseerrSeason {
  @JsonKey()
  int? id;

  @JsonKey()
  String? airDate;

  @JsonKey()
  int? episodeCount;

  @JsonKey()
  String? name;

  @JsonKey()
  String? overview;

  @JsonKey()
  int? seasonNumber;

  @JsonKey()
  String? posterPath;

  OverseerrSeason({
    this.id,
    this.airDate,
    this.episodeCount,
    this.name,
    this.overview,
    this.seasonNumber,
    this.posterPath,
  });

  @override
  String toString() => json.encode(this.toJson());

  factory OverseerrSeason.fromJson(Map<String, dynamic> json) =>
      _$OverseerrSeasonFromJson(json);

  Map<String, dynamic> toJson() => _$OverseerrSeasonToJson(this);
}
