// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'graph_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TautulliGraphData _$TautulliGraphDataFromJson(Map<String, dynamic> json) {
  return TautulliGraphData(
    categories: TautulliUtilities.ensureStringListFromJson(json['categories']),
    series: TautulliGraphData._seriesFromJson(json['series'] as List),
  );
}

Map<String, dynamic> _$TautulliGraphDataToJson(TautulliGraphData instance) =>
    <String, dynamic>{
      'categories': instance.categories,
      'series': TautulliGraphData._seriesToJson(instance.series),
    };
