// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'command_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SonarrCommandBody _$SonarrCommandBodyFromJson(Map<String, dynamic> json) =>
    SonarrCommandBody(
      seriesId: json['seriesId'] as int?,
      isNewSeries: json['isNewSeries'] as bool?,
      sendUpdatesToClient: json['sendUpdatesToClient'] as bool?,
      updateScheduledTask: json['updateScheduledTask'] as bool?,
      completionMessage: json['completionMessage'] as String?,
      requiresDiskAccess: json['requiresDiskAccess'] as bool?,
      isExclusive: json['isExclusive'] as bool?,
      name: json['name'] as String?,
      trigger: json['trigger'] as String?,
      suppressMessages: json['suppressMessages'] as bool?,
    )..type = json['type'] as String?;

Map<String, dynamic> _$SonarrCommandBodyToJson(SonarrCommandBody instance) =>
    <String, dynamic>{
      'seriesId': instance.seriesId,
      'isNewSeries': instance.isNewSeries,
      'type': instance.type,
      'sendUpdatesToClient': instance.sendUpdatesToClient,
      'updateScheduledTask': instance.updateScheduledTask,
      'completionMessage': instance.completionMessage,
      'requiresDiskAccess': instance.requiresDiskAccess,
      'isExclusive': instance.isExclusive,
      'name': instance.name,
      'trigger': instance.trigger,
      'suppressMessages': instance.suppressMessages,
    };
