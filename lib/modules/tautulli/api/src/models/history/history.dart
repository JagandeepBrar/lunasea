import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:lunasea/modules/tautulli.dart';

part 'history.g.dart';

/// Model for history data from Tautulli.
///
/// Each individual session history is stored in `records`, with each history record being a [TautulliHistoryRecord].
@JsonSerializable(explicitToJson: true)
class TautulliHistory {
  /// List of [TautulliHistoryRecord], each storing a single session history.
  @JsonKey(name: 'data', fromJson: _entriesFromJson, toJson: _entriesToJson)
  final List<TautulliHistoryRecord>? records;

  /// _Unknown_
  @JsonKey(name: 'draw', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? draw;

  /// Total amount of records.
  @JsonKey(
      name: 'recordsTotal', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? recordsTotal;

  /// The amount of records (filtered).
  @JsonKey(
      name: 'recordsFiltered',
      fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? recordsFiltered;

  /// The duration of the records (total) retrieved, as a preformatted string.
  @JsonKey(
      name: 'total_duration', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? totalDuration;

  /// The duration of the records (filtered) retrieved, as a preformatted string.
  @JsonKey(
      name: 'filter_duration', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? filterDuration;

  TautulliHistory({
    this.records,
    this.draw,
    this.recordsTotal,
    this.recordsFiltered,
    this.totalDuration,
    this.filterDuration,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [TautulliHistory] object.
  factory TautulliHistory.fromJson(Map<String, dynamic> json) =>
      _$TautulliHistoryFromJson(json);

  /// Serialize a [TautulliHistory] to a JSON map.
  Map<String, dynamic> toJson() => _$TautulliHistoryToJson(this);

  static List<TautulliHistoryRecord> _entriesFromJson(List<dynamic> entries) =>
      entries
          .map((entry) =>
              TautulliHistoryRecord.fromJson((entry as Map<String, dynamic>)))
          .toList();
  static List<Map<String, dynamic>>? _entriesToJson(
          List<TautulliHistoryRecord>? entries) =>
      entries?.map((entry) => entry.toJson()).toList();
}
