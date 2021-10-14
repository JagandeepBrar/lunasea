// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'queue_status_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RadarrQueueStatusMessage _$RadarrQueueStatusMessageFromJson(
    Map<String, dynamic> json) {
  return RadarrQueueStatusMessage(
    title: json['title'] as String?,
    messages:
        (json['messages'] as List<dynamic>?)?.map((e) => e as String).toList(),
  );
}

Map<String, dynamic> _$RadarrQueueStatusMessageToJson(
        RadarrQueueStatusMessage instance) =>
    <String, dynamic>{
      'title': instance.title,
      'messages': instance.messages,
    };
