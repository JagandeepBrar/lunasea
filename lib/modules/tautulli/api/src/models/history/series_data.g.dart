// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'series_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TautulliSeriesData _$TautulliSeriesDataFromJson(Map<String, dynamic> json) {
  return TautulliSeriesData(
    name: TautulliUtilities.ensureStringFromJson(json['name']),
    data: TautulliUtilities.ensureIntegerListFromJson(json['data']),
  );
}

Map<String, dynamic> _$TautulliSeriesDataToJson(TautulliSeriesData instance) =>
    <String, dynamic>{
      'name': instance.name,
      'data': instance.data,
    };
