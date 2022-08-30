part of radarr_commands;

/// Facilitates, encapsulates, and manages individual calls related to movie lookups within Radarr.
///
/// [RadarrCommandHandlerMovieLookup] internally handles routing the HTTP client to the API calls.
class RadarrCommandHandlerMovieLookup {
  final Dio _client;

  /// Create a command handler using an initialized [Dio] client.
  RadarrCommandHandlerMovieLookup(this._client);

  /// Handler for [movie/lookup](https://radarr.video/docs/api/#/Movie/get-movie-lookup).
  ///
  /// Search for a movie to add to the database.
  ///
  /// Required Parameters:
  /// - `term`: Term to search for
  Future<List<RadarrMovie>> get({required String term}) async =>
      _commandGetMovieLookup(_client, term: term);
}
