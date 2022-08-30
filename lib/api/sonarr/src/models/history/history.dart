import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:lunasea/modules/sonarr.dart';

part 'history.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class SonarrHistoryPage {
  @JsonKey(name: 'page')
  int? page;

  @JsonKey(name: 'pageSize')
  int? pageSize;

  @JsonKey(
    name: 'sortKey',
    fromJson: SonarrUtilities.historySortKeyFromJson,
    toJson: SonarrUtilities.historySortKeyToJson,
  )
  SonarrHistorySortKey? sortKey;

  @JsonKey(name: 'sortDirection')
  String? sortDirection;

  @JsonKey(name: 'totalRecords')
  int? totalRecords;

  @JsonKey(name: 'records')
  List<SonarrHistoryRecord>? records;

  SonarrHistoryPage({
    this.page,
    this.pageSize,
    this.sortKey,
    this.sortDirection,
    this.totalRecords,
  });

  @override
  String toString() => json.encode(this.toJson());

  factory SonarrHistoryPage.fromJson(Map<String, dynamic> json) =>
      _$SonarrHistoryPageFromJson(json);
  Map<String, dynamic> toJson() => _$SonarrHistoryPageToJson(this);
}
