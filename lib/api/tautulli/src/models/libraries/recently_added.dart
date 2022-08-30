import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

part 'recently_added.g.dart';

/// Model to store information about some recently added content.
@JsonSerializable(explicitToJson: true)
class TautulliRecentlyAdded {
  /// Type of media.
  @JsonKey(
      name: 'media_type',
      toJson: TautulliUtilities.mediaTypeToJson,
      fromJson: TautulliUtilities.mediaTypeFromJson)
  final TautulliMediaType? mediaType;

  /// Plex section ID the content belongs to.
  @JsonKey(
      name: 'section_id', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? sectionId;

  /// Name of the Plex library that the content belongs to.
  @JsonKey(
      name: 'library_name', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? libraryName;

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

  /// The sort title of the content (if different from the title).
  @JsonKey(name: 'sort_title', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? sortTitle;

  /// The index of the content with respect to its parent (for example, track number in an album).
  @JsonKey(
      name: 'media_index', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? mediaIndex;

  /// The index of the parent of the content.
  @JsonKey(
      name: 'parent_media_index',
      fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? parentMediaIndex;

  /// The studio that made the content.
  @JsonKey(name: 'studio', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? studio;

  /// The content rating for the content.
  @JsonKey(
      name: 'content_rating', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? contentRating;

  /// The summary of the content.
  @JsonKey(name: 'summary', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? summary;

  /// The tagline of the content.
  @JsonKey(name: 'tagline', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? tagline;

  /// The critic rating of the content.
  @JsonKey(name: 'rating', fromJson: TautulliUtilities.ensureDoubleFromJson)
  final double? rating;

  /// Link to an image for the critic rating.
  @JsonKey(
      name: 'rating_image', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? ratingImage;

  /// The audience rating of the content.
  @JsonKey(
      name: 'audience_rating', fromJson: TautulliUtilities.ensureDoubleFromJson)
  final double? audienceRating;

  /// Link to an image for the audience rating.
  @JsonKey(
      name: 'audience_rating_image',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? audienceRatingImage;

  /// The user rating of the content.
  @JsonKey(
      name: 'user_rating', fromJson: TautulliUtilities.ensureDoubleFromJson)
  final double? userRating;

  /// Duration of the content.
  @JsonKey(
      name: 'duration',
      fromJson: TautulliUtilities.millisecondsDurationFromJson)
  final Duration? duration;

  /// Year the content was released.
  @JsonKey(name: 'year', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? year;

  /// Thumbnail path for the content.
  @JsonKey(name: 'thumb', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? thumb;

  /// Thumbnail path for the content's parent.
  @JsonKey(
      name: 'parent_thumb', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? parentThumb;

  /// Thumbnail path for the content's grandparent.
  @JsonKey(
      name: 'grandparent_thumb',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? grandparentThumb;

  /// Artwork path for the content.
  @JsonKey(name: 'art', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? art;

  /// Banner path for the content.
  @JsonKey(name: 'banner', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? banner;

  /// The date on which the content was originally available on.
  ///
  /// Because of the custom formatting options, the DateTime is returned as a string.
  /// You can use the miscellaneous call `getDateFormats()` to pull the date and time formatting strings.
  @JsonKey(
      name: 'originally_available_at',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? originallyAvailableAt;

  /// The date on which the content was added to Plex.
  /// This is typically read/stored as the file creation date within Plex.
  @JsonKey(
      name: 'added_at',
      fromJson: TautulliUtilities.millisecondsDateTimeFromJson)
  final DateTime? addedAt;

  /// The date on which the content was last updated on Plex.
  @JsonKey(
      name: 'updated_at',
      fromJson: TautulliUtilities.millisecondsDateTimeFromJson)
  final DateTime? updatedAt;

  /// The date on which the content was last viewed on Plex.
  @JsonKey(
      name: 'last_viewed_at',
      fromJson: TautulliUtilities.millisecondsDateTimeFromJson)
  final DateTime? lastViewedAt;

  /// The globally unique identifier for the content.
  @JsonKey(name: 'guid', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? guid;

  /// List of director's names who directed the content.
  @JsonKey(
      name: 'directors', fromJson: TautulliUtilities.ensureStringListFromJson)
  final List<String?>? directors;

  /// List of writer's names who wrote the content.
  @JsonKey(
      name: 'writers', fromJson: TautulliUtilities.ensureStringListFromJson)
  final List<String?>? writers;

  /// List of actors's names who acted in the content.
  @JsonKey(name: 'actors', fromJson: TautulliUtilities.ensureStringListFromJson)
  final List<String?>? actors;

  /// List of genres of the content.
  @JsonKey(name: 'genres', fromJson: TautulliUtilities.ensureStringListFromJson)
  final List<String?>? genres;

  /// List of labels that have been attached on Plex.
  @JsonKey(name: 'labels', fromJson: TautulliUtilities.ensureStringListFromJson)
  final List<String?>? labels;

  /// List of collections the content is apart of on Plex.
  @JsonKey(
      name: 'collections', fromJson: TautulliUtilities.ensureStringListFromJson)
  final List<String?>? collections;

  /// The full title of the content.
  @JsonKey(name: 'full_title', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? fullTitle;

  /// The amount of children this content has.
  @JsonKey(
      name: 'children_count', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? childrenCount;

  TautulliRecentlyAdded({
    this.mediaType,
    this.sectionId,
    this.libraryName,
    this.ratingKey,
    this.parentRatingKey,
    this.grandparentRatingKey,
    this.title,
    this.parentTitle,
    this.grandparentTitle,
    this.originalTitle,
    this.sortTitle,
    this.mediaIndex,
    this.parentMediaIndex,
    this.studio,
    this.contentRating,
    this.summary,
    this.tagline,
    this.rating,
    this.ratingImage,
    this.audienceRating,
    this.audienceRatingImage,
    this.userRating,
    this.duration,
    this.year,
    this.thumb,
    this.parentThumb,
    this.grandparentThumb,
    this.art,
    this.banner,
    this.originallyAvailableAt,
    this.addedAt,
    this.updatedAt,
    this.lastViewedAt,
    this.guid,
    this.directors,
    this.actors,
    this.writers,
    this.genres,
    this.labels,
    this.collections,
    this.fullTitle,
    this.childrenCount,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [TautulliRecentlyAdded] object.
  factory TautulliRecentlyAdded.fromJson(Map<String, dynamic> json) =>
      _$TautulliRecentlyAddedFromJson(json);

  /// Serialize a [TautulliRecentlyAdded] object to a JSON map.
  Map<String, dynamic> toJson() => _$TautulliRecentlyAddedToJson(this);
}
