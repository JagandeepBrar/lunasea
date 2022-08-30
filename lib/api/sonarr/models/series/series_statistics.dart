import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'series_statistics.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class SonarrSeriesStatistics {
  @JsonKey(name: 'seasonCount')
  int? seasonCount;

  @JsonKey(name: 'episodeFileCount')
  int? episodeFileCount;

  @JsonKey(name: 'episodeCount')
  int? episodeCount;

  @JsonKey(name: 'totalEpisodeCount')
  int? totalEpisodeCount;

  @JsonKey(name: 'sizeOnDisk')
  int? sizeOnDisk;

  @JsonKey(name: 'percentOfEpisodes')
  double? percentOfEpisodes;

  SonarrSeriesStatistics({
    this.episodeFileCount,
    this.episodeCount,
    this.totalEpisodeCount,
    this.sizeOnDisk,
    this.percentOfEpisodes,
  });

  @override
  String toString() => json.encode(this.toJson());

  factory SonarrSeriesStatistics.fromJson(Map<String, dynamic> json) =>
      _$SonarrSeriesStatisticsFromJson(json);
  Map<String, dynamic> toJson() => _$SonarrSeriesStatisticsToJson(this);
}
