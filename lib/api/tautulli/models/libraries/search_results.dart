import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:lunasea/api/tautulli/models/libraries/search_result.dart';

part 'search_results.g.dart';

/// Model to store search result lists from your Plex Media Server library.
@JsonSerializable(explicitToJson: true)
class TautulliSearchResults {
  /// List of album results.
  @JsonKey(name: 'album', toJson: _resultsToJson, fromJson: _resultsFromJson)
  final List<TautulliSearchResult>? albums;

  /// List of artist results.
  @JsonKey(name: 'artist', toJson: _resultsToJson, fromJson: _resultsFromJson)
  final List<TautulliSearchResult>? artists;

  /// List of collection results.
  @JsonKey(
      name: 'collection', toJson: _resultsToJson, fromJson: _resultsFromJson)
  final List<TautulliSearchResult>? collections;

  /// List of episode results.
  @JsonKey(name: 'episode', toJson: _resultsToJson, fromJson: _resultsFromJson)
  final List<TautulliSearchResult>? episodes;

  /// List of movie results.
  @JsonKey(name: 'movie', toJson: _resultsToJson, fromJson: _resultsFromJson)
  final List<TautulliSearchResult>? movies;

  /// List of season results.
  @JsonKey(name: 'season', toJson: _resultsToJson, fromJson: _resultsFromJson)
  final List<TautulliSearchResult>? seasons;

  /// List of show results.
  @JsonKey(name: 'show', toJson: _resultsToJson, fromJson: _resultsFromJson)
  final List<TautulliSearchResult>? shows;

  /// List of track results.
  @JsonKey(name: 'track', toJson: _resultsToJson, fromJson: _resultsFromJson)
  final List<TautulliSearchResult>? tracks;

  TautulliSearchResults({
    this.albums,
    this.artists,
    this.collections,
    this.episodes,
    this.movies,
    this.seasons,
    this.shows,
    this.tracks,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [TautulliSearchResults] object.
  factory TautulliSearchResults.fromJson(Map<String, dynamic> json) =>
      _$TautulliSearchResultsFromJson(json);

  /// Serialize a [TautulliSearchResults] object to a JSON map.
  Map<String, dynamic> toJson() => _$TautulliSearchResultsToJson(this);

  static List<TautulliSearchResult> _resultsFromJson(List<dynamic> results) =>
      results
          .map((result) =>
              TautulliSearchResult.fromJson((result as Map<String, dynamic>)))
          .toList();
  static List<Map<String, dynamic>?>? _resultsToJson(
          List<TautulliSearchResult>? results) =>
      results?.map((result) => result.toJson()).toList();
}
