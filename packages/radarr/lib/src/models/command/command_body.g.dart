// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'command_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RadarrCommandBody _$RadarrCommandBodyFromJson(Map<String, dynamic> json) {
  return RadarrCommandBody(
    type: json['type'] as String?,
    sendUpdatesToClient: json['sendUpdatesToClient'] as bool?,
    updateScheduledTask: json['updateScheduledTask'] as bool?,
    completionMessage: json['completionMessage'] as String?,
    requiresDiskAccess: json['requiresDiskAccess'] as bool?,
    isExclusive: json['isExclusive'] as bool?,
    isTypeExclusive: json['isTypeExclusive'] as bool?,
    name: json['name'] as String?,
    trigger: json['trigger'] as String?,
    suppressMessages: json['suppressMessages'] as bool?,
  );
}

Map<String, dynamic> _$RadarrCommandBodyToJson(RadarrCommandBody instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('type', instance.type);
  writeNotNull('sendUpdatesToClient', instance.sendUpdatesToClient);
  writeNotNull('updateScheduledTask', instance.updateScheduledTask);
  writeNotNull('completionMessage', instance.completionMessage);
  writeNotNull('requiresDiskAccess', instance.requiresDiskAccess);
  writeNotNull('isExclusive', instance.isExclusive);
  writeNotNull('isTypeExclusive', instance.isTypeExclusive);
  writeNotNull('name', instance.name);
  writeNotNull('trigger', instance.trigger);
  writeNotNull('suppressMessages', instance.suppressMessages);
  return val;
}
