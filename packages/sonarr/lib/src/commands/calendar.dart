part of sonarr_commands;

/// Facilitates, encapsulates, and manages individual calls related to calendar within Sonarr.
///
/// [SonarrCommandHandler_Calendar] internally handles routing the HTTP client to the API calls.
class SonarrCommandHandler_Calendar {
  final Dio _client;

  /// Create a series command handler using an initialized [Dio] client.
  SonarrCommandHandler_Calendar(this._client);

  /// Handler for [calendar](https://github.com/Sonarr/Sonarr/wiki/Calendar#get).
  ///
  /// Gets upcoming episodes.
  /// If start/end are not supplied episodes airing today and tomorrow will be returned.
  ///
  /// Optional Parameters:
  /// - `start`: [DateTime] object for the start date
  /// - `end`: [DateTime] object for the end date
  /// - `includeSeries`: [bool] Include the series details?
  /// - `includeEpisodeFile`: [bool] Include the episode file details?
  /// - `includeEpisodeImages`: [bool] Include the episode images?
  Future<List<SonarrCalendar>> get({
    DateTime? start,
    DateTime? end,
    bool? includeSeries,
    bool? includeEpisodeFile,
    bool? includeEpisodeImages,
  }) async =>
      _commandGetCalendar(
        _client,
        start: start,
        end: end,
        includeSeries: includeSeries,
        includeEpisodeFile: includeEpisodeFile,
        includeEpisodeImages: includeEpisodeImages,
      );
}
