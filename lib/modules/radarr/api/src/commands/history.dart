part of radarr_commands;

/// Facilitates, encapsulates, and manages individual calls related to a movie's extra files within Radarr.
///
/// [RadarrCommandHandlerHistory] internally handles routing the HTTP client to the API calls.
class RadarrCommandHandlerHistory {
  final Dio _client;

  /// Create a command handler using an initialized [Dio] client.
  RadarrCommandHandlerHistory(this._client);

  /// Handler for `history`.
  ///
  /// Returns a list of items in your history.
  ///
  /// Optional Parameters:
  /// - `page`: Page to return (Default: 1)
  /// - `pageSize`: Amount of history items in the page (Default: 20)
  /// - `sortDirection`: Direction to sort the history entries (Default: descending)
  /// - `sortKey`: Key used to sort the history items (Default: date)
  Future<RadarrHistory> get({
    int? page,
    int? pageSize,
    RadarrSortDirection? sortDirection,
    RadarrHistorySortKey? sortKey,
  }) async =>
      _commandGetHistory(_client,
          page: page,
          pageSize: pageSize,
          sortDirection: sortDirection,
          sortKey: sortKey);

  /// Handler for `history/movie/{id}`.
  ///
  /// Returns a list of hitory entries for a single movie.
  ///
  /// Required Parameters:
  /// - `movieId`: Movie identifier
  Future<List<RadarrHistoryRecord>> getForMovie({required int movieId}) async =>
      _commandGetMovieHistory(_client, movieId: movieId);
}
