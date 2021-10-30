part of sonarr_commands;

/// Facilitates, encapsulates, and manages individual calls related to history within Sonarr.
///
/// [SonarrCommandHandler_History] internally handles routing the HTTP client to the API calls.
class SonarrCommandHandler_History {
  final Dio _client;

  /// Create a series command handler using an initialized [Dio] client.
  SonarrCommandHandler_History(this._client);

  /// Handler for [history](https://github.com/Sonarr/Sonarr/wiki/History#get).
  ///
  /// Gets history (grabs/failures/completed).
  ///
  /// Optional Parameters:
  /// - `page`: The page of history to fetch (Default: 1)
  /// - `pageSize`: The amount of items per page to fetch
  /// - `sortKey`: [SonarrHistorySortKey] object containing the sorting key
  /// - `sortDirection`: [SonarrSortDirection] object containing the sorting direction
  /// - `episodeId`: The episode ID to filter results for
  /// - `downloadId`: The download ID to filter results for
  Future<SonarrHistory> get({
    int? page,
    int? pageSize,
    SonarrHistorySortKey? sortKey,
    SonarrSortDirection? sortDirection,
    int? episodeId,
    String? downloadId,
    bool? includeSeries,
    bool? includeEpisode,
  }) async =>
      _commandGetHistory(
        _client,
        sortKey: sortKey,
        page: page,
        pageSize: pageSize,
        sortDirection: sortDirection,
        episodeId: episodeId,
        downloadId: downloadId,
        includeEpisode: includeEpisode,
        includeSeries: includeSeries,
      );

  Future<List<SonarrHistoryRecord>> getBySeries({
    required int seriesId,
    int? seasonNumber,
  }) async =>
      _commandGetHistoryBySeries(
        _client,
        seriesId: seriesId,
        seasonNumber: seasonNumber,
      );
}
