import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

part 'library_media_info_record.g.dart';

/// Model to store the Tautulli media information table data.
@JsonSerializable(explicitToJson: true)
class TautulliLibraryMediaInfoRecord {
  /// Library section ID.
  @JsonKey(
      name: 'section_id', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? sectionId;

  /// Library section type.
  @JsonKey(
      name: 'section_type',
      toJson: TautulliUtilities.sectionTypeToJson,
      fromJson: TautulliUtilities.sectionTypeFromJson)
  final TautulliSectionType? sectionType;

  /// Date on which the content was added to Plex.
  /// This is typically read/stored as the file creation date within Plex.
  @JsonKey(
      name: 'added_at',
      fromJson: TautulliUtilities.millisecondsDateTimeFromJson)
  final DateTime? addedAt;

  /// Type of media in this session.
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

  /// Title of the content.
  @JsonKey(name: 'title', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? title;

  /// Sort title of the content.
  @JsonKey(name: 'sort_title', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? sortTitle;

  /// Year the content was released.
  @JsonKey(name: 'year', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? year;

  /// The index of the content with respect to its parent (for example, track number in an album).
  @JsonKey(
      name: 'media_index', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? mediaIndex;

  /// The index of the parent of the content.
  @JsonKey(
      name: 'parent_media_index',
      fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? parentMediaIndex;

  /// Thumbnail path for the content.
  @JsonKey(name: 'thumb', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? thumb;

  /// The media container type of the content.
  @JsonKey(name: 'container', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? container;

  /// Bitrate of the content.
  @JsonKey(name: 'bitrate', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? bitrate;

  /// Codec of the video stream.
  @JsonKey(
      name: 'video_codec', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? videoCodec;

  /// Resolution of the video stream.
  @JsonKey(
      name: 'video_resolution',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? videoResolution;

  /// Framerate of the video stream.
  @JsonKey(
      name: 'video_framerate', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? videoFramerate;

  /// Codec of the audio stream.
  @JsonKey(
      name: 'audio_codec', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? audioCodec;

  /// Number of channels in the audio stream.
  @JsonKey(
      name: 'audio_channels', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? audioChannels;

  /// The size of the file, in bytes.
  @JsonKey(name: 'file_size', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? fileSize;

  /// Date/time that the content was last played.
  @JsonKey(
      name: 'last_played',
      fromJson: TautulliUtilities.millisecondsDateTimeFromJson)
  final DateTime? lastPlayed;

  /// Amount of times the content has been played.
  @JsonKey(
      name: 'play_count', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? playCount;

  TautulliLibraryMediaInfoRecord({
    this.sectionId,
    this.sectionType,
    this.addedAt,
    this.mediaType,
    this.ratingKey,
    this.parentRatingKey,
    this.grandparentRatingKey,
    this.title,
    this.sortTitle,
    this.year,
    this.mediaIndex,
    this.parentMediaIndex,
    this.thumb,
    this.container,
    this.bitrate,
    this.videoCodec,
    this.videoResolution,
    this.videoFramerate,
    this.audioCodec,
    this.audioChannels,
    this.fileSize,
    this.lastPlayed,
    this.playCount,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [TautulliLibraryMediaInfoRecord] object.
  factory TautulliLibraryMediaInfoRecord.fromJson(Map<String, dynamic> json) =>
      _$TautulliLibraryMediaInfoRecordFromJson(json);

  /// Serialize a [TautulliLibraryMediaInfoRecord] object to a JSON map.
  Map<String, dynamic> toJson() => _$TautulliLibraryMediaInfoRecordToJson(this);
}
