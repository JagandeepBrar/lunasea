part of sonarr_commands;

/// Facilitates, encapsulates, and manages individual calls related to wanted/missing episodes within Sonarr.
/// 
/// [SonarrCommandHandler_Wanted] internally handles routing the HTTP client to the API calls.
class SonarrCommandHandler_Wanted {
    final Dio _client;

    /// Create a series command handler using an initialized [Dio] client.
    SonarrCommandHandler_Wanted(this._client);

    /// Handler for [wanted/missing](https://github.com/Sonarr/Sonarr/wiki/Wanted-Missing#get).
    /// 
    /// Returns a list of missing episode (episodes without files).
    /// 
    /// Optional Parameters:
    /// - `sortDir`: Sorting direction of the results
    /// - `sortKey`: The key used for sorting the results
    /// - `page`: Page of results to fetch
    /// - `pageSize`: Size of the page to fetch
    Future<SonarrMissing> getMissing({
        SonarrSortDirection? sortDir,
        SonarrWantedMissingSortKey? sortKey,
        int? page,
        int? pageSize,
    }) async => _commandGetMissing(_client, sortDir: sortDir, sortKey: sortKey, page: page, pageSize: pageSize);
}
