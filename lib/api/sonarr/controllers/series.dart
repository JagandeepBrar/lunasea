part of sonarr_commands;

/// Facilitates, encapsulates, and manages individual calls related to series within Sonarr.
///
/// [SonarrControllerSeries] internally handles routing the HTTP client to the API calls.
class SonarrControllerSeries {
  final Dio _client;

  /// Create a series command handler using an initialized [Dio] client.
  SonarrControllerSeries(this._client);

  /// Handler for [series](https://github.com/Sonarr/Sonarr/wiki/Series#post).
  ///
  /// Adds a new series to your collection.
  Future<SonarrSeries> create({
    required SonarrSeries series,
    required SonarrSeriesType seriesType,
    required bool seasonFolder,
    required SonarrQualityProfile qualityProfile,
    required SonarrRootFolder rootFolder,
    required SonarrSeriesMonitorType monitorType,
    List<SonarrTag> tags = const [],
    SonarrLanguageProfile? languageProfile,
    bool searchForMissingEpisodes = false,
    bool searchForCutoffUnmetEpisodes = false,
    bool includeSeasonImages = false,
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
  Future<void> delete({
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
    bool includeSeasonImages = false,
  }) async =>
      _commandGetSeries(
        _client,
        seriesId: seriesId,
        includeSeasonImages: includeSeasonImages,
      );

  /// Handler for [series](https://github.com/Sonarr/Sonarr/wiki/Series#get).
  ///
  /// Returns a list of all series.
  Future<List<SonarrSeries>> getAll({
    bool includeSeasonImages = false,
  }) async =>
      _commandGetAllSeries(
        _client,
        includeSeasonImages: includeSeasonImages,
      );

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
