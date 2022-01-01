part of sonarr_commands;

/// Facilitates, encapsulates, and manages individual calls related to releases within Sonarr.
///
/// [SonarrControllerRelease] internally handles routing the HTTP client to the API calls.
class SonarrControllerRelease {
  final Dio _client;

  /// Create a series command handler using an initialized [Dio] client.
  SonarrControllerRelease(this._client);

  /// Handler for [release](https://github.com/Sonarr/Sonarr/wiki/Release#get).
  ///
  /// Returns the a list of releases for the episode.
  Future<List<SonarrRelease>> get({
    required int episodeId,
  }) async =>
      _commandGetReleases(_client, episodeId: episodeId);

  /// Handler for [release](https://github.com/Sonarr/Sonarr/wiki/Release#get).
  ///
  /// Returns the a list of releases for the season.
  Future<List<SonarrRelease>> getSeasonPack({
    required int seriesId,
    required int seasonNumber,
  }) async =>
      _commandGetSeasonReleases(_client,
          seriesId: seriesId, seasonNumber: seasonNumber);

  /// Handler for [release](https://github.com/Sonarr/Sonarr/wiki/Release#post).
  ///
  /// Adds a previously searched release to the download client, if the release is still in Sonarr's search cache (30 minute cache).
  /// If the release is not found in the cache Sonarr will return a 404.
  Future<SonarrAddedRelease> add({
    required String guid,
    required int indexerId,
  }) async =>
      _commandAddRelease(_client, guid: guid, indexerId: indexerId);
}
