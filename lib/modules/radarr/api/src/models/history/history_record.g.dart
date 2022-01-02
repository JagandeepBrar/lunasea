// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RadarrHistoryRecord _$RadarrHistoryRecordFromJson(Map<String, dynamic> json) {
  return RadarrHistoryRecord(
    movieId: json['movieId'] as int?,
    sourceTitle: json['sourceTitle'] as String?,
    languages: (json['languages'] as List<dynamic>?)
        ?.map((e) => RadarrLanguage.fromJson(e as Map<String, dynamic>))
        .toList(),
    quality: json['quality'] == null
        ? null
        : RadarrMovieFileQuality.fromJson(
            json['quality'] as Map<String, dynamic>),
    customFormats: (json['customFormats'] as List<dynamic>?)
        ?.map((e) => RadarrCustomFormat.fromJson(e as Map<String, dynamic>))
        .toList(),
    qualityCutoffNotMet: json['qualityCutoffNotMet'] as bool?,
    date: RadarrUtilities.dateTimeFromJson(json['date'] as String?),
    downloadId: json['downloadId'] as String?,
    eventType: RadarrUtilities.eventTypeFromJson(json['eventType'] as String?),
    data: json['data'] as Map<String, dynamic>?,
    id: json['id'] as int?,
  );
}

Map<String, dynamic> _$RadarrHistoryRecordToJson(RadarrHistoryRecord instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('movieId', instance.movieId);
  writeNotNull('sourceTitle', instance.sourceTitle);
  writeNotNull(
      'languages', instance.languages?.map((e) => e.toJson()).toList());
  writeNotNull('quality', instance.quality?.toJson());
  writeNotNull(
      'customFormats', instance.customFormats?.map((e) => e.toJson()).toList());
  writeNotNull('qualityCutoffNotMet', instance.qualityCutoffNotMet);
  writeNotNull('date', RadarrUtilities.dateTimeToJson(instance.date));
  writeNotNull('downloadId', instance.downloadId);
  writeNotNull(
      'eventType', RadarrUtilities.eventTypeToJson(instance.eventType));
  writeNotNull('data', instance.data);
  writeNotNull('id', instance.id);
  return val;
}
