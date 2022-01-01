// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RadarrMovie _$RadarrMovieFromJson(Map<String, dynamic> json) {
  return RadarrMovie(
    title: json['title'] as String?,
    originalTitle: json['originalTitle'] as String?,
    alternateTitles: (json['alternateTitles'] as List<dynamic>?)
        ?.map((e) =>
            RadarrMovieAlternateTitles.fromJson(e as Map<String, dynamic>))
        .toList(),
    secondaryYearSourceId: json['secondaryYearSourceId'] as int?,
    sortTitle: json['sortTitle'] as String?,
    sizeOnDisk: json['sizeOnDisk'] as int?,
    status: RadarrUtilities.availabilityFromJson(json['status'] as String?),
    overview: json['overview'] as String?,
    inCinemas: RadarrUtilities.dateTimeFromJson(json['inCinemas'] as String?),
    physicalRelease:
        RadarrUtilities.dateTimeFromJson(json['physicalRelease'] as String?),
    digitalRelease:
        RadarrUtilities.dateTimeFromJson(json['digitalRelease'] as String?),
    images: (json['images'] as List<dynamic>?)
        ?.map((e) => RadarrImage.fromJson(e as Map<String, dynamic>))
        .toList(),
    website: json['website'] as String?,
    remotePoster: json['remotePoster'] as String?,
    year: json['year'] as int?,
    hasFile: json['hasFile'] as bool?,
    youTubeTrailerId: json['youTubeTrailerId'] as String?,
    studio: json['studio'] as String?,
    path: json['path'] as String?,
    qualityProfileId: json['qualityProfileId'] as int?,
    monitored: json['monitored'] as bool?,
    minimumAvailability: RadarrUtilities.availabilityFromJson(
        json['minimumAvailability'] as String?),
    isAvailable: json['isAvailable'] as bool?,
    folderName: json['folderName'] as String?,
    runtime: json['runtime'] as int?,
    cleanTitle: json['cleanTitle'] as String?,
    imdbId: json['imdbId'] as String?,
    tmdbId: json['tmdbId'] as int?,
    titleSlug: json['titleSlug'] as String?,
    certification: json['certification'] as String?,
    genres:
        (json['genres'] as List<dynamic>?)?.map((e) => e as String).toList(),
    tags: (json['tags'] as List<dynamic>?)?.map((e) => e as int?).toList(),
    added: RadarrUtilities.dateTimeFromJson(json['added'] as String?),
    ratings: json['ratings'] == null
        ? null
        : RadarrMovieRating.fromJson(json['ratings'] as Map<String, dynamic>),
    movieFile: json['movieFile'] == null
        ? null
        : RadarrMovieFile.fromJson(json['movieFile'] as Map<String, dynamic>),
    collection: json['collection'] == null
        ? null
        : RadarrMovieCollection.fromJson(
            json['collection'] as Map<String, dynamic>),
    id: json['id'] as int?,
  );
}

Map<String, dynamic> _$RadarrMovieToJson(RadarrMovie instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('title', instance.title);
  writeNotNull('originalTitle', instance.originalTitle);
  writeNotNull('alternateTitles',
      instance.alternateTitles?.map((e) => e.toJson()).toList());
  writeNotNull('secondaryYearSourceId', instance.secondaryYearSourceId);
  writeNotNull('sortTitle', instance.sortTitle);
  writeNotNull('sizeOnDisk', instance.sizeOnDisk);
  writeNotNull('status', RadarrUtilities.availabilityToJson(instance.status));
  writeNotNull('overview', instance.overview);
  writeNotNull('inCinemas', RadarrUtilities.dateTimeToJson(instance.inCinemas));
  writeNotNull('physicalRelease',
      RadarrUtilities.dateTimeToJson(instance.physicalRelease));
  writeNotNull('digitalRelease',
      RadarrUtilities.dateTimeToJson(instance.digitalRelease));
  writeNotNull('images', instance.images?.map((e) => e.toJson()).toList());
  writeNotNull('website', instance.website);
  writeNotNull('remotePoster', instance.remotePoster);
  writeNotNull('year', instance.year);
  writeNotNull('hasFile', instance.hasFile);
  writeNotNull('youTubeTrailerId', instance.youTubeTrailerId);
  writeNotNull('studio', instance.studio);
  writeNotNull('path', instance.path);
  writeNotNull('qualityProfileId', instance.qualityProfileId);
  writeNotNull('monitored', instance.monitored);
  writeNotNull('minimumAvailability',
      RadarrUtilities.availabilityToJson(instance.minimumAvailability));
  writeNotNull('isAvailable', instance.isAvailable);
  writeNotNull('folderName', instance.folderName);
  writeNotNull('runtime', instance.runtime);
  writeNotNull('cleanTitle', instance.cleanTitle);
  writeNotNull('imdbId', instance.imdbId);
  writeNotNull('tmdbId', instance.tmdbId);
  writeNotNull('titleSlug', instance.titleSlug);
  writeNotNull('certification', instance.certification);
  writeNotNull('genres', instance.genres);
  writeNotNull('tags', instance.tags);
  writeNotNull('added', RadarrUtilities.dateTimeToJson(instance.added));
  writeNotNull('ratings', instance.ratings?.toJson());
  writeNotNull('movieFile', instance.movieFile?.toJson());
  writeNotNull('collection', instance.collection?.toJson());
  writeNotNull('id', instance.id);
  return val;
}
