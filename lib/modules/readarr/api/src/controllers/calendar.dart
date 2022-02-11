part of readarr_commands;

/// Facilitates, encapsulates, and manages individual calls related to calendar within Readarr.
///
/// [ReadarrControllerCalendar] internally handles routing the HTTP client to the API calls.
class ReadarrControllerCalendar {
  final Dio _client;

  /// Create a series command handler using an initialized [Dio] client.
  ReadarrControllerCalendar(this._client);

  /// Handler for [calendar](https://github.com/Readarr/Readarr/wiki/Calendar#get).
  ///
  /// Gets upcoming episodes.
  /// If start/end are not supplied episodes airing today and tomorrow will be returned.
  Future<List<ReadarrBook>> get({
    DateTime? start,
    DateTime? end,
    bool? unmonitored,
    bool? includeSeries,
    bool? includeEpisodeFile,
    bool? includeEpisodeImages,
  }) async =>
      _commandGetCalendar(
        _client,
        start: start,
        end: end,
        unmonitored: unmonitored,
        includeAuthor: includeSeries,
        includeEpisodeFile: includeEpisodeFile,
        includeBookImages: includeEpisodeImages,
      );
}
