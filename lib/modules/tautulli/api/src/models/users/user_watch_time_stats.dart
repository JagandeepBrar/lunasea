import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

part 'user_watch_time_stats.g.dart';

/// Model to store total watch time stats for a user in Plex.
@JsonSerializable(explicitToJson: true)
class TautulliUserWatchTimeStats {
  /// The amount of days covered by the query.
  @JsonKey(
      name: 'query_days', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? queryDays;

  /// The total amount of plays from this user in this period.
  @JsonKey(
      name: 'total_plays', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? totalPlays;

  /// The total time this user has streamed content.
  @JsonKey(
      name: 'total_time', fromJson: TautulliUtilities.secondsDurationFromJson)
  final Duration? totalTime;

  TautulliUserWatchTimeStats({
    this.queryDays,
    this.totalPlays,
    this.totalTime,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [TautulliUserWatchTimeStats] object.
  factory TautulliUserWatchTimeStats.fromJson(Map<String, dynamic> json) =>
      _$TautulliUserWatchTimeStatsFromJson(json);

  /// Serialize a [TautulliUserWatchTimeStats] object to a JSON map.
  Map<String, dynamic> toJson() => _$TautulliUserWatchTimeStatsToJson(this);
}
