import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'queue_status_message.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ReadarrQueueStatusMessage {
  @JsonKey(name: 'title')
  String? title;

  @JsonKey(name: 'messages')
  List<String>? messages;

  ReadarrQueueStatusMessage({
    this.title,
    this.messages,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [ReadarrQueueStatusMessage] object.
  factory ReadarrQueueStatusMessage.fromJson(Map<String, dynamic> json) =>
      _$ReadarrQueueStatusMessageFromJson(json);

  /// Serialize a [ReadarrQueueStatusMessage] object to a JSON map.
  Map<String, dynamic> toJson() => _$ReadarrQueueStatusMessageToJson(this);
}
