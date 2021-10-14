part of radarr_commands;

/// Facilitates, encapsulates, and manages individual calls related to a movie's extra files within Radarr.
/// 
/// [RadarrCommandHandler_ExtraFile] internally handles routing the HTTP client to the API calls.
class RadarrCommandHandler_ExtraFile {
    final Dio _client;

    /// Create a command handler using an initialized [Dio] client.
    RadarrCommandHandler_ExtraFile(this._client);

    /// Handler for `extraFile/{id}`.
    /// 
    /// Returns a list of any extra files for a movie.
    /// 
    /// Required Parameters:
    /// - `movieId`: Movie identifier
    Future<List<RadarrExtraFile>> get({ required int movieId }) async => _commandGetExtraFiles(_client, movieId: movieId);
}
