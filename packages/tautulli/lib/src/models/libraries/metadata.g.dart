// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'metadata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TautulliMetadata _$TautulliMetadataFromJson(Map<String, dynamic> json) {
  return TautulliMetadata(
    mediaType:
        TautulliUtilities.mediaTypeFromJson(json['media_type'] as String?),
    sectionId: TautulliUtilities.ensureIntegerFromJson(json['section_id']),
    libraryName: TautulliUtilities.ensureStringFromJson(json['library_name']),
    ratingKey: TautulliUtilities.ensureIntegerFromJson(json['rating_key']),
    parentRatingKey:
        TautulliUtilities.ensureIntegerFromJson(json['parent_rating_key']),
    grandparentRatingKey:
        TautulliUtilities.ensureIntegerFromJson(json['grandparent_rating_key']),
    title: TautulliUtilities.ensureStringFromJson(json['title']),
    parentTitle: TautulliUtilities.ensureStringFromJson(json['parent_title']),
    grandparentTitle:
        TautulliUtilities.ensureStringFromJson(json['grandparent_title']),
    originalTitle:
        TautulliUtilities.ensureStringFromJson(json['original_title']),
    sortTitle: TautulliUtilities.ensureStringFromJson(json['sort_title']),
    mediaIndex: TautulliUtilities.ensureIntegerFromJson(json['media_index']),
    parentMediaIndex:
        TautulliUtilities.ensureIntegerFromJson(json['parent_media_index']),
    studio: TautulliUtilities.ensureStringFromJson(json['studio']),
    contentRating:
        TautulliUtilities.ensureStringFromJson(json['content_rating']),
    summary: TautulliUtilities.ensureStringFromJson(json['summary']),
    tagline: TautulliUtilities.ensureStringFromJson(json['tagline']),
    rating: TautulliUtilities.ensureDoubleFromJson(json['rating']),
    ratingImage: TautulliUtilities.ensureStringFromJson(json['rating_image']),
    audienceRating:
        TautulliUtilities.ensureDoubleFromJson(json['audience_rating']),
    audienceRatingImage:
        TautulliUtilities.ensureStringFromJson(json['audience_rating_image']),
    userRating: TautulliUtilities.ensureDoubleFromJson(json['user_rating']),
    duration: TautulliUtilities.millisecondsDurationFromJson(json['duration']),
    year: TautulliUtilities.ensureIntegerFromJson(json['year']),
    thumb: TautulliUtilities.ensureStringFromJson(json['thumb']),
    parentThumb: TautulliUtilities.ensureStringFromJson(json['parent_thumb']),
    grandparentThumb:
        TautulliUtilities.ensureStringFromJson(json['grandparent_thumb']),
    art: TautulliUtilities.ensureStringFromJson(json['art']),
    banner: TautulliUtilities.ensureStringFromJson(json['banner']),
    originallyAvailableAt:
        TautulliUtilities.ensureStringFromJson(json['originally_available_at']),
    addedAt: TautulliUtilities.millisecondsDateTimeFromJson(json['added_at']),
    updatedAt:
        TautulliUtilities.millisecondsDateTimeFromJson(json['updated_at']),
    lastViewedAt:
        TautulliUtilities.millisecondsDateTimeFromJson(json['last_viewed_at']),
    guid: TautulliUtilities.ensureStringFromJson(json['guid']),
    parentGuid: TautulliUtilities.ensureStringFromJson(json['parent_guid']),
    grandparentGuid:
        TautulliUtilities.ensureStringFromJson(json['grandparent_guid']),
    directors: TautulliUtilities.ensureStringListFromJson(json['directors']),
    actors: TautulliUtilities.ensureStringListFromJson(json['actors']),
    writers: TautulliUtilities.ensureStringListFromJson(json['writers']),
    genres: TautulliUtilities.ensureStringListFromJson(json['genres']),
    labels: TautulliUtilities.ensureStringListFromJson(json['labels']),
    collections:
        TautulliUtilities.ensureStringListFromJson(json['collections']),
    fullTitle: TautulliUtilities.ensureStringFromJson(json['full_title']),
    childrenCount:
        TautulliUtilities.ensureIntegerFromJson(json['children_count']),
    live: TautulliUtilities.ensureBooleanFromJson(json['live']),
    mediaInfo: TautulliMetadata._mediaInfoFromJson(json['media_info'] as List),
  );
}

Map<String, dynamic> _$TautulliMetadataToJson(TautulliMetadata instance) =>
    <String, dynamic>{
      'media_type': TautulliUtilities.mediaTypeToJson(instance.mediaType),
      'section_id': instance.sectionId,
      'library_name': instance.libraryName,
      'rating_key': instance.ratingKey,
      'parent_rating_key': instance.parentRatingKey,
      'grandparent_rating_key': instance.grandparentRatingKey,
      'title': instance.title,
      'parent_title': instance.parentTitle,
      'grandparent_title': instance.grandparentTitle,
      'original_title': instance.originalTitle,
      'sort_title': instance.sortTitle,
      'media_index': instance.mediaIndex,
      'parent_media_index': instance.parentMediaIndex,
      'studio': instance.studio,
      'content_rating': instance.contentRating,
      'summary': instance.summary,
      'tagline': instance.tagline,
      'rating': instance.rating,
      'rating_image': instance.ratingImage,
      'audience_rating': instance.audienceRating,
      'audience_rating_image': instance.audienceRatingImage,
      'user_rating': instance.userRating,
      'duration': instance.duration?.inMicroseconds,
      'year': instance.year,
      'thumb': instance.thumb,
      'parent_thumb': instance.parentThumb,
      'grandparent_thumb': instance.grandparentThumb,
      'art': instance.art,
      'banner': instance.banner,
      'originally_available_at': instance.originallyAvailableAt,
      'added_at': instance.addedAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'last_viewed_at': instance.lastViewedAt?.toIso8601String(),
      'guid': instance.guid,
      'parent_guid': instance.parentGuid,
      'grandparent_guid': instance.grandparentGuid,
      'directors': instance.directors,
      'writers': instance.writers,
      'actors': instance.actors,
      'genres': instance.genres,
      'labels': instance.labels,
      'collections': instance.collections,
      'full_title': instance.fullTitle,
      'children_count': instance.childrenCount,
      'live': instance.live,
      'media_info': TautulliMetadata._mediaInfoToJson(instance.mediaInfo),
    };
