import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

part 'newsletter_logs.g.dart';

/// Model to store newsletter logs from Tautulli.
///
/// Each individual newsletter log is stored in `logs`, with each log being a [TautulliNewsletterLogRecord].
@JsonSerializable(explicitToJson: true)
class TautulliNewsletterLogs {
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

  /// The individual newsletter logs.
  @JsonKey(name: 'data', toJson: _logsToJson, fromJson: _logsFromJson)
  final List<TautulliNewsletterLogRecord>? logs;

  TautulliNewsletterLogs({
    this.recordsFiltered,
    this.recordsTotal,
    this.draw,
    this.logs,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [TautulliNewsletterLogs] object.
  factory TautulliNewsletterLogs.fromJson(Map<String, dynamic> json) =>
      _$TautulliNewsletterLogsFromJson(json);

  /// Serialize a [TautulliNewsletterLogs] object to a JSON map.
  Map<String, dynamic> toJson() => _$TautulliNewsletterLogsToJson(this);

  static List<TautulliNewsletterLogRecord> _logsFromJson(
          List<dynamic> logs) =>
      logs
          .map((log) => TautulliNewsletterLogRecord.fromJson(
              (log as Map<String, dynamic>)))
          .toList();
  static List<Map<String, dynamic>>? _logsToJson(
          List<TautulliNewsletterLogRecord>? logs) =>
      logs?.map((log) => log.toJson()).toList();
}
