// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rating.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SonarrSeriesRating _$SonarrSeriesRatingFromJson(Map<String, dynamic> json) =>
    SonarrSeriesRating(
      votes: json['votes'] as int?,
      value: (json['value'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$SonarrSeriesRatingToJson(SonarrSeriesRating instance) =>
    <String, dynamic>{
      'votes': instance.votes,
      'value': instance.value,
    };
