import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:lunasea/modules/tautulli.dart';

part 'graph_data.g.dart';

/// Model to store graph data from Tautulli.
///
/// Graph data includes the category, and a list of "series". A series ([]) contains the title (name) and an array of data.
/// The array of data matches in position to the category.
@JsonSerializable(explicitToJson: true)
class TautulliGraphData {
  /// The category header for the series.
  @JsonKey(
      name: 'categories', fromJson: TautulliUtilities.ensureStringListFromJson)
  final List<String?>? categories;

  /// List of [TautulliSeriesData], each storing a series for the graph data.
  @JsonKey(name: 'series', toJson: _seriesToJson, fromJson: _seriesFromJson)
  final List<TautulliSeriesData>? series;

  TautulliGraphData({
    this.categories,
    this.series,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [TautulliGraphData] object.
  factory TautulliGraphData.fromJson(Map<String, dynamic> json) =>
      _$TautulliGraphDataFromJson(json);

  /// Serialize a [TautulliGraphData] to a JSON map.
  Map<String, dynamic> toJson() => _$TautulliGraphDataToJson(this);

  static List<TautulliSeriesData> _seriesFromJson(List<dynamic> series) =>
      series
          .map((entry) =>
              TautulliSeriesData.fromJson((entry as Map<String, dynamic>)))
          .toList();
  static List<Map<String, dynamic>>? _seriesToJson(
          List<TautulliSeriesData>? series) =>
      series?.map((entry) => entry.toJson()).toList();
}
