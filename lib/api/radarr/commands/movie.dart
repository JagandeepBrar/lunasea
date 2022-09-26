part of radarr_commands;

/// Facilitates, encapsulates, and manages individual calls related to movies within Radarr.
///
/// [RadarrCommandHandlerMovie] internally handles routing the HTTP client to the API calls.
class RadarrCommandHandlerMovie {
  final Dio _client;

  /// Create a command handler using an initialized [Dio] client.
  RadarrCommandHandlerMovie(this._client);

  /// Handler for [movie](https://radarr.video/docs/api/#/Movie/getMovie).
  ///
  /// Returns all movies stored in the database.
  Future<List<RadarrMovie>> getAll() async => _commandGetAllMovies(_client);

  /// Handler for [movie/{id}](https://radarr.video/docs/api/#/Movie/getMovieById).
  ///
  /// Returns a single movie.
  ///
  /// Required Parameters:
  /// - `movieId`: Movie identifier
  Future<RadarrMovie> get({required int movieId}) async =>
      _commandGetMovie(_client, movieId: movieId);

  /// Handler for [movie](https://radarr.video/docs/api/#/Movie/put_movie).
  ///
  /// Updates a movie.
  ///
  /// Required Parameters:
  /// - `movie`: [RadarrMovie] object with the updated information
  Future<RadarrMovie> update({
    required RadarrMovie movie,
    bool moveFiles = false,
  }) async =>
      _commandUpdateMovie(
        _client,
        movie: movie,
        moveFiles: moveFiles,
      );

  /// Handler for [movie/{id}](https://radarr.video/docs/api/#/Movie/deleteMovie).
  ///
  /// Delete a single movie.
  ///
  /// Required Parameters:
  /// - `movieId`: Movie identifier in Radarr
  ///
  /// Optional Parameters:
  /// - `addImportExclusion`: If true, adds the movie to Radarr's exclusion list for import lists
  /// - `deleteFiles`: If true, deletes all files as well
  Future<void> delete({
    required int movieId,
    bool addImportExclusion = false,
    bool deleteFiles = false,
  }) =>
      _commandDeleteMovie(_client,
          movieId: movieId,
          addImportExclusion: addImportExclusion,
          deleteFiles: deleteFiles);

  /// Handler for [movie](https://radarr.video/docs/api/#/Movie/post_movie).
  ///
  /// Adds a new movie.
  ///
  /// Required Parameters:
  /// - `movie`: [RadarrMovie] object, usually fetched using movie lookup
  /// - `rootFolder`: [RadarrRootFolder] for the root folder to use for the movie
  /// - `monitored`: Should the movie be added as monitored?
  /// - `minimumAvailability`: [RadarrAvailability] for the movie
  /// - `qualityProfile`: [RadarrQualityProfile] for the movie
  ///
  /// Optional Parameters:
  /// - `tags`: List of [RadarrTag]s to be assigned to the movie
  /// - `searchForMovie` Should a search for the movie be started after being added?
  Future<RadarrMovie> create({
    required RadarrMovie movie,
    required RadarrRootFolder rootFolder,
    required bool monitored,
    required RadarrAvailability minimumAvailability,
    required RadarrQualityProfile qualityProfile,
    List<RadarrTag>? tags,
    bool searchForMovie = false,
  }) async =>
      _commandAddMovie(
        _client,
        movie: movie,
        rootFolder: rootFolder,
        monitored: monitored,
        minimumAvailability: minimumAvailability,
        qualityProfile: qualityProfile,
        tags: tags,
        searchForMovie: searchForMovie,
      );
}
