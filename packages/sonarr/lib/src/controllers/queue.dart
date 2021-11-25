part of sonarr_commands;

/// Facilitates, encapsulates, and manages individual calls related to queue within Sonarr.
///
/// [SonarrController_Queue] internally handles routing the HTTP client to the API calls.
class SonarrController_Queue {
  final Dio _client;

  /// Create a series command handler using an initialized [Dio] client.
  SonarrController_Queue(this._client);

  /// Handler for [queue](https://github.com/Sonarr/Sonarr/wiki/Queue#get).
  ///
  /// Gets currently downloading (queue) information.
  Future<SonarrQueue> get({
    bool? includeUnknownSeriesItems,
    bool? includeSeries,
    bool? includeEpisode,
  }) async =>
      _commandGetQueue(
        _client,
        includeUnknownSeriesItems: includeUnknownSeriesItems,
        includeEpisode: includeEpisode,
        includeSeries: includeSeries,
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
  Future<void> deleteRecord({
    required int id,
    bool? blacklist,
  }) async =>
      _commandDeleteQueue(_client, id: id, blacklist: blacklist);
}
