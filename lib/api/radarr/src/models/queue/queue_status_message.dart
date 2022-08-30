import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'queue_status_message.g.dart';

@JsonSerializable(explicitToJson: true)
class RadarrQueueStatusMessage {
  @JsonKey(name: 'title')
  String? title;

  @JsonKey(name: 'messages')
  List<String>? messages;

  RadarrQueueStatusMessage({
    this.title,
    this.messages,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [RadarrQueueStatusMessage] object.
  factory RadarrQueueStatusMessage.fromJson(Map<String, dynamic> json) =>
      _$RadarrQueueStatusMessageFromJson(json);

  /// Serialize a [RadarrQueueStatusMessage] object to a JSON map.
  Map<String, dynamic> toJson() => _$RadarrQueueStatusMessageToJson(this);
}
