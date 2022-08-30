import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

part 'metadata.g.dart';

@JsonSerializable(explicitToJson: true)
class TautulliMetadata {
  @JsonKey(
    name: 'media_type',
    toJson: TautulliUtilities.mediaTypeToJson,
    fromJson: TautulliUtilities.mediaTypeFromJson,
  )
  final TautulliMediaType? mediaType;

  @JsonKey(
      name: 'section_id', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? sectionId;

  @JsonKey(
      name: 'library_name', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? libraryName;

  @JsonKey(
      name: 'rating_key', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? ratingKey;

  @JsonKey(
      name: 'parent_rating_key',
      fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? parentRatingKey;

  @JsonKey(
      name: 'grandparent_rating_key',
      fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? grandparentRatingKey;

  @JsonKey(name: 'title', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? title;

  @JsonKey(
      name: 'parent_title', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? parentTitle;

  @JsonKey(
      name: 'grandparent_title',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? grandparentTitle;

  @JsonKey(
      name: 'original_title', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? originalTitle;

  @JsonKey(name: 'sort_title', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? sortTitle;

  @JsonKey(
      name: 'media_index', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? mediaIndex;

  @JsonKey(
      name: 'parent_media_index',
      fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? parentMediaIndex;

  @JsonKey(name: 'studio', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? studio;

  @JsonKey(
      name: 'content_rating', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? contentRating;

  @JsonKey(name: 'summary', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? summary;

  @JsonKey(name: 'tagline', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? tagline;

  @JsonKey(name: 'rating', fromJson: TautulliUtilities.ensureDoubleFromJson)
  final double? rating;

  @JsonKey(
      name: 'rating_image', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? ratingImage;

  @JsonKey(
      name: 'audience_rating', fromJson: TautulliUtilities.ensureDoubleFromJson)
  final double? audienceRating;

  @JsonKey(
      name: 'audience_rating_image',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? audienceRatingImage;

  @JsonKey(
      name: 'user_rating', fromJson: TautulliUtilities.ensureDoubleFromJson)
  final double? userRating;

  @JsonKey(
      name: 'duration',
      fromJson: TautulliUtilities.millisecondsDurationFromJson)
  final Duration? duration;

  @JsonKey(name: 'year', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? year;

  @JsonKey(name: 'thumb', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? thumb;

  @JsonKey(
      name: 'parent_thumb', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? parentThumb;

  @JsonKey(
      name: 'grandparent_thumb',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? grandparentThumb;

  @JsonKey(name: 'art', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? art;

  @JsonKey(name: 'banner', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? banner;

  @JsonKey(
      name: 'originally_available_at',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? originallyAvailableAt;

  @JsonKey(
      name: 'added_at',
      fromJson: TautulliUtilities.millisecondsDateTimeFromJson)
  final DateTime? addedAt;

  @JsonKey(
      name: 'updated_at',
      fromJson: TautulliUtilities.millisecondsDateTimeFromJson)
  final DateTime? updatedAt;

  @JsonKey(
      name: 'last_viewed_at',
      fromJson: TautulliUtilities.millisecondsDateTimeFromJson)
  final DateTime? lastViewedAt;

  @JsonKey(name: 'guid', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? guid;

  @JsonKey(
      name: 'parent_guid', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? parentGuid;

  @JsonKey(
      name: 'grandparent_guid',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? grandparentGuid;

  @JsonKey(
      name: 'directors', fromJson: TautulliUtilities.ensureStringListFromJson)
  final List<String?>? directors;

  @JsonKey(
      name: 'writers', fromJson: TautulliUtilities.ensureStringListFromJson)
  final List<String?>? writers;

  @JsonKey(name: 'actors', fromJson: TautulliUtilities.ensureStringListFromJson)
  final List<String?>? actors;

  @JsonKey(name: 'genres', fromJson: TautulliUtilities.ensureStringListFromJson)
  final List<String?>? genres;

  @JsonKey(name: 'labels', fromJson: TautulliUtilities.ensureStringListFromJson)
  final List<String?>? labels;

  @JsonKey(
      name: 'collections', fromJson: TautulliUtilities.ensureStringListFromJson)
  final List<String?>? collections;

  @JsonKey(name: 'full_title', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? fullTitle;

  @JsonKey(
      name: 'children_count', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? childrenCount;

  @JsonKey(name: 'live', fromJson: TautulliUtilities.ensureBooleanFromJson)
  final bool? live;

  @JsonKey(
      name: 'media_info',
      toJson: _mediaInfoToJson,
      fromJson: _mediaInfoFromJson)
  final List<TautulliMediaInfo>? mediaInfo;

  TautulliMetadata({
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
    this.parentGuid,
    this.grandparentGuid,
    this.directors,
    this.actors,
    this.writers,
    this.genres,
    this.labels,
    this.collections,
    this.fullTitle,
    this.childrenCount,
    this.live,
    this.mediaInfo,
  });

  @override
  String toString() => json.encode(this.toJson());

  factory TautulliMetadata.fromJson(Map<String, dynamic> json) =>
      _$TautulliMetadataFromJson(json);

  Map<String, dynamic> toJson() => _$TautulliMetadataToJson(this);

  static List<TautulliMediaInfo> _mediaInfoFromJson(List<dynamic> mediaInfo) =>
      mediaInfo
          .map((info) =>
              TautulliMediaInfo.fromJson((info as Map<String, dynamic>)))
          .toList();
  static List<Map<String, dynamic>>? _mediaInfoToJson(
          List<TautulliMediaInfo>? mediaInfo) =>
      mediaInfo?.map((info) => info.toJson()).toList();
}
