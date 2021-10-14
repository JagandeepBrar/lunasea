part of radarr_commands;

/// Facilitates, encapsulates, and manages individual calls related to movie files within Radarr.
/// 
/// [RadarrCommandHandler_MovieFile] internally handles routing the HTTP client to the API calls.
class RadarrCommandHandler_MovieFile {
    final Dio _client;

    /// Create a command handler using an initialized [Dio] client.
    RadarrCommandHandler_MovieFile(this._client);

    /// Handler for `moviefile/{id}`.
    /// 
    /// Returns a list of movie files for a movie.
    /// 
    /// Required Parameters:
    /// - `movieId`: Movie identifier
    Future<List<RadarrMovieFile>> get({ required int movieId }) async => _commandGetMovieFile(_client, movieId: movieId);

    /// Handler for [moviefile/${id}](https://radarr.video/docs/api/#/MovieFile/delete-moviefile-id).
    /// 
    /// Delete a movie by its ID in the database.
    /// 
    /// Required Parameters:
    /// - `movieFileId`: Movie file identifier
    Future<void> delete({ required int movieFileId }) async => _commandDeleteMovieFile(_client, movieFileId: movieFileId);
}
