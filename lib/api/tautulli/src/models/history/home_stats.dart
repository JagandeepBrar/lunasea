import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

part 'home_stats.g.dart';

/// Model to store the data for the home statistics.
@JsonSerializable(explicitToJson: true)
class TautulliHomeStats {
  /// ID for the statistic type.
  @JsonKey(name: 'stat_id', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? id;

  /// Statistic type.
  @JsonKey(name: 'stat_type', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? type;

  /// Statistic title.
  @JsonKey(name: 'stat_title', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? title;

  /// Statistics data.
  @JsonKey(name: 'rows')
  final List<Map<String, dynamic>>? data;

  TautulliHomeStats({
    this.id,
    this.title,
    this.type,
    this.data,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [TautulliHomeStats] object.
  factory TautulliHomeStats.fromJson(Map<String, dynamic> json) =>
      _$TautulliHomeStatsFromJson(json);

  /// Serialize a [TautulliHomeStats] object to a JSON map.
  Map<String, dynamic> toJson() => _$TautulliHomeStatsToJson(this);
}
