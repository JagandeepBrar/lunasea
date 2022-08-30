import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:lunasea/modules/tautulli.dart';

part 'series_data.g.dart';

/// Model to store an individual series data for graph data from Tautulli.
@JsonSerializable(explicitToJson: true)
class TautulliSeriesData {
  /// Name of the series.
  @JsonKey(name: 'name', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? name;

  /// The data of the series.
  @JsonKey(name: 'data', fromJson: TautulliUtilities.ensureIntegerListFromJson)
  final List<int?>? data;

  TautulliSeriesData({
    this.name,
    this.data,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [TautulliSeriesData] object.
  factory TautulliSeriesData.fromJson(Map<String, dynamic> json) =>
      _$TautulliSeriesDataFromJson(json);

  /// Serialize a [TautulliSeriesData] to a JSON map.
  Map<String, dynamic> toJson() => _$TautulliSeriesDataToJson(this);
}
