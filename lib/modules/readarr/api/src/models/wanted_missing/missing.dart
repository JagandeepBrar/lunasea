import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:lunasea/modules/readarr.dart';

part 'missing.g.dart';

/// Model for missing episode records from Readarr.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ReadarrMissing {
  /// Page of the list of missing episodes
  @JsonKey(name: 'page')
  int? page;

  /// Amount of records returned on this page
  @JsonKey(name: 'pageSize')
  int? pageSize;

  /// Key used to sort the results
  @JsonKey(
      name: 'sortKey',
      toJson: ReadarrUtilities.wantedMissingSortKeyToJson,
      fromJson: ReadarrUtilities.wantedMissingSortKeyFromJson)
  ReadarrWantedMissingSortKey? sortKey;

  /// Direction that the results were sorted
  @JsonKey(name: 'sortDirection')
  String? sortDirection;

  /// Total amount of records available
  @JsonKey(name: 'totalRecords')
  int? totalRecords;

  /// Missing episode records, each being an [ReadarrMissingRecord] object.
  @JsonKey(name: 'records')
  List<ReadarrBook>? records;

  ReadarrMissing({
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

  /// Deserialize a JSON map to a [ReadarrMissing] object.
  factory ReadarrMissing.fromJson(Map<String, dynamic> json) =>
      _$ReadarrMissingFromJson(json);

  /// Serialize a [ReadarrMissing] object to a JSON map.
  Map<String, dynamic> toJson() => _$ReadarrMissingToJson(this);
}
