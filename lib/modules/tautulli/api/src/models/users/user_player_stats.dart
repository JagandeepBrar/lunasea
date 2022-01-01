import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

part 'user_player_stats.g.dart';

/// Model to store total watch time stats for a user's players in Plex.
@JsonSerializable(explicitToJson: true)
class TautulliUserPlayerStats {
  /// The result (player) ID.
  @JsonKey(name: 'result_id', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? resultId;

  /// The total amount of plays from this user's player in this period.
  @JsonKey(
      name: 'total_plays', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? totalPlays;

  /// The name of the player.
  @JsonKey(
      name: 'player_name', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? playerName;

  /// The platform of the player.
  @JsonKey(name: 'platform', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? platform;

  /// The name of the platform.
  @JsonKey(
      name: 'platform_name', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? platformName;

  TautulliUserPlayerStats({
    this.resultId,
    this.totalPlays,
    this.platform,
    this.platformName,
    this.playerName,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [TautulliUserPlayerStats] object.
  factory TautulliUserPlayerStats.fromJson(Map<String, dynamic> json) =>
      _$TautulliUserPlayerStatsFromJson(json);

  /// Serialize a [TautulliUserPlayerStats] object to a JSON map.
  Map<String, dynamic> toJson() => _$TautulliUserPlayerStatsToJson(this);
}
