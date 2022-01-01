// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'date_format.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TautulliDateFormat _$TautulliDateFormatFromJson(Map<String, dynamic> json) {
  return TautulliDateFormat(
    dateFormat: TautulliUtilities.ensureStringFromJson(json['date_format']),
    timeFormat: TautulliUtilities.ensureStringFromJson(json['time_format']),
  );
}

Map<String, dynamic> _$TautulliDateFormatToJson(TautulliDateFormat instance) =>
    <String, dynamic>{
      'date_format': instance.dateFormat,
      'time_format': instance.timeFormat,
    };
