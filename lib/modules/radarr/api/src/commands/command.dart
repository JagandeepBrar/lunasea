part of radarr_commands;

/// Facilitates, encapsulates, and manages individual calls related to commands within Radarr.
///
/// [RadarrCommandHandlerCommand] internally handles routing the HTTP client to the API calls.
class RadarrCommandHandlerCommand {
  final Dio _client;

  /// Create a command handler using an initialized [Dio] client.
  RadarrCommandHandlerCommand(this._client);

  /// Handler for [command (Backup)](https://radarr.video/docs/api/#/Command/post-command).
  ///
  /// Trigger a backup routine.
  Future<RadarrCommand> backup() async => _commandBackup(_client);

  /// Handler for [command (DownloadedMoviesScan)](https://radarr.video/docs/api/#/Command/post-command).
  ///
  /// Triggers a scan at the path for downloaded movies.
  ///
  /// Required Parameters:
  /// - `path`: Full/absolute path of the host's filesystem.
  Future<RadarrCommand> downloadedMoviesScan({
    required String path,
  }) async =>
      _commandDownloadedMoviesScan(_client, path: path);

  /// Handler for [command (ManualImport)](https://radarr.video/docs/api/#/Command/post-command).
  ///
  /// Trigger the manual import of the files.
  ///
  /// Required Parameters:
  /// - `files`: List of [RadarrManualImportFile] instances each containing details on a file to import.
  /// - `importMode`: [RadarrImportMode] to describe which mode of import to use.
  Future<RadarrCommand> manualImport({
    required List<RadarrManualImportFile> files,
    required RadarrImportMode importMode,
  }) async =>
      _commandManualImport(_client, files: files, importMode: importMode);

  /// Handler for [command (MissingMoviesSearch)](https://radarr.video/docs/api/#/Command/post-command).
  ///
  /// Triggers a search of all missing movies.
  Future<RadarrCommand> missingMovieSearch() async =>
      _commandMissingMovieSearch(_client);

  /// Handler for [command (MoviesSearch)](https://radarr.video/docs/api/#/Command/post-command).
  ///
  /// Triggers a search for the given list of movies.
  ///
  /// Required Parameters:
  /// - `movieIds`: List of movie IDs to search for.
  Future<RadarrCommand> moviesSearch({
    required List<int> movieIds,
  }) async =>
      _commandMoviesSearch(_client, movieIds: movieIds);

  /// Handler for [command (RefreshMonitoredDownloads)](https://radarr.video/docs/api/#/Command/post-command).
  ///
  /// Triggers the scan of monitored downloads.
  Future<RadarrCommand> refreshMonitoredDownloads() async =>
      _commandRefreshMonitoredDownloads(_client);

  /// Handler for [command (RefreshMovie)](https://radarr.video/docs/api/#/Command/post-command).
  ///
  /// Trigger a refresh / scan of library.
  /// If no `movieIds` are supplied, all movies are refreshed.
  ///
  /// Optional Parameters:
  /// - `movieIds`: List of movie IDs for the movies in specific to refresh
  Future<RadarrCommand> refreshMovie({
    List<int>? movieIds,
  }) async =>
      _commandRefreshMovie(_client, movieIds: movieIds);

  /// Handler for [command (RssSync)](https://radarr.video/docs/api/#/Command/post-command).
  ///
  /// Trigger a RSS sync.
  Future<RadarrCommand> rssSync() async => _commandRSSSync(_client);
}
