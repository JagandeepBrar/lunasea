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
    /// 
    /// Required Parameters:
    /// - `tvdbId`: TVDB identifier for the series
    /// - `profileId`: Quality profile identifier
    /// - `languageProfileId`: Language profile identifier (if using Sonarr v2, pass null)
    /// - `title`: Title of the series
    /// - `titleSlug`: Title slug of the series
    /// - `images`: List of [SonarrSeriesImage] objects containing the image information
    /// - `seasons`: List of [SonarrSeriesSeason] objects containing the season information
    /// - `path`: Full path to where the series is located **OR**
    /// - `rootFolderPath`: Path to the root folder, where the folder will be created as the title
    /// - `seriesType`: The type of the series (anime, standard, or daily)
    /// 
    /// Optional Parameters:
    /// - `tvRageId`: TVRage identifier for the series
    /// - `seasonFolder`: Should this series use season folders?
    /// - `monitored`: Should this series be monitored?
    /// - `ignoreEpisodesWithFiles`: If true, automatically ignore episodes that already have episodes
    /// - `ignoreEpisodesWithoutFiles`: If true, automatically ignore episodes that do not have episodes
    /// - `searchForMissingEpisodes`: If true, start searching for all missing episodes after adding
    Future<SonarrSeries> addSeries({
        required int tvdbId,
        required int profileId,
        required String title,
        required String titleSlug,
        required List<SonarrSeriesImage> images,
        required List<SonarrSeriesSeason> seasons,
        required SonarrSeriesType seriesType,
        int? languageProfileId,
        List<int>? tags,
        String? path,
        String? rootFolderPath,
        int? tvRageId,
        bool seasonFolder = true,
        bool monitored = true,
        bool ignoreEpisodesWithFiles = false,
        bool ignoreEpisodesWithoutFiles = false,
        bool searchForMissingEpisodes = false,
    }) async => _commandAddSeries(
        _client,
        tvdbId: tvdbId,
        profileId: profileId,
        languageProfileId: languageProfileId,
        title: title,
        titleSlug: titleSlug,
        images: images,
        seasons: seasons,
        path: path,
        rootFolderPath: rootFolderPath,
        tvRageId: tvRageId,
        seasonFolder: seasonFolder,
        monitored: monitored,
        seriesType: seriesType,
        tags: tags,
        ignoreEpisodesWithFiles: ignoreEpisodesWithFiles,
        ignoreEpisodesWithoutFiles: ignoreEpisodesWithoutFiles,
        searchForMissingEpisodes: searchForMissingEpisodes,
    );

    /// Handler for [series/{id}](https://github.com/Sonarr/Sonarr/wiki/Series#deleteid).
    /// 
    /// Delete the series with the given series ID.
    /// 
    /// Required Parameters:
    /// - `seriesId`: Series ID for the series to delete
    /// 
    /// Optional Parameters:
    /// - `deleteFiles`: If true, will delete all files as well
    Future<SonarrSeries> deleteSeries({
        required int seriesId,
        bool deleteFiles = false,
    }) async => _commandDeleteSeries(_client, seriesId: seriesId, deleteFiles: deleteFiles);

    /// Handler for [series/{id}](https://github.com/Sonarr/Sonarr/wiki/Series#getid).
    /// 
    /// Returns the series with the matching ID.
    /// 
    /// Required Parameters:
    /// - `seriesId`: Series ID for the series to return
    Future<SonarrSeries> getSeries({
        required int seriesId,
    }) async => _commandGetSeries(_client, seriesId: seriesId);

    /// Handler for [series](https://github.com/Sonarr/Sonarr/wiki/Series#get).
    /// 
    /// Returns a list of all series.
    Future<List<SonarrSeries>> getAllSeries() async => _commandGetAllSeries(_client);

    /// Handler for [series]https://github.com/Sonarr/Sonarr/wiki/Series#put).
    /// 
    /// Update an existing series.
    /// 
    /// Required Parameters:
    /// - `series`: [SonarrSeries] object containing the updated series information.
    Future<SonarrSeries> updateSeries({
        required SonarrSeries series,
    }) async => _commandUpdateSeries(_client, series: series);
}
