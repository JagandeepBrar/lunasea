part of readarr_commands;

/// Facilitates, encapsulates, and manages individual calls related to history within Readarr.
///
/// [ReadarrControllerHistory] internally handles routing the HTTP client to the API calls.
class ReadarrControllerHistory {
  final Dio _client;

  /// Create a series command handler using an initialized [Dio] client.
  ReadarrControllerHistory(this._client);

  /// Handler for [history](https://github.com/Readarr/Readarr/wiki/History#get).
  ///
  /// Gets history (grabs/failures/completed).
  ///
  /// Optional Parameters:
  /// - `page`: The page of history to fetch (Default: 1)
  /// - `pageSize`: The amount of items per page to fetch
  /// - `sortKey`: [ReadarrHistorySortKey] object containing the sorting key
  /// - `sortDirection`: [ReadarrSortDirection] object containing the sorting direction
  /// - `bookId`: The episode ID to filter results for
  /// - `downloadId`: The download ID to filter results for
  Future<ReadarrHistory> get({
    int? page,
    int? pageSize,
    ReadarrHistorySortKey? sortKey,
    ReadarrSortDirection? sortDirection,
    int? bookId,
    String? downloadId,
    bool? includeAuthor,
    bool? includeBook,
  }) async =>
      _commandGetHistory(
        _client,
        sortKey: sortKey,
        page: page,
        pageSize: pageSize,
        sortDirection: sortDirection,
        bookId: bookId,
        downloadId: downloadId,
        includeBook: includeBook,
        includeAuthor: includeAuthor,
      );

  Future<List<ReadarrHistoryRecord>> getByAuthor({
    required int authorId,
    int? bookId,
    bool? includeAuthor,
    bool? includeBook,
  }) async =>
      _commandGetHistoryByAuthor(
        _client,
        authorId: authorId,
        bookId: bookId,
        includeBook: includeBook,
        includeAuthor: includeAuthor,
      );
}
