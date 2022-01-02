import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:lunasea/modules/sonarr.dart';

part 'queue.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class SonarrQueue {
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
  List<SonarrQueueRecord>? records;

  SonarrQueue({
    this.page,
    this.pageSize,
    this.sortKey,
    this.sortDirection,
    this.totalRecords,
    this.records,
  });

  @override
  String toString() => json.encode(this.toJson());

  factory SonarrQueue.fromJson(Map<String, dynamic> json) =>
      _$SonarrQueueFromJson(json);

  Map<String, dynamic> toJson() => _$SonarrQueueToJson(this);
}
