// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_results.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TautulliSearchResults _$TautulliSearchResultsFromJson(
    Map<String, dynamic> json) {
  return TautulliSearchResults(
    albums: TautulliSearchResults._resultsFromJson(json['album'] as List),
    artists: TautulliSearchResults._resultsFromJson(json['artist'] as List),
    collections:
        TautulliSearchResults._resultsFromJson(json['collection'] as List),
    episodes: TautulliSearchResults._resultsFromJson(json['episode'] as List),
    movies: TautulliSearchResults._resultsFromJson(json['movie'] as List),
    seasons: TautulliSearchResults._resultsFromJson(json['season'] as List),
    shows: TautulliSearchResults._resultsFromJson(json['show'] as List),
    tracks: TautulliSearchResults._resultsFromJson(json['track'] as List),
  );
}

Map<String, dynamic> _$TautulliSearchResultsToJson(
        TautulliSearchResults instance) =>
    <String, dynamic>{
      'album': TautulliSearchResults._resultsToJson(instance.albums),
      'artist': TautulliSearchResults._resultsToJson(instance.artists),
      'collection': TautulliSearchResults._resultsToJson(instance.collections),
      'episode': TautulliSearchResults._resultsToJson(instance.episodes),
      'movie': TautulliSearchResults._resultsToJson(instance.movies),
      'season': TautulliSearchResults._resultsToJson(instance.seasons),
      'show': TautulliSearchResults._resultsToJson(instance.shows),
      'track': TautulliSearchResults._resultsToJson(instance.tracks),
    };
