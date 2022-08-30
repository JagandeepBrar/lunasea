import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:lunasea/modules/sonarr.dart';

part 'season_statistics.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class SonarrSeriesSeasonStatistics {
  @JsonKey(
    name: 'previousAiring',
    toJson: SonarrUtilities.dateTimeToJson,
    fromJson: SonarrUtilities.dateTimeFromJson,
  )
  DateTime? previousAiring;

  @JsonKey(
    name: 'nextAiring',
    toJson: SonarrUtilities.dateTimeToJson,
    fromJson: SonarrUtilities.dateTimeFromJson,
  )
  DateTime? nextAiring;

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

  SonarrSeriesSeasonStatistics({
    this.previousAiring,
    this.nextAiring,
    this.episodeFileCount,
    this.episodeCount,
    this.totalEpisodeCount,
    this.sizeOnDisk,
    this.percentOfEpisodes,
  });

  @override
  String toString() => json.encode(this.toJson());

  factory SonarrSeriesSeasonStatistics.fromJson(Map<String, dynamic> json) =>
      _$SonarrSeriesSeasonStatisticsFromJson(json);
  Map<String, dynamic> toJson() => _$SonarrSeriesSeasonStatisticsToJson(this);
}
