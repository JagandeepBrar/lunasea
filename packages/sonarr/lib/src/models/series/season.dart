import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'season_statistics.dart';

part 'season.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class SonarrSeriesSeason {
  @JsonKey(name: 'seasonNumber')
  int? seasonNumber;

  @JsonKey(name: 'monitored')
  bool? monitored;

  @JsonKey(name: 'statistics')
  SonarrSeriesSeasonStatistics? statistics;

  SonarrSeriesSeason({
    this.seasonNumber,
    this.monitored,
    this.statistics,
  });

  @override
  String toString() => json.encode(this.toJson());

  factory SonarrSeriesSeason.fromJson(Map<String, dynamic> json) =>
      _$SonarrSeriesSeasonFromJson(json);
  Map<String, dynamic> toJson() => _$SonarrSeriesSeasonToJson(this);
}
