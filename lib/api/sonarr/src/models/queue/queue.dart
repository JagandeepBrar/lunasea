import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:lunasea/modules/sonarr.dart';

part 'queue.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class SonarrQueuePage {
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

  SonarrQueuePage({
    this.page,
    this.pageSize,
    this.sortKey,
    this.sortDirection,
    this.totalRecords,
    this.records,
  });

  @override
  String toString() => json.encode(this.toJson());

  factory SonarrQueuePage.fromJson(Map<String, dynamic> json) =>
      _$SonarrQueuePageFromJson(json);

  Map<String, dynamic> toJson() => _$SonarrQueuePageToJson(this);
}
