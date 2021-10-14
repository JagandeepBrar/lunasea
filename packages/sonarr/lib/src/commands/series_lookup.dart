part of sonarr_commands;

/// Facilitates, encapsulates, and manages individual calls related to series lookup within Sonarr.
/// 
/// [SonarrCommandHandler_SeriesLookup] internally handles routing the HTTP client to the API calls.
class SonarrCommandHandler_SeriesLookup {
    final Dio _client;

    /// Create a series command handler using an initialized [Dio] client.
    SonarrCommandHandler_SeriesLookup(this._client);

    /// Handler for [series/lookup](https://github.com/Sonarr/Sonarr/wiki/Series-Lookup#get).
    /// 
    /// Searches for new shows on TheTVDB.com utilizing sonarr.tv's caching and augmentation proxy.
    /// 
    /// Required Parameters:
    /// - `term`: Term/words to search for
    Future<List<SonarrSeriesLookup>> getSeriesLookup({
        required String term,
    }) async => _commandGetSeriesLookup(_client, term: term);
}
