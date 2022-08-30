import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

part 'log.g.dart';

/// Model to store a Tautulli log record.
@JsonSerializable(explicitToJson: true)
class TautulliLog {
  /// The log level.
  @JsonKey(name: 'loglevel', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? level;

  /// The date and time of the log.
  @JsonKey(name: 'time', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? timestamp;

  /// The log message.
  @JsonKey(name: 'msg', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? message;

  /// The thread the log was recorded on.
  @JsonKey(name: 'thread', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? thread;

  TautulliLog({
    this.timestamp,
    this.level,
    this.message,
    this.thread,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [TautulliLog] object.
  factory TautulliLog.fromJson(Map<String, dynamic> json) =>
      _$TautulliLogFromJson(json);

  /// Serialize a [TautulliLog] object to a JSON map.
  Map<String, dynamic> toJson() => _$TautulliLogToJson(this);
}
