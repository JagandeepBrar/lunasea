import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'queue_status_message.g.dart';

@JsonSerializable(explicitToJson: true)
class SonarrQueueStatusMessage {
    @JsonKey(name: 'title')
    String? title;

    @JsonKey(name: 'messages')
    List<String>? messages;

    SonarrQueueStatusMessage({
        this.title,
        this.messages,
    });

    /// Returns a JSON-encoded string version of this object.
    @override
    String toString() => json.encode(this.toJson());

    /// Deserialize a JSON map to a [SonarrQueueStatusMessage] object.
    factory SonarrQueueStatusMessage.fromJson(Map<String, dynamic> json) => _$SonarrQueueStatusMessageFromJson(json);
    /// Serialize a [SonarrQueueStatusMessage] object to a JSON map.
    Map<String, dynamic> toJson() => _$SonarrQueueStatusMessageToJson(this);
}
