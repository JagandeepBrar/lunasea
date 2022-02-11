part of readarr_commands;

/// Facilitates, encapsulates, and manages individual calls related to queue within Readarr.
///
/// [ReadarrControllerQueue] internally handles routing the HTTP client to the API calls.
class ReadarrControllerQueue {
  final Dio _client;

  /// Create a series command handler using an initialized [Dio] client.
  ReadarrControllerQueue(this._client);

  /// Handler for [queue](https://github.com/Readarr/Readarr/wiki/Queue#get).
  ///
  /// Gets currently downloading (queue) information.
  Future<ReadarrQueue> get({
    bool? includeUnknownAuthorItems,
    bool? includeAuthor,
    bool? includeBook,
    ReadarrSortDirection? sortDirection,
    ReadarrQueueSortKey? sortKey,
    int? page,
    int? pageSize,
  }) async =>
      _commandGetQueue(
        _client,
        includeUnknownAuthorItems: includeUnknownAuthorItems,
        includeBook: includeBook,
        includeAuthor: includeAuthor,
        sortDirection: sortDirection,
        sortKey: sortKey,
        page: page,
        pageSize: pageSize,
      );

  /// Handler for [queue/details](https://github.com/Readarr/Readarr/wiki/Queue#get).
  ///
  /// Gets currently downloading (queue) information.
  Future<List<ReadarrQueueRecord>> getDetails({
    int? authorId,
    List<int>? bookIds,
    bool? includeAuthor,
    bool? includeBook,
  }) async =>
      _commandGetQueueDetails(
        _client,
        authorId: authorId,
        bookIds: bookIds,
        includeAuthor: includeAuthor,
        includeBook: includeBook,
      );

  /// Handler for [queue](https://github.com/Readarr/Readarr/wiki/Queue#delete).
  ///
  /// Deletes an item from the queue and download client..
  Future<void> delete({
    required int id,
    bool? removeFromClient,
    bool? blocklist,
  }) async =>
      _commandDeleteQueue(
        _client,
        id: id,
        blocklist: blocklist,
        removeFromClient: removeFromClient,
      );
}
