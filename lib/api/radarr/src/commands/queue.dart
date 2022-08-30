part of radarr_commands;

/// Facilitates, encapsulates, and manages individual calls related to the queue within Radarr.
///
/// [RadarrCommandHandlerQueue] internally handles routing the HTTP client to the API calls.
class RadarrCommandHandlerQueue {
  final Dio _client;

  /// Create a command handler using an initialized [Dio] client.
  RadarrCommandHandlerQueue(this._client);

  /// Handler for [queue](https://radarr.video/docs/api/#/Queue/delete-queue-id).
  ///
  /// Remove an item from the queue and optionally blacklist it.
  ///
  /// Required Parameters:
  /// - `id`: Radarr queue record identifier
  ///
  /// Optional Parameters:
  /// - `removeFromClient` Remove the release from the download client
  /// - `blacklist` Blacklist the release from being fetched again
  Future<void> delete({
    required int id,
    bool removeFromClient = false,
    bool blacklist = false,
  }) async =>
      _commandDeleteQueue(
        _client,
        id: id,
        removeFromClient: removeFromClient,
        blacklist: blacklist,
      );

  /// Handler for [queue](https://radarr.video/docs/api/#/Queue/get-queue).
  ///
  /// Return a list of items in the queue.
  ///
  /// Optional Parameters:
  /// - `page`: Page of the queue
  /// - `pageSize`: Size of the page to fetch
  /// - `sortDirection`: Sorting direction
  /// - `sortKey`: Sorting key
  /// - `includeUnknownMovieItems` Include unknown items in the queue
  Future<RadarrQueue> get({
    int page = 1,
    int pageSize = 20,
    RadarrSortDirection sortDirection = RadarrSortDirection.DESCENDING,
    RadarrQueueSortKey sortKey = RadarrQueueSortKey.PROGRESS,
    bool includeUnknownMovieItems = false,
  }) async =>
      _commandGetQueue(
        _client,
        page: page,
        pageSize: pageSize,
        sortDirection: sortDirection,
        sortKey: sortKey,
        includeUnknownMovieItems: includeUnknownMovieItems,
      );

  /// Handler for [queue/status](https://radarr.video/docs/api/#/Queue/get-queue-status).
  ///
  /// Stats on items in queue.
  Future<RadarrQueueStatus> getStatus() async =>
      _commandGetQueueStatus(_client);
}
