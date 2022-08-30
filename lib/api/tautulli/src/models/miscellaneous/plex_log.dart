import 'dart:convert';

/// Model to store a Plex Media Server or Plex Media Scanner log.
class TautulliPlexLog {
  /// The log level.
  final String? level;

  /// The date and time of the log.
  final String? timestamp;

  /// The log message.
  final String? message;

  TautulliPlexLog({
    this.timestamp,
    this.level,
    this.message,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toArray());

  /// Deserialize a JSON map to a [TautulliPlexLog] object.
  factory TautulliPlexLog.fromArray(List<dynamic> data) =>
      TautulliPlexLog(timestamp: data[0], level: data[1], message: data[2]);

  /// Serialize a [TautulliPlexLog] object to a JSON map.
  List<dynamic> toArray() => [timestamp, level, message];
}
