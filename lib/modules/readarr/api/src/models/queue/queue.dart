import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:lunasea/modules/readarr.dart';

part 'queue.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ReadarrQueue {
  @JsonKey(name: 'page')
  int? page;

  @JsonKey(name: 'pageSize')
  int? pageSize;

  @JsonKey(name: 'sortKey')
  String? sortKey;

  @JsonKey(name: 'sortDirection')
  String? sortDirection;

  @JsonKey(name: 'totalRecords')
  int? totalRecords;

  @JsonKey(name: 'records')
  List<ReadarrQueueRecord>? records;

  ReadarrQueue({
    this.page,
    this.pageSize,
    this.sortKey,
    this.sortDirection,
    this.totalRecords,
    this.records,
  });

  @override
  String toString() => json.encode(this.toJson());

  factory ReadarrQueue.fromJson(Map<String, dynamic> json) =>
      _$ReadarrQueueFromJson(json);

  Map<String, dynamic> toJson() => _$ReadarrQueueToJson(this);
}
