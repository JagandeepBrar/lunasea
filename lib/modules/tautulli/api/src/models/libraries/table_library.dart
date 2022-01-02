import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

part 'table_library.g.dart';

/// Model for a single Tautulli library data from the library table in Tautulli.
///
/// Typically contained within a [TautulliLibrariesTable] object.
@JsonSerializable(explicitToJson: true)
class TautulliTableLibrary {
  /// Row identifier of the library.
  @JsonKey(name: 'row_id', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? rowId;

  /// Server identifier of the library.
  @JsonKey(name: 'server_id', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? serverId;

  /// Section identifier of the library.
  @JsonKey(
      name: 'section_id', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? sectionId;

  /// Section name of the library.
  @JsonKey(
      name: 'section_name', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? sectionName;

  /// Section type of the library.
  @JsonKey(
      name: 'section_type',
      toJson: TautulliUtilities.sectionTypeToJson,
      fromJson: TautulliUtilities.sectionTypeFromJson)
  final TautulliSectionType? sectionType;

  /// Amount of root-level content (show, artist, etc.) in the library.
  @JsonKey(name: 'count', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? count;

  /// Amount of parent-level content (season, albums, etc.) in the library.
  @JsonKey(
      name: 'parent_count', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? parentCount;

  /// Amount of child-level content (episode, song, etc.) in the library.
  @JsonKey(
      name: 'child_count', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? childCount;

  /// Path to the library thumbnail.
  @JsonKey(
      name: 'library_thumb', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? libraryThumb;

  /// Path to the library artwork.
  @JsonKey(
      name: 'library_art', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? libraryArt;

  /// Total amount of plays from this library.
  @JsonKey(name: 'plays', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? plays;

  /// Duration of the entire library.
  @JsonKey(
      name: 'duration', fromJson: TautulliUtilities.secondsDurationFromJson)
  final Duration? duration;

  /// The date/time the library was last accessed.
  @JsonKey(
      name: 'last_accessed',
      fromJson: TautulliUtilities.millisecondsDateTimeFromJson)
  final DateTime? lastAccessed;

  /// The history row identifier of the content that was last played.
  @JsonKey(
      name: 'history_row_id', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? historyRowId;

  /// The title of the content that was last played.
  @JsonKey(
      name: 'last_played', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? lastPlayed;

  /// The rating key of the content that was last played.
  @JsonKey(
      name: 'rating_key', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? ratingKey;

  /// The type of media that was last played.
  @JsonKey(
      name: 'media_type',
      toJson: TautulliUtilities.mediaTypeToJson,
      fromJson: TautulliUtilities.mediaTypeFromJson)
  final TautulliMediaType? mediaType;

  /// Path to the last streamed content's thumbnail.
  @JsonKey(name: 'thumb', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? thumb;

  /// Title of the content's parent.
  @JsonKey(
      name: 'parent_title', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? parentTitle;

  /// Year that the content was released.
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

  /// Content rating of the content that was last played.
  @JsonKey(
      name: 'content_rating', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? contentRating;

  /// Labels on the content that was last played.
  @JsonKey(name: 'labels', fromJson: TautulliUtilities.ensureStringListFromJson)
  final List<String?>? labels;

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

  /// Are notifications enabled for this library?
  @JsonKey(name: 'do_notify', fromJson: TautulliUtilities.ensureBooleanFromJson)
  final bool? doNotify;

  /// Are created notifications enabled for this library?
  @JsonKey(
      name: 'do_notify_created',
      fromJson: TautulliUtilities.ensureBooleanFromJson)
  final bool? doNotifyCreated;

  /// Is history enabled for the library?
  @JsonKey(
      name: 'keep_history', fromJson: TautulliUtilities.ensureBooleanFromJson)
  final bool? keepHistory;

  /// Is the library active?
  @JsonKey(name: 'is_active', fromJson: TautulliUtilities.ensureBooleanFromJson)
  final bool? isActive;

  TautulliTableLibrary({
    this.rowId,
    this.serverId,
    this.sectionId,
    this.sectionName,
    this.sectionType,
    this.count,
    this.parentCount,
    this.childCount,
    this.libraryArt,
    this.libraryThumb,
    this.plays,
    this.duration,
    this.lastAccessed,
    this.historyRowId,
    this.lastPlayed,
    this.ratingKey,
    this.mediaType,
    this.thumb,
    this.parentTitle,
    this.year,
    this.mediaIndex,
    this.parentMediaIndex,
    this.contentRating,
    this.labels,
    this.live,
    this.originallyAvailableAt,
    this.guid,
    this.doNotify,
    this.doNotifyCreated,
    this.isActive,
    this.keepHistory,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [TautulliTableLibrary] object.
  factory TautulliTableLibrary.fromJson(Map<String, dynamic> json) =>
      _$TautulliTableLibraryFromJson(json);

  /// Serialize a [TautulliTableLibrary] object to a JSON map.
  Map<String, dynamic> toJson() => _$TautulliTableLibraryToJson(this);
}
