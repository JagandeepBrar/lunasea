// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'release.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RadarrRelease _$RadarrReleaseFromJson(Map<String, dynamic> json) {
  return RadarrRelease(
    guid: json['guid'] as String?,
    quality: json['quality'] == null
        ? null
        : RadarrMovieFileQuality.fromJson(
            json['quality'] as Map<String, dynamic>),
    customFormats: (json['customFormats'] as List<dynamic>?)
        ?.map((e) => RadarrCustomFormat.fromJson(e as Map<String, dynamic>))
        .toList(),
    customFormatScore: json['customFormatScore'] as int?,
    qualityWeight: json['qualityWeight'] as int?,
    age: json['age'] as int?,
    ageHours: (json['ageHours'] as num?)?.toDouble(),
    ageMinutes: (json['ageMinutes'] as num?)?.toDouble(),
    size: json['size'] as int?,
    indexerId: json['indexerId'] as int?,
    indexer: json['indexer'] as String?,
    releaseGroup: json['releaseGroup'] as String?,
    releaseHash: json['releaseHash'] as String?,
    title: json['title'] as String?,
    sceneSource: json['sceneSource'] as bool?,
    movieTitle: json['movieTitle'] as String?,
    languages: (json['languages'] as List<dynamic>?)
        ?.map((e) => RadarrLanguage.fromJson(e as Map<String, dynamic>))
        .toList(),
    approved: json['approved'] as bool?,
    temporarilyRejected: json['temporarilyRejected'] as bool?,
    rejected: json['rejected'] as bool?,
    imdbId: json['imdbId'] as int?,
    rejections: (json['rejections'] as List<dynamic>?)
        ?.map((e) => e as String)
        .toList(),
    publishDate:
        RadarrUtilities.dateTimeFromJson(json['publishDate'] as String?),
    commentUrl: json['commentUrl'] as String?,
    downloadUrl: json['downloadUrl'] as String?,
    infoUrl: json['infoUrl'] as String?,
    downloadAllowed: json['downloadAllowed'] as bool?,
    releaseWeight: json['releaseWeight'] as int?,
    edition: json['edition'] as String?,
    seeders: json['seeders'] as int?,
    leechers: json['leechers'] as int?,
    protocol: RadarrUtilities.protocolFromJson(json['protocol'] as String?),
  );
}

Map<String, dynamic> _$RadarrReleaseToJson(RadarrRelease instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('guid', instance.guid);
  writeNotNull('quality', instance.quality?.toJson());
  writeNotNull(
      'customFormats', instance.customFormats?.map((e) => e.toJson()).toList());
  writeNotNull('customFormatScore', instance.customFormatScore);
  writeNotNull('qualityWeight', instance.qualityWeight);
  writeNotNull('age', instance.age);
  writeNotNull('ageHours', instance.ageHours);
  writeNotNull('ageMinutes', instance.ageMinutes);
  writeNotNull('size', instance.size);
  writeNotNull('indexerId', instance.indexerId);
  writeNotNull('indexer', instance.indexer);
  writeNotNull('releaseGroup', instance.releaseGroup);
  writeNotNull('releaseHash', instance.releaseHash);
  writeNotNull('title', instance.title);
  writeNotNull('sceneSource', instance.sceneSource);
  writeNotNull('movieTitle', instance.movieTitle);
  writeNotNull(
      'languages', instance.languages?.map((e) => e.toJson()).toList());
  writeNotNull('approved', instance.approved);
  writeNotNull('temporarilyRejected', instance.temporarilyRejected);
  writeNotNull('rejected', instance.rejected);
  writeNotNull('imdbId', instance.imdbId);
  writeNotNull('rejections', instance.rejections);
  writeNotNull(
      'publishDate', RadarrUtilities.dateTimeToJson(instance.publishDate));
  writeNotNull('commentUrl', instance.commentUrl);
  writeNotNull('downloadUrl', instance.downloadUrl);
  writeNotNull('infoUrl', instance.infoUrl);
  writeNotNull('downloadAllowed', instance.downloadAllowed);
  writeNotNull('releaseWeight', instance.releaseWeight);
  writeNotNull('edition', instance.edition);
  writeNotNull('seeders', instance.seeders);
  writeNotNull('leechers', instance.leechers);
  writeNotNull('protocol', RadarrUtilities.protocolToJson(instance.protocol));
  return val;
}
