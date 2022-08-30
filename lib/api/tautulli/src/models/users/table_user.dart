import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

part 'table_user.g.dart';

/// Model for a single Tautulli user's data from the user table in Tautulli.
///
/// Typically contained within a [TautulliUsersTable] object.
@JsonSerializable(explicitToJson: true)
class TautulliTableUser {
  /// The row identifier of the user.
  @JsonKey(name: 'row_id', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? rowId;

  /// The user identifier.
  @JsonKey(name: 'user_id', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? userId;

  /// Friendly name of the user.
  @JsonKey(
      name: 'friendly_name', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? friendlyName;

  /// Thumbnail link of the user.
  @JsonKey(name: 'user_thumb', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? userThumb;

  /// Total number of plays by this user.
  @JsonKey(name: 'plays', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? plays;

  /// The total duration this user has viewed from your server(s).
  @JsonKey(
      name: 'duration', fromJson: TautulliUtilities.secondsDurationFromJson)
  final Duration? duration;

  /// The date/time that the user was last seen.
  @JsonKey(
      name: 'last_seen',
      fromJson: TautulliUtilities.millisecondsDateTimeFromJson)
  final DateTime? lastSeen;

  /// The title of the content that was last played.
  @JsonKey(
      name: 'last_played', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? lastPlayed;

  /// The history row identifier of the last session.
  @JsonKey(
      name: 'history_row_id', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? historyRowId;

  /// The last recorded IP address of the user.
  @JsonKey(name: 'ip_address', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? ipAddress;

  /// The platform that was last used by the user.
  @JsonKey(name: 'platform', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? platform;

  /// The name of the player that was last used by the user.
  @JsonKey(name: 'player', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? player;

  /// The rating key for the content of the last session.
  @JsonKey(
      name: 'rating_key', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? ratingKey;

  /// The media type of the last session.
  @JsonKey(
      name: 'media_type',
      toJson: TautulliUtilities.mediaTypeToJson,
      fromJson: TautulliUtilities.mediaTypeFromJson)
  final TautulliMediaType? mediaType;

  /// The thumbnail path for the last session's content.
  @JsonKey(name: 'thumb', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? thumb;

  /// The title of the parent of the last session's content.
  @JsonKey(
      name: 'parent_title', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? parentTitle;

  /// The release year of the last session's content.
  @JsonKey(name: 'year', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? year;

  /// The media index of the last session's content (for example, the track # or the season #).
  @JsonKey(
      name: 'media_index', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? mediaIndex;

  /// The media index of the last session's content's parent (for example, the album or the season #).
  @JsonKey(
      name: 'parent_media_index',
      fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? parentMediaIndex;

  /// Was the user's last session live content?
  @JsonKey(name: 'live', fromJson: TautulliUtilities.ensureBooleanFromJson)
  final bool? live;

  /// The date on which the last session's content was originally available on.
  ///
  /// Because of the custom formatting options, the DateTime is returned as a string.
  /// You can use the miscellaneous call `getDateFormats()` to pull the date and time formatting strings.
  @JsonKey(
      name: 'originally_available_at',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? originallyAvailableAt;

  /// The Plex GUID of the last session's content.
  @JsonKey(name: 'guid', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? guid;

  /// What decision was made on how to handle the last session's content.
  @JsonKey(
      name: 'transcode_decision',
      toJson: TautulliUtilities.transcodeDecisionToJson,
      fromJson: TautulliUtilities.transcodeDecisionFromJson)
  final TautulliTranscodeDecision? transcodeDecision;

  /// Does the user have notifications enabled?
  @JsonKey(name: 'do_notify', fromJson: TautulliUtilities.ensureBooleanFromJson)
  final bool? doNotify;

  /// Is history tracking enabled for this user?
  @JsonKey(
      name: 'keep_history', fromJson: TautulliUtilities.ensureBooleanFromJson)
  final bool? keepHistory;

  /// Does the user have guest access to Tautulli?
  @JsonKey(
      name: 'allow_guest', fromJson: TautulliUtilities.ensureBooleanFromJson)
  final bool? allowGuest;

  /// Is the user active?
  @JsonKey(name: 'is_active', fromJson: TautulliUtilities.ensureBooleanFromJson)
  final bool? isActive;

  TautulliTableUser({
    this.rowId,
    this.userId,
    this.friendlyName,
    this.userThumb,
    this.plays,
    this.duration,
    this.lastSeen,
    this.lastPlayed,
    this.historyRowId,
    this.ipAddress,
    this.platform,
    this.player,
    this.ratingKey,
    this.mediaType,
    this.thumb,
    this.parentTitle,
    this.year,
    this.mediaIndex,
    this.parentMediaIndex,
    this.live,
    this.originallyAvailableAt,
    this.guid,
    this.transcodeDecision,
    this.doNotify,
    this.keepHistory,
    this.allowGuest,
    this.isActive,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [TautulliTableUser] object.
  factory TautulliTableUser.fromJson(Map<String, dynamic> json) =>
      _$TautulliTableUserFromJson(json);

  /// Serialize a [TautulliTableUser] object to a JSON map.
  Map<String, dynamic> toJson() => _$TautulliTableUserToJson(this);
}
