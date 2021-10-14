import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:sonarr/models.dart';
import 'package:sonarr/types.dart';
import 'package:sonarr/utilities.dart';

part 'history.g.dart';

/// Model to store history records from Sonarr.
@JsonSerializable(explicitToJson: true)
class SonarrHistory {
    /// Page number
    @JsonKey(name: 'page')
    int? page;

    /// Page size
    @JsonKey(name: 'pageSize')
    int? pageSize;

    /// [SonarrHistorySortKey] object containing the sorting key
    @JsonKey(name: 'sortKey', fromJson: SonarrUtilities.historySortKeyFromJson, toJson: SonarrUtilities.historySortKeyToJson)
    SonarrHistorySortKey? sortKey;

    /// Sorting direction
    @JsonKey(name: 'sortDirection')
    String? sortDirection;

    /// Total amount of records available
    @JsonKey(name: 'totalRecords')
    int? totalRecords;

    @JsonKey(name: 'records')
    List<SonarrHistoryRecord>? records;

    SonarrHistory({
        this.page,
        this.pageSize,
        this.sortKey,
        this.sortDirection,
        this.totalRecords,
    });

    /// Returns a JSON-encoded string version of this object.
    @override
    String toString() => json.encode(this.toJson());

    /// Deserialize a JSON map to a [SonarrHistory] object.
    factory SonarrHistory.fromJson(Map<String, dynamic> json) => _$SonarrHistoryFromJson(json);
    /// Serialize a [SonarrHistory] object to a JSON map.
    Map<String, dynamic> toJson() => _$SonarrHistoryToJson(this);
}
