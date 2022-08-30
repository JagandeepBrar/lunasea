import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

part 'library_user_stats.g.dart';

/// Model to store user stats for a library in Plex.
@JsonSerializable(explicitToJson: true)
class TautulliLibraryUserStats {
  /// Friendly name of the user.
  @JsonKey(
      name: 'friendly_name', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? friendlyName;

  /// User's thumbnail avatar.
  @JsonKey(name: 'user_thumb', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? userThumb;

  /// User's Plex/Tautulli ID.
  @JsonKey(name: 'user_id', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? userId;

  /// Total amount of plays from this library section the user has streamed.
  @JsonKey(
      name: 'total_plays', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? totalPlays;

  TautulliLibraryUserStats({
    this.friendlyName,
    this.userId,
    this.userThumb,
    this.totalPlays,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [TautulliLibraryUserStats] object.
  factory TautulliLibraryUserStats.fromJson(Map<String, dynamic> json) =>
      _$TautulliLibraryUserStatsFromJson(json);

  /// Serialize a [TautulliLibraryUserStats] object to a JSON map.
  Map<String, dynamic> toJson() => _$TautulliLibraryUserStatsToJson(this);
}
