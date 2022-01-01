// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TautulliSearch _$TautulliSearchFromJson(Map<String, dynamic> json) {
  return TautulliSearch(
    count: TautulliUtilities.ensureIntegerFromJson(json['results_count']),
    results: TautulliSearch._resultsFromJson(
        json['results_list'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$TautulliSearchToJson(TautulliSearch instance) =>
    <String, dynamic>{
      'results_count': instance.count,
      'results_list': TautulliSearch._resultsToJson(instance.results),
    };
