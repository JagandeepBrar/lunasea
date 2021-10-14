part of sonarr_commands;

/// Facilitates, encapsulates, and manages individual calls related to commands within Sonarr.
/// 
/// [SonarrCommandHandler_Command] internally handles routing the HTTP client to the API calls.
class SonarrCommandHandler_Command {
    final Dio _client;

    /// Create a series command handler using an initialized [Dio] client.
    SonarrCommandHandler_Command(this._client);

    /// Handler for [command (Backup)](https://github.com/Sonarr/Sonarr/wiki/Command#backup).
    /// 
    /// Instruct Sonarr to perform a backup of its database and config file (nzbdrone.db and config.xml).
    Future<SonarrCommand> backup() async => _commandBackup(_client);

    /// Handler for [command (EpisodeSearch)](https://github.com/Sonarr/Sonarr/wiki/Command#episodesearch).
    /// 
    /// Search for one or more episodes.
    /// 
    /// Required Parameters:
    /// - `episodeIds`: List of episode identifiers to search for
    Future<SonarrCommand> episodeSearch({
        required List<int> episodeIds,
    }) async => _commandEpisodeSearch(_client, episodeIds: episodeIds);

    /// Handler for [command](https://github.com/Sonarr/Sonarr/wiki/Command#get).
    /// 
    /// Queries the status of a previously started command, or all currently started commands.
    Future<List<SonarrCommand>> queue() async => _commandCommandQueue(_client);

    /// Handler for [command (MissingEpisodeSearch)](https://github.com/Sonarr/Sonarr/wiki/Command#missingepisodesearch).
    /// 
    /// Instruct Sonarr to perform a backlog search of missing episodes (Similar functionality to Sickbeard).
    Future<SonarrCommand> missingEpisodeSearch() async => _commandMissingEpisodeSearch(_client);

    /// Handler for [command (RefreshMonitoredDownloads)](https://github.com/Sonarr/Sonarr/wiki/Command).
    /// 
    /// Refresh the actively monitored downloads in the queue.
    Future<SonarrCommand> refreshMonitoredDownloads({
        int? seriesId,
    }) async => _commandRefreshMonitoredDownloads(_client);

    /// Handler for [command (RefreshSeries)](https://github.com/Sonarr/Sonarr/wiki/Command#refreshseries).
    /// 
    /// Refresh series information from trakt and rescan disk.
    /// If no `seriesId` is supplied, all series are refreshed.
    /// 
    /// Optional Parameters:
    /// - `seriesId`: Series ID for the series to refresh
    Future<SonarrCommand> refreshSeries({
        int? seriesId,
    }) async => _commandRefreshSeries(_client, seriesId: seriesId);

    /// Handler for [command (RescanSeries)](https://github.com/Sonarr/Sonarr/wiki/Command#rescanseries).
    /// 
    /// Refresh rescan disk for a single series.
    /// If no `seriesId` is supplied, all series are rescanned.
    /// 
    /// Optional Parameters:
    /// - `seriesId`: Series ID for the series to refresh
    Future<SonarrCommand> rescanSeries({
        int? seriesId,
    }) async => _commandRescanSeries(_client, seriesId: seriesId);

    /// Handler for [command (RssSync)](https://github.com/Sonarr/Sonarr/wiki/Command#rsssync).
    /// 
    /// Instruct Sonarr to perform an RSS sync with all enabled indexers.
    Future<SonarrCommand> rssSync() async => _commandRSSSync(_client);

    /// Handler for [command (EpisodeSearch)](https://github.com/Sonarr/Sonarr/wiki/Command#episodesearch).
    /// 
    /// Search for all episodes of a particular season.
    /// 
    /// Required Parameters:
    /// - `seriesId`: Series identifier
    /// - `seasonNumber`: Season number to search for
    Future<SonarrCommand> seasonSearch({
        required int seriesId,
        required int seasonNumber,
    }) async => _commandSeasonSearch(_client, seriesId: seriesId, seasonNumber: seasonNumber);
}
