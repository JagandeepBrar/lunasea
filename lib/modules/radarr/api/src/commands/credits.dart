part of radarr_commands;

/// Facilitates, encapsulates, and manages individual calls related to movie credits within Radarr.
/// 
/// [RadarrCommandHandler_Credits] internally handles routing the HTTP client to the API calls.
class RadarrCommandHandler_Credits {
    final Dio _client;

    /// Create a command handler using an initialized [Dio] client.
    RadarrCommandHandler_Credits(this._client);


    /// Handler for `credit/{id}`.
    /// 
    /// Returns the cast and crew who have worked on a movie.
    /// 
    /// Required Parameters:
    /// - `movieId`: Movie identifier
    Future<List<RadarrMovieCredits>> get({ required int movieId }) async => _commandGetCredits(_client, movieId: movieId);
}
