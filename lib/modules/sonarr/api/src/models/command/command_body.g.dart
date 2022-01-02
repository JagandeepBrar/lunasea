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

Map<String, dynamic> _$SonarrCommandBodyToJson(SonarrCommandBody instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('seriesId', instance.seriesId);
  writeNotNull('isNewSeries', instance.isNewSeries);
  writeNotNull('type', instance.type);
  writeNotNull('sendUpdatesToClient', instance.sendUpdatesToClient);
  writeNotNull('updateScheduledTask', instance.updateScheduledTask);
  writeNotNull('completionMessage', instance.completionMessage);
  writeNotNull('requiresDiskAccess', instance.requiresDiskAccess);
  writeNotNull('isExclusive', instance.isExclusive);
  writeNotNull('name', instance.name);
  writeNotNull('trigger', instance.trigger);
  writeNotNull('suppressMessages', instance.suppressMessages);
  return val;
}
