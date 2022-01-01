import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:lunasea/modules/sonarr.dart';

part 'season.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class SonarrSeriesSeason {
  @JsonKey(name: 'seasonNumber')
  int? seasonNumber;

  @JsonKey(name: 'monitored')
  bool? monitored;

  @JsonKey(name: 'statistics')
  SonarrSeriesSeasonStatistics? statistics;

  @JsonKey(name: 'images')
  List<SonarrImage>? images;

  SonarrSeriesSeason({
    this.seasonNumber,
    this.monitored,
    this.statistics,
    this.images,
  });

  @override
  String toString() => json.encode(this.toJson());

  factory SonarrSeriesSeason.fromJson(Map<String, dynamic> json) =>
      _$SonarrSeriesSeasonFromJson(json);
  Map<String, dynamic> toJson() => _$SonarrSeriesSeasonToJson(this);
}
