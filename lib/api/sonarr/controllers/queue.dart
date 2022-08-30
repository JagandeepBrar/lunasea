part of sonarr_commands;

/// Facilitates, encapsulates, and manages individual calls related to queue within Sonarr.
///
/// [SonarrControllerQueue] internally handles routing the HTTP client to the API calls.
class SonarrControllerQueue {
  final Dio _client;

  /// Create a series command handler using an initialized [Dio] client.
  SonarrControllerQueue(this._client);

  /// Handler for [queue](https://github.com/Sonarr/Sonarr/wiki/Queue#get).
  ///
  /// Gets currently downloading (queue) information.
  Future<SonarrQueuePage> get({
    bool? includeUnknownSeriesItems,
    bool? includeSeries,
    bool? includeEpisode,
    SonarrSortDirection? sortDirection,
    SonarrQueueSortKey? sortKey,
    int? page,
    int? pageSize,
  }) async =>
      _commandGetQueue(
        _client,
        includeUnknownSeriesItems: includeUnknownSeriesItems,
        includeEpisode: includeEpisode,
        includeSeries: includeSeries,
        sortDirection: sortDirection,
        sortKey: sortKey,
        page: page,
        pageSize: pageSize,
      );

  /// Handler for [queue/details](https://github.com/Sonarr/Sonarr/wiki/Queue#get).
  ///
  /// Gets currently downloading (queue) information.
  Future<List<SonarrQueueRecord>> getDetails({
    int? seriesId,
    List<int>? episodeIds,
    bool? includeSeries,
    bool? includeEpisode,
  }) async =>
      _commandGetQueueDetails(
        _client,
        seriesId: seriesId,
        episodeIds: episodeIds,
        includeSeries: includeSeries,
        includeEpisode: includeEpisode,
      );

  /// Handler for [queue](https://github.com/Sonarr/Sonarr/wiki/Queue#delete).
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
