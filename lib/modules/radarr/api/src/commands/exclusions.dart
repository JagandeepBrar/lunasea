part of radarr_commands;

/// Facilitates, encapsulates, and manages individual calls related to exclusions within Radarr.
/// 
/// [RadarrCommandHandler_Exclusions] internally handles routing the HTTP client to the API calls.
class RadarrCommandHandler_Exclusions {
    final Dio _client;

    /// Create a command handler using an initialized [Dio] client.
    RadarrCommandHandler_Exclusions(this._client);

    /// Handler for `exclusions/{id}`.
    /// 
    /// Returns a details about a single exclusion rule.
    /// 
    /// Required Parameters:
    /// - `exclusionId`: Identifier for the exclusion rule
    Future<RadarrExclusion> get({
        required int exclusionId,
    }) async => _commandGetExclusions(_client, exclusionId: exclusionId);


    /// Handler for `exclusions`.
    /// 
    /// Returns a list of excluded movies.
    Future<List<RadarrExclusion>> getAll() async => _commandGetAllExclusions(_client);
}
