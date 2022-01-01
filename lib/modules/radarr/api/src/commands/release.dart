part of radarr_commands;

/// Facilitates, encapsulates, and manages individual calls related to releases within Radarr.
///
/// [RadarrCommandHandlerRelease] internally handles routing the HTTP client to the API calls.
class RadarrCommandHandlerRelease {
  final Dio _client;

  /// Create a command handler using an initialized [Dio] client.
  RadarrCommandHandlerRelease(this._client);

  /// Handler for `release/{id}`.
  ///
  /// Returns a list of releases for a movie.
  ///
  /// Required Parameters:
  /// - `movieId`: Movie identifier for the movie to search for
  Future<List<RadarrRelease>> get({required int movieId}) async =>
      _commandGetReleases(_client, movieId: movieId);

  /// Handler for `release/${id}`.
  ///
  /// Push a new release to the download clients.
  ///
  /// Required Parameters:
  /// - `guid`: GUID of the release
  /// - `indexerId`: Indexer ID of the release
  Future<void> push({required String guid, required int indexerId}) async =>
      _commandPushRelease(_client, indexerId: indexerId, guid: guid);
}
