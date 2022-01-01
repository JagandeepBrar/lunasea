import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

part 'search.g.dart';

/// Model to store search results of your Plex Media Server library.
///
@JsonSerializable(explicitToJson: true)
class TautulliSearch {
  /// Total amount of returned results.
  @JsonKey(
      name: 'results_count', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? count;

  @JsonKey(
      name: 'results_list', toJson: _resultsToJson, fromJson: _resultsFromJson)
  final TautulliSearchResults? results;

  TautulliSearch({
    this.count,
    this.results,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [TautulliSearch] object.
  factory TautulliSearch.fromJson(Map<String, dynamic> json) =>
      _$TautulliSearchFromJson(json);

  /// Serialize a [TautulliSearch] object to a JSON map.
  Map<String, dynamic> toJson() => _$TautulliSearchToJson(this);

  static TautulliSearchResults _resultsFromJson(Map<String, dynamic> json) =>
      TautulliSearchResults.fromJson(json);
  static Map<String, dynamic>? _resultsToJson(TautulliSearchResults? results) =>
      results?.toJson();
}
