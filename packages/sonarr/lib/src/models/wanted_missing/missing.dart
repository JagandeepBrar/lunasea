import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:sonarr/models.dart';
import 'package:sonarr/types.dart';
import 'package:sonarr/utilities.dart';

part 'missing.g.dart';

/// Model for missing episode records from Sonarr.
@JsonSerializable(explicitToJson: true)
class SonarrMissing {
    /// Page of the list of missing episodes
    @JsonKey(name: 'page')
    int? page;

    /// Amount of records returned on this page
    @JsonKey(name: 'pageSize')
    int? pageSize;

    /// Key used to sort the results
    @JsonKey(name: 'sortKey', toJson: SonarrUtilities.wantedMissingSortKeyToJson, fromJson: SonarrUtilities.wantedMissingSortKeyFromJson)
    SonarrWantedMissingSortKey? sortKey;

    /// Direction that the results were sorted
    @JsonKey(name: 'sortDirection')
    String? sortDirection;

    /// Total amount of records available
    @JsonKey(name: 'totalRecords')
    int? totalRecords;

    /// Missing episode records, each being an [SonarrMissingRecord] object.
    @JsonKey(name: 'records')
    List<SonarrMissingRecord>? records;

    SonarrMissing({
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

    /// Deserialize a JSON map to a [SonarrMissing] object.
    factory SonarrMissing.fromJson(Map<String, dynamic> json) => _$SonarrMissingFromJson(json);
    /// Serialize a [SonarrMissing] object to a JSON map.
    Map<String, dynamic> toJson() => _$SonarrMissingToJson(this);
}
