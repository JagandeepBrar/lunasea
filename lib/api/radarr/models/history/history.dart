import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:lunasea/api/radarr/types.dart';
import 'package:lunasea/api/radarr/utilities.dart';
import 'package:lunasea/api/radarr/models.dart';

part 'history.g.dart';

/// Model for history content from Radarr.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class RadarrHistory {
  @JsonKey(name: 'page')
  int? page;

  @JsonKey(name: 'pageSize')
  int? pageSize;

  @JsonKey(
      name: 'sortKey',
      toJson: RadarrUtilities.historySortKeyToJson,
      fromJson: RadarrUtilities.historySortKeyFromJson)
  RadarrHistorySortKey? sortKey;

  @JsonKey(
      name: 'sortDirection',
      toJson: RadarrUtilities.sortDirectionToJson,
      fromJson: RadarrUtilities.sortDirectionFromJson)
  RadarrSortDirection? sortDirection;

  @JsonKey(name: 'totalRecords')
  int? totalRecords;

  @JsonKey(name: 'records')
  List<RadarrHistoryRecord>? records;

  RadarrHistory({
    this.page,
    this.pageSize,
    this.sortKey,
    this.sortDirection,
    this.totalRecords,
    this.records,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [RadarrHistory] object.
  factory RadarrHistory.fromJson(Map<String, dynamic> json) =>
      _$RadarrHistoryFromJson(json);

  /// Serialize a [RadarrHistory] object to a JSON map.
  Map<String, dynamic> toJson() => _$RadarrHistoryToJson(this);
}
