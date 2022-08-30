import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

part 'user_ip_record.g.dart';

/// Model to store a single user login information.
@JsonSerializable(explicitToJson: true)
class TautulliUserIPRecord {
  /// History row identifier of the content that was last played from this IP address.
  @JsonKey(
      name: 'history_row_id', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? historyRowId;

  /// Date/time that this IP address was last seen.
  @JsonKey(
      name: 'last_seen',
      fromJson: TautulliUtilities.millisecondsDateTimeFromJson)
  final DateTime? lastSeen;

  /// Date/time that this IP address was first seen.
  @JsonKey(
      name: 'first_seen',
      fromJson: TautulliUtilities.millisecondsDateTimeFromJson)
  final DateTime? firstSeen;

  /// Originating IP address.
  @JsonKey(name: 'ip_address', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? ipAddress;

  /// Amount of plays from this location.
  @JsonKey(
      name: 'play_count', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? playCount;

  /// Platform that was last used from this location.
  @JsonKey(name: 'platform', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? platform;

  /// Player that was last used from this location.
  @JsonKey(name: 'player', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? player;

  /// Content that was last played from this location.
  @JsonKey(
      name: 'last_played', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? lastPlayed;

  /// Rating key for the content that was last played.
  @JsonKey(
      name: 'rating_key', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? ratingKey;

  /// Thumbnail path for the last played content.
  @JsonKey(name: 'thumb', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? thumb;

  /// Type of media that was last played.
  @JsonKey(
      name: 'media_type',
      toJson: TautulliUtilities.mediaTypeToJson,
      fromJson: TautulliUtilities.mediaTypeFromJson)
  final TautulliMediaType? mediaType;

  /// Title of the content's parent that was last played.
  @JsonKey(
      name: 'parent_title', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? parentTitle;

  /// Year of the content that was last played.
  @JsonKey(name: 'year', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? year;

  /// Media index.
  @JsonKey(
      name: 'media_index', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? mediaIndex;

  /// Parent media index.
  @JsonKey(
      name: 'parent_media_index',
      fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? parentMediaIndex;

  /// Is the last played content live content?
  @JsonKey(name: 'live', fromJson: TautulliUtilities.ensureBooleanFromJson)
  final bool? live;

  /// The date on which the last played content was originally available on.
  ///
  /// Because of the custom formatting options, the DateTime is returned as a string.
  /// You can use the miscellaneous call `getDateFormats()` to pull the date and time formatting strings.
  @JsonKey(
      name: 'originally_available_at',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? originallyAvailableAt;

  /// GUID of the content that was last played from Plex.
  @JsonKey(name: 'guid', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? guid;

  /// Friendly name of the user.
  @JsonKey(
      name: 'friendly_name', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? friendlyName;

  /// User's identifier.
  @JsonKey(name: 'user_id', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? userId;

  /// Transcoding decision made on the last played content.
  @JsonKey(
      name: 'transcode_decision',
      toJson: TautulliUtilities.transcodeDecisionToJson,
      fromJson: TautulliUtilities.transcodeDecisionFromJson)
  final TautulliTranscodeDecision? transcodedecision;

  TautulliUserIPRecord({
    this.historyRowId,
    this.lastSeen,
    this.firstSeen,
    this.ipAddress,
    this.playCount,
    this.platform,
    this.player,
    this.lastPlayed,
    this.ratingKey,
    this.thumb,
    this.mediaType,
    this.parentTitle,
    this.year,
    this.mediaIndex,
    this.parentMediaIndex,
    this.live,
    this.originallyAvailableAt,
    this.guid,
    this.friendlyName,
    this.userId,
    this.transcodedecision,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [TautulliUserIPRecord] object.
  factory TautulliUserIPRecord.fromJson(Map<String, dynamic> json) =>
      _$TautulliUserIPRecordFromJson(json);

  /// Serialize a [TautulliUserIPRecord] object to a JSON map.
  Map<String, dynamic> toJson() => _$TautulliUserIPRecordToJson(this);
}
