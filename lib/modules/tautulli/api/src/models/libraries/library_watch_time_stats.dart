import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

part 'library_watch_time_stats.g.dart';

/// Model to store total watch time stats for a library in Plex.
@JsonSerializable(explicitToJson: true)
class TautulliLibraryWatchTimeStats {
  /// The amount of days covered by the query.
  @JsonKey(
      name: 'query_days', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? queryDays;

  /// The total amount of plays from this library.
  @JsonKey(
      name: 'total_plays', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? totalPlays;

  /// The total time this library has been streamed.
  @JsonKey(
      name: 'total_time', fromJson: TautulliUtilities.secondsDurationFromJson)
  final Duration? totalTime;

  TautulliLibraryWatchTimeStats({
    this.queryDays,
    this.totalPlays,
    this.totalTime,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [TautulliLibraryWatchTimeStats] object.
  factory TautulliLibraryWatchTimeStats.fromJson(Map<String, dynamic> json) =>
      _$TautulliLibraryWatchTimeStatsFromJson(json);

  /// Serialize a [TautulliLibraryWatchTimeStats] object to a JSON map.
  Map<String, dynamic> toJson() => _$TautulliLibraryWatchTimeStatsToJson(this);
}
