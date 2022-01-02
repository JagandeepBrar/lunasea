import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

part 'notification_logs.g.dart';

/// Model to store notification logs from Tautulli.
///
/// Each individual notification log is stored in `logs`, with each log being a [TautulliNotificationLogRecord].
@JsonSerializable(explicitToJson: true)
class TautulliNotificationLogs {
  /// Number of filtered records returned.
  @JsonKey(
      name: 'recordsFiltered',
      fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? recordsFiltered;

  /// Total amount of records.
  @JsonKey(
      name: 'recordsTotal', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? recordsTotal;

  /// _Unknown_
  @JsonKey(name: 'draw', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? draw;

  /// The individual notification logs.
  @JsonKey(name: 'data', toJson: _logsToJson, fromJson: _logsFromJson)
  final List<TautulliNotificationLogRecord>? logs;

  TautulliNotificationLogs({
    this.recordsFiltered,
    this.recordsTotal,
    this.draw,
    this.logs,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [TautulliNotificationLogs] object.
  factory TautulliNotificationLogs.fromJson(Map<String, dynamic> json) =>
      _$TautulliNotificationLogsFromJson(json);

  /// Serialize a [TautulliNotificationLogs] object to a JSON map.
  Map<String, dynamic> toJson() => _$TautulliNotificationLogsToJson(this);

  static List<TautulliNotificationLogRecord> _logsFromJson(
          List<dynamic> logs) =>
      logs
          .map((log) => TautulliNotificationLogRecord.fromJson(
              (log as Map<String, dynamic>)))
          .toList();
  static List<Map<String, dynamic>>? _logsToJson(
          List<TautulliNotificationLogRecord>? logs) =>
      logs?.map((log) => log.toJson()).toList();
}
