part of sonarr_commands;

/// Facilitates, encapsulates, and manages individual calls related to series lookup within Sonarr.
///
/// [SonarrControllerSeriesLookup] internally handles routing the HTTP client to the API calls.
class SonarrControllerSeriesLookup {
  final Dio _client;

  /// Create a series command handler using an initialized [Dio] client.
  SonarrControllerSeriesLookup(this._client);

  /// Handler for [series/lookup](https://github.com/Sonarr/Sonarr/wiki/Series-Lookup#get).
  ///
  /// Searches for new shows on TheTVDB.com utilizing sonarr.tv's caching and augmentation proxy.
  ///
  /// Required Parameters:
  /// - `term`: Term/words to search for
  Future<List<SonarrSeries>> get({
    required String term,
  }) async =>
      _commandGetSeriesLookup(_client, term: term);
}
