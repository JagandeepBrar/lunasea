import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:lunasea/api/radarr/utilities.dart';
import 'package:lunasea/api/radarr/models.dart';
import 'package:lunasea/api/radarr/types.dart';

part 'queue.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class RadarrQueue {
  @JsonKey(name: 'page')
  int? page;

  @JsonKey(name: 'pageSize')
  int? pageSize;

  @JsonKey(
      name: 'sortKey',
      toJson: RadarrUtilities.queueSortKeyToJson,
      fromJson: RadarrUtilities.queueSortKeyFromJson)
  RadarrQueueSortKey? sortKey;

  @JsonKey(
      name: 'sortDirection',
      toJson: RadarrUtilities.sortDirectionToJson,
      fromJson: RadarrUtilities.sortDirectionFromJson)
  RadarrSortDirection? sortDirection;

  @JsonKey(name: 'totalRecords')
  int? totalRecords;

  @JsonKey(name: 'records')
  List<RadarrQueueRecord>? records;

  RadarrQueue({
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

  /// Deserialize a JSON map to a [RadarrQueue] object.
  factory RadarrQueue.fromJson(Map<String, dynamic> json) =>
      _$RadarrQueueFromJson(json);

  /// Serialize a [RadarrQueue] object to a JSON map.
  Map<String, dynamic> toJson() => _$RadarrQueueToJson(this);
}
