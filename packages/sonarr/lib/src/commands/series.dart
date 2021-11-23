part of sonarr_commands;

/// Facilitates, encapsulates, and manages individual calls related to series within Sonarr.
///
/// [SonarrCommandHandler_Series] internally handles routing the HTTP client to the API calls.
class SonarrCommandHandler_Series {
  final Dio _client;

  /// Create a series command handler using an initialized [Dio] client.
  SonarrCommandHandler_Series(this._client);

  /// Handler for [series](https://github.com/Sonarr/Sonarr/wiki/Series#post).
  ///
  /// Adds a new series to your collection.
  Future<SonarrSeries> create({
    required SonarrSeries series,
    required SonarrSeriesType seriesType,
    required bool seasonFolder,
    required SonarrQualityProfile qualityProfile,
    required SonarrLanguageProfile languageProfile,
    required SonarrRootFolder rootFolder,
    required SonarrSeriesMonitorType monitorType,
    List<SonarrTag> tags = const [],
    bool searchForMissingEpisodes = false,
    bool searchForCutoffUnmetEpisodes = false,
  }) async =>
      _commandAddSeries(
        _client,
        series: series,
        seriesType: seriesType,
        seasonFolder: seasonFolder,
        qualityProfile: qualityProfile,
        languageProfile: languageProfile,
        rootFolder: rootFolder,
        monitorType: monitorType,
        tags: tags,
        searchForMissingEpisodes: searchForMissingEpisodes,
        searchForCutoffUnmetEpisodes: searchForCutoffUnmetEpisodes,
      );

  /// Handler for [series/{id}](https://github.com/Sonarr/Sonarr/wiki/Series#deleteid).
  ///
  /// Delete the series with the given series ID.
  Future<SonarrSeries> delete({
    required int seriesId,
    bool deleteFiles = false,
    bool addImportListExclusion = false,
  }) async =>
      _commandDeleteSeries(
        _client,
        seriesId: seriesId,
        deleteFiles: deleteFiles,
        addImportListExclusion: addImportListExclusion,
      );

  /// Handler for [series/{id}](https://github.com/Sonarr/Sonarr/wiki/Series#getid).
  ///
  /// Returns the series with the matching ID.
  Future<SonarrSeries> get({
    required int seriesId,
  }) async =>
      _commandGetSeries(
        _client,
        seriesId: seriesId,
      );

  /// Handler for [series](https://github.com/Sonarr/Sonarr/wiki/Series#get).
  ///
  /// Returns a list of all series.
  Future<List<SonarrSeries>> getAll() async => _commandGetAllSeries(_client);

  /// Handler for [series]https://github.com/Sonarr/Sonarr/wiki/Series#put).
  ///
  /// Update an existing series.
  Future<SonarrSeries> update({
    required SonarrSeries series,
  }) async =>
      _commandUpdateSeries(
        _client,
        series: series,
      );
}
