part of readarr_commands;

/// Facilitates, encapsulates, and manages individual calls related to commands within Readarr.
///
/// [ReadarrControllerCommand] internally handles routing the HTTP client to the API calls.
class ReadarrControllerCommand {
  final Dio _client;

  /// Create a series command handler using an initialized [Dio] client.
  ReadarrControllerCommand(this._client);

  /// Handler for [command (Backup)](https://github.com/Readarr/Readarr/wiki/Command#backup).
  ///
  /// Instruct Readarr to perform a backup of its database and config file (nzbdrone.db and config.xml).
  Future<ReadarrCommand> backup() async => _commandBackup(_client);

  /// Handler for [command (AuthorSearch)](https://github.com/Readarr/Readarr/wiki/Command#episodesearch).
  ///
  /// Search for an author.
  ///
  /// Required Parameters:
  /// - `authorId`: Author ID to search for
  Future<ReadarrCommand> authorSearch({
    required int authorId,
  }) async =>
      _commandAuthorSearch(_client, authorId: authorId);

  /// Handler for [command (EpisodeSearch)](https://github.com/Readarr/Readarr/wiki/Command#episodesearch).
  ///
  /// Search for one or more episodes.
  ///
  /// Required Parameters:
  /// - `bookIds`: List of episode identifiers to search for
  Future<ReadarrCommand> bookSearch({
    required List<int> bookIds,
  }) async =>
      _commandBookSearch(_client, bookIds: bookIds);

  /// Handler for [command](https://github.com/Readarr/Readarr/wiki/Command#get).
  ///
  /// Queries the status of a previously started command, or all currently started commands.
  Future<List<ReadarrCommand>> queue() async => _commandCommandQueue(_client);

  /// Handler for [command (MissingEpisodeSearch)](https://github.com/Readarr/Readarr/wiki/Command#missingepisodesearch).
  ///
  /// Instruct Readarr to perform a backlog search of missing episodes (Similar functionality to Sickbeard).
  Future<ReadarrCommand> missingBooksSearch() async =>
      _commandMissingBooksSearch(_client);

  /// Handler for [command (RefreshMonitoredDownloads)](https://github.com/Readarr/Readarr/wiki/Command).
  ///
  /// Refresh the actively monitored downloads in the queue.
  Future<ReadarrCommand> refreshMonitoredDownloads() async =>
      _commandRefreshMonitoredDownloads(_client);

  /// Handler for [command (RefreshSeries)](https://github.com/Readarr/Readarr/wiki/Command#refreshseries).
  ///
  /// Refresh series information from trakt and rescan disk.
  /// If no `authorId` is supplied, all series are refreshed.
  ///
  /// Optional Parameters:
  /// - `authorId`: Series ID for the series to refresh
  Future<ReadarrCommand> refreshAuthor({
    int? authorId,
  }) async =>
      _commandRefreshAuthor(_client, authorId: authorId);

  /// Handler for [command (RefreshBook)](https://github.com/Readarr/Readarr/wiki/Command#refreshseries).
  ///
  /// Refresh book information from trakt and rescan disk.
  /// If no `bookId` is supplied, all series are refreshed.
  ///
  /// Optional Parameters:
  /// - `authorId`: Series ID for the series to refresh
  Future<ReadarrCommand> refreshBook({
    int? bookId,
  }) async =>
      _commandRefreshBook(_client, bookId: bookId);

  /// Handler for [command (RescanSeries)](https://github.com/Readarr/Readarr/wiki/Command#rescanseries).
  ///
  /// Refresh rescan disk for a single series.
  /// If no `authorId` is supplied, all series are rescanned.
  ///
  /// Optional Parameters:
  /// - `authorId`: Series ID for the series to refresh
  Future<ReadarrCommand> rescanAuthor({
    int? authorId,
  }) async =>
      _commandRescanSeries(_client, authorId: authorId);

  /// Handler for [command (RssSync)](https://github.com/Readarr/Readarr/wiki/Command#rsssync).
  ///
  /// Instruct Readarr to perform an RSS sync with all enabled indexers.
  Future<ReadarrCommand> rssSync() async => _commandRSSSync(_client);

  /// Handler for [command (EpisodeSearch)](https://github.com/Readarr/Readarr/wiki/Command#episodesearch).
  ///
  /// Search for all episodes of a particular season.
  ///
  /// Required Parameters:
  /// - `authorId`: Series identifier
  /// - `seasonNumber`: Season number to search for
  Future<ReadarrCommand> seasonSearch({
    required int authorId,
    required int seasonNumber,
  }) async =>
      _commandSeasonSearch(_client,
          authorId: authorId, seasonNumber: seasonNumber);
}
