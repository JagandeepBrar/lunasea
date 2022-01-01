import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

part 'synced_item.g.dart';

/// Model to store data about a synced item from Plex.
@JsonSerializable(explicitToJson: true)
class TautulliSyncedItem {
  /// Name of the device that the content is synced to.
  @JsonKey(
      name: 'device_name', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? deviceName;

  /// Platform of the device.
  @JsonKey(name: 'platform', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? platform;

  /// The user's ID.
  @JsonKey(name: 'user_id', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? userId;

  /// The user's name.
  @JsonKey(name: 'user', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? user;

  /// The user's username.
  @JsonKey(name: 'username', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? username;

  /// The root item's title.
  @JsonKey(name: 'root_title', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? rootTitle;

  /// The synced content title.
  @JsonKey(name: 'sync_title', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? syncTitle;

  /// The metadata type of the synced content.
  @JsonKey(
      name: 'metadata_type', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? metadataType;

  /// The content type of the synced content.
  @JsonKey(
      name: 'content_type', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? contentType;

  /// The rating key for the synced content.
  @JsonKey(
      name: 'rating_key', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? ratingKey;

  /// The current state of the synced content.
  @JsonKey(name: 'state', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? state;

  /// The amount of items.
  @JsonKey(
      name: 'item_count', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? itemCount;

  /// The amount of completed items.
  @JsonKey(
      name: 'item_complete_count',
      fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? itemCompleteCount;

  /// The amount of downloaded items.
  @JsonKey(
      name: 'item_downloaded_count',
      fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? itemDownloadedCount;

  /// The percentage completed of downloaded items.
  @JsonKey(
      name: 'item_downloaded_percent_complete',
      fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? itemDownloadedPercentComplete;

  /// The synced video bitrate.
  @JsonKey(
      name: 'video_bitrate', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? videoBitrate;

  /// The synced audio bitrate.
  @JsonKey(
      name: 'audio_bitrate', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? audioBitrate;

  /// The synced photo quality.
  @JsonKey(
      name: 'photo_quality', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? photoQuality;

  /// The synced video quality.
  @JsonKey(
      name: 'video_quality', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? videoQuality;

  /// The total size in bytes of the synced content.
  @JsonKey(
      name: 'total_size', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? totalSize;

  /// Failure status.
  @JsonKey(name: 'failure', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? failure;

  /// The client ID.
  @JsonKey(name: 'client_id', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? clientId;

  /// The sync ID.
  @JsonKey(name: 'sync_id', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? syncId;

  TautulliSyncedItem({
    this.deviceName,
    this.platform,
    this.userId,
    this.user,
    this.username,
    this.rootTitle,
    this.syncTitle,
    this.metadataType,
    this.contentType,
    this.ratingKey,
    this.state,
    this.itemCount,
    this.itemCompleteCount,
    this.itemDownloadedCount,
    this.itemDownloadedPercentComplete,
    this.videoBitrate,
    this.audioBitrate,
    this.photoQuality,
    this.videoQuality,
    this.totalSize,
    this.failure,
    this.clientId,
    this.syncId,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [TautulliSyncedItem] object.
  factory TautulliSyncedItem.fromJson(Map<String, dynamic> json) =>
      _$TautulliSyncedItemFromJson(json);

  /// Serialize a [TautulliSyncedItem] object to a JSON map.
  Map<String, dynamic> toJson() => _$TautulliSyncedItemToJson(this);
}
