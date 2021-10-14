part of sonarr_commands;

Future<SonarrSeries> _commandAddSeries(Dio client, {
    required int tvdbId,
    required int profileId,
    required String title,
    required String titleSlug,
    required List<SonarrSeriesImage> images,
    required List<SonarrSeriesSeason> seasons,
    required SonarrSeriesType seriesType,
    String? path,
    String? rootFolderPath,
    int? tvRageId,
    int? languageProfileId,
    List<int>? tags,
    bool seasonFolder = true,
    bool monitored = true,
    bool ignoreEpisodesWithFiles = false,
    bool ignoreEpisodesWithoutFiles = false,
    bool searchForMissingEpisodes = false,
}) async {
    if(path == null) assert(rootFolderPath != null, 'path and rootFolderPath cannot both be null');
    if(path != null) assert(rootFolderPath == null, 'path and rootFolderPath cannot both be defined');
    Response response = await client.post('series', data: {
        'tvdbId': tvdbId,
        'profileId': profileId,
        if(languageProfileId != null) 'languageProfileId': languageProfileId,
        'title': title,
        'titleSlug': titleSlug,
        'images': images,
        'seasons': seasons,
        if(path != null) 'path': path,
        if(rootFolderPath != null) 'rootFolderPath': rootFolderPath,
        if(tvRageId != null) 'tvRageId': tvRageId,
        'seasonFolder': seasonFolder,
        'monitored': monitored,
        'seriesType': seriesType.value,
        if(tags != null) 'tags': tags,
        'addOptions': {
            'ignoreEpisodesWithFiles': ignoreEpisodesWithFiles,
            'ignoreEpisodesWithoutFiles': ignoreEpisodesWithoutFiles,
            'searchForMissingEpisodes': searchForMissingEpisodes,
        },
    });
    return SonarrSeries.fromJson(response.data);
}
