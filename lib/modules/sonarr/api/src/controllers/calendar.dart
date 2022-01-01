part of sonarr_commands;

/// Facilitates, encapsulates, and manages individual calls related to calendar within Sonarr.
///
/// [SonarrControllerCalendar] internally handles routing the HTTP client to the API calls.
class SonarrControllerCalendar {
  final Dio _client;

  /// Create a series command handler using an initialized [Dio] client.
  SonarrControllerCalendar(this._client);

  /// Handler for [calendar](https://github.com/Sonarr/Sonarr/wiki/Calendar#get).
  ///
  /// Gets upcoming episodes.
  /// If start/end are not supplied episodes airing today and tomorrow will be returned.
  Future<List<SonarrCalendar>> get({
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
        includeSeries: includeSeries,
        includeEpisodeFile: includeEpisodeFile,
        includeEpisodeImages: includeEpisodeImages,
      );
}
