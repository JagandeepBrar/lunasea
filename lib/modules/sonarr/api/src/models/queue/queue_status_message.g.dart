// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'queue_status_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SonarrQueueStatusMessage _$SonarrQueueStatusMessageFromJson(
        Map<String, dynamic> json) =>
    SonarrQueueStatusMessage(
      title: json['title'] as String?,
      messages: (json['messages'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$SonarrQueueStatusMessageToJson(
    SonarrQueueStatusMessage instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('title', instance.title);
  writeNotNull('messages', instance.messages);
  return val;
}
