part of sonarr_commands;

class SonarrControllerCommand {
  final Dio _client;

  SonarrControllerCommand(this._client);

  Future<SonarrCommand> backup() async => _commandBackup(_client);

  Future<SonarrCommand> episodeSearch({
    required List<int> episodeIds,
  }) async =>
      _commandEpisodeSearch(_client, episodeIds: episodeIds);

  Future<List<SonarrCommand>> queue() async => _commandCommandQueue(_client);

  Future<SonarrCommand> missingEpisodeSearch() async =>
      _commandMissingEpisodeSearch(_client);

  Future<SonarrCommand> refreshMonitoredDownloads() async =>
      _commandRefreshMonitoredDownloads(_client);

  Future<SonarrCommand> refreshSeries({
    int? seriesId,
  }) async =>
      _commandRefreshSeries(_client, seriesId: seriesId);

  Future<SonarrCommand> rescanSeries({
    int? seriesId,
  }) async =>
      _commandRescanSeries(_client, seriesId: seriesId);

  Future<SonarrCommand> rssSync() async => _commandRSSSync(_client);

  Future<SonarrCommand> seasonSearch({
    required int seriesId,
    required int seasonNumber,
  }) async =>
      _commandSeasonSearch(_client,
          seriesId: seriesId, seasonNumber: seasonNumber);

  Future<SonarrCommand> seriesSearch({
    required int seriesId,
  }) async =>
      _commandSeriesSearch(_client, seriesId: seriesId);
}
