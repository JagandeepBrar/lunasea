part of sonarr_commands;

/// Facilitates, encapsulates, and manages individual calls related to releases within Sonarr.
///
/// [SonarrCommandHandler_Release] internally handles routing the HTTP client to the API calls.
class SonarrCommandHandler_Release {
  final Dio _client;

  /// Create a series command handler using an initialized [Dio] client.
  SonarrCommandHandler_Release(this._client);

  /// Handler for [release](https://github.com/Sonarr/Sonarr/wiki/Release#get).
  ///
  /// Returns the a list of releases for the episode.
  ///
  /// Required Parameters:
  /// - `episodeId`: Episode ID for the episode to find releases for
  Future<List<SonarrRelease>> getReleases({
    required int episodeId,
  }) async =>
      _commandGetReleases(_client, episodeId: episodeId);

  /// Handler for [release](https://github.com/Sonarr/Sonarr/wiki/Release#get).
  ///
  /// Returns the a list of releases for the season.
  ///
  /// Required Parameters:
  /// - `seriesId`: Series ID for season searching
  /// - `seasonNumber`: Season number to search for
  Future<List<SonarrRelease>> getSeasonReleases({
    required int seriesId,
    required int seasonNumber,
  }) async =>
      _commandGetSeasonReleases(_client,
          seriesId: seriesId, seasonNumber: seasonNumber);

  /// Handler for [release](https://github.com/Sonarr/Sonarr/wiki/Release#post).
  ///
  /// Adds a previously searched release to the download client, if the release is still in Sonarr's search cache (30 minute cache).
  /// If the release is not found in the cache Sonarr will return a 404.
  ///
  /// > **`useVersion3` is required to push season releases.**
  ///
  /// Required Parameters:
  /// - `guid`: Release GUID
  /// - `indexerId`: Indentifier for the indexer
  Future<SonarrAddedRelease> addRelease({
    required String guid,
    required int indexerId,
  }) async =>
      _commandAddRelease(_client, guid: guid, indexerId: indexerId);
}
