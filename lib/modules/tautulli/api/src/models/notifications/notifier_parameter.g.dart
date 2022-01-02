// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifier_parameter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TautulliNotifierParameter _$TautulliNotifierParameterFromJson(
    Map<String, dynamic> json) {
  return TautulliNotifierParameter(
    name: TautulliUtilities.ensureStringFromJson(json['name']),
    type: TautulliUtilities.ensureStringFromJson(json['type']),
    value: TautulliUtilities.ensureStringFromJson(json['value']),
  );
}

Map<String, dynamic> _$TautulliNotifierParameterToJson(
        TautulliNotifierParameter instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': instance.type,
      'value': instance.value,
    };
