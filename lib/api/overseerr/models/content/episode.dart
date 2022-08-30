import 'package:lunasea/core.dart';

part 'episode.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class OverseerrEpisode {
  @JsonKey()
  int? id;

  @JsonKey()
  String? airDate;

  @JsonKey()
  int? episodeNumber;

  @JsonKey()
  String? name;

  @JsonKey()
  String? overview;

  @JsonKey()
  String? productionCode;

  @JsonKey()
  int? seasonNumber;

  @JsonKey()
  double? voteAverage;

  @JsonKey()
  String? stillPath;

  OverseerrEpisode({
    this.id,
    this.airDate,
    this.episodeNumber,
    this.name,
    this.overview,
    this.productionCode,
    this.seasonNumber,
    this.voteAverage,
    this.stillPath,
  });

  @override
  String toString() => json.encode(this.toJson());

  factory OverseerrEpisode.fromJson(Map<String, dynamic> json) =>
      _$OverseerrEpisodeFromJson(json);

  Map<String, dynamic> toJson() => _$OverseerrEpisodeToJson(this);
}
