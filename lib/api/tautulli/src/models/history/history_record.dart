import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:lunasea/modules/tautulli.dart';

part 'history_record.g.dart';

/// Model for a single history record in Tautulli.
@JsonSerializable(explicitToJson: true)
class TautulliHistoryRecord {
  /// Reference ID. If it is null, that means the session is currently active.
  @JsonKey(
      name: 'reference_id', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? referenceId;

  /// Row ID. If it is null, that means the session is currently active.
  @JsonKey(name: 'row_id', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? rowId;

  /// ID. If it is null, that means the session is currently active.
  @JsonKey(name: 'id', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? id;

  /// Date of the history record.
  @JsonKey(
      name: 'date', fromJson: TautulliUtilities.millisecondsDateTimeFromJson)
  final DateTime? date;

  /// Start date of the history record session.
  @JsonKey(
      name: 'started', fromJson: TautulliUtilities.millisecondsDateTimeFromJson)
  final DateTime? started;

  /// End date of the history record session.
  @JsonKey(
      name: 'stopped', fromJson: TautulliUtilities.millisecondsDateTimeFromJson)
  final DateTime? stopped;

  /// Duration of the session (in seconds).
  @JsonKey(
      name: 'duration', fromJson: TautulliUtilities.secondsDurationFromJson)
  final Duration? duration;

  /// The duration that the session has been or was paused for
  @JsonKey(
      name: 'paused_counter',
      fromJson: TautulliUtilities.secondsDurationFromJson)
  final Duration? pausedCounter;

  /// The ID of the user who streamed the content.
  @JsonKey(name: 'user_id', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? userId;

  /// Name of the user who streamed the content.
  @JsonKey(name: 'user', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? user;

  /// Friendly name of the user who streamed the content.
  @JsonKey(
      name: 'friendly_name', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? friendlyName;

  /// Platform of the streaming device.
  @JsonKey(name: 'platform', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? platform;

  /// Plex product name on the streaming device.
  @JsonKey(name: 'product', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? product;

  /// Name of the streaming device/player.
  @JsonKey(name: 'player', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? player;

  /// IP address of the streaming session.
  @JsonKey(name: 'ip_address', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? ipAddress;

  /// Was this a live session?
  @JsonKey(name: 'live', fromJson: TautulliUtilities.ensureBooleanFromJson)
  final bool? live;

  /// The type of media that was streamed.
  @JsonKey(
      name: 'media_type',
      toJson: TautulliUtilities.mediaTypeToJson,
      fromJson: TautulliUtilities.mediaTypeFromJson)
  final TautulliMediaType? mediaType;

  /// The content's unique ID from Plex.
  @JsonKey(
      name: 'rating_key', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? ratingKey;

  /// The content's parent's unique ID from Plex.
  @JsonKey(
      name: 'parent_rating_key',
      fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? parentRatingKey;

  /// The content's grandparent's unique ID from Plex.
  @JsonKey(
      name: 'grandparent_rating_key',
      fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? grandparentRatingKey;

  /// The full title of the content.
  @JsonKey(name: 'full_title', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? fullTitle;

  /// Title of the content.
  @JsonKey(name: 'title', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? title;

  /// Title of the parent of the content.
  @JsonKey(
      name: 'parent_title', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? parentTitle;

  /// Title of the grandparent of the content.
  @JsonKey(
      name: 'grandparent_title',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? grandparentTitle;

  /// The original title of the content.
  @JsonKey(
      name: 'original_title', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? originalTitle;

  /// The year the content was released.
  @JsonKey(name: 'year', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? year;

  /// The media index of the content.
  @JsonKey(
      name: 'media_index', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? mediaIndex;

  /// The content's parent's media index.
  @JsonKey(
      name: 'parent_media_index',
      fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? parentMediaIndex;

  /// Thumbnail path for the content.
  @JsonKey(name: 'thumb', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? thumb;

  /// The date on which the content was originally available on.
  ///
  /// Because of the custom formatting options, the DateTime is returned as a string.
  /// You can use the miscellaneous call `getDateFormats()` to pull the date and time formatting strings.
  @JsonKey(
      name: 'originally_available_at',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? originallyAvailableAt;

  /// The globally unique identifier for the content.
  @JsonKey(name: 'guid', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? guid;

  /// What decision was made on how to handle the content.
  @JsonKey(
      name: 'transcode_decision',
      toJson: TautulliUtilities.transcodeDecisionToJson,
      fromJson: TautulliUtilities.transcodeDecisionFromJson)
  final TautulliTranscodeDecision? transcodeDecision;

  /// How much of the content has been played.
  @JsonKey(
      name: 'percent_complete',
      fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? percentComplete;

  /// The watch status of the history record.
  @JsonKey(
      name: 'watched_status',
      toJson: TautulliUtilities.watchedStatusToJson,
      fromJson: TautulliUtilities.watchedStatusFromJson)
  final TautulliWatchedStatus? watchedStatus;

  /// How many groups this session is in.
  @JsonKey(
      name: 'group_count', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? groupCount;

  /// List of all the groups this session is in.
  @JsonKey(
      name: 'group_ids', fromJson: TautulliUtilities.stringToListStringFromJson)
  final List<String>? groupIds;

  /// Current state of the session if it is still active.
  @JsonKey(
      name: 'state',
      toJson: TautulliUtilities.sessionStateToJson,
      fromJson: TautulliUtilities.sessionStateFromJson)
  final TautulliSessionState? state;

  /// Session's key/identifier if it is still active.
  @JsonKey(
      name: 'session_key', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? sessionKey;

  TautulliHistoryRecord({
    this.referenceId,
    this.rowId,
    this.id,
    this.date,
    this.started,
    this.stopped,
    this.duration,
    this.pausedCounter,
    this.userId,
    this.user,
    this.friendlyName,
    this.platform,
    this.player,
    this.product,
    this.ipAddress,
    this.live,
    this.mediaType,
    this.ratingKey,
    this.parentRatingKey,
    this.grandparentRatingKey,
    this.fullTitle,
    this.title,
    this.parentTitle,
    this.grandparentTitle,
    this.originalTitle,
    this.year,
    this.mediaIndex,
    this.parentMediaIndex,
    this.thumb,
    this.originallyAvailableAt,
    this.guid,
    this.transcodeDecision,
    this.percentComplete,
    this.watchedStatus,
    this.groupCount,
    this.groupIds,
    this.state,
    this.sessionKey,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [TautulliHistoryRecord] object.
  factory TautulliHistoryRecord.fromJson(Map<String, dynamic> json) =>
      _$TautulliHistoryRecordFromJson(json);

  /// Serialize a [TautulliHistoryRecord] object to a JSON map.
  Map<String, dynamic> toJson() => _$TautulliHistoryRecordToJson(this);
}
