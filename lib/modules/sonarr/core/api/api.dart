import 'dart:convert';
import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrAPI extends API {
    final Map<String, dynamic> _values;
    final Dio _dio;

    SonarrAPI._internal(this._values, this._dio);
    factory SonarrAPI.from(ProfileHiveObject profile) {
        Map<String, dynamic> _headers = Map<String, dynamic>.from(profile.getSonarr()['headers']);
        Dio _client = Dio(
            BaseOptions(
                baseUrl: '${profile.getSonarr()['host']}/api/',
                queryParameters: {
                    if(profile.getSonarr()['key'] != '') 'apikey': profile.getSonarr()['key'],
                },
                headers: _headers,
                followRedirects: true,
                maxRedirects: 5,
            ),
        );
        if(!profile.getSonarr()['strict_tls']) {
            (_client.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
                client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
            };
        }
        return SonarrAPI._internal(
            profile.getSonarr(),
            _client,
        );
    }

    void logWarning(String methodName, String text) => Logger.warning('package:lunasea/core/api/sonarr/api.dart', methodName, 'Sonarr: $text');
    void logError(String methodName, String text, Object error) => Logger.error('package:lunasea/core/api/sonarr/api.dart', methodName, 'Sonarr: $text', error, StackTrace.current);

    bool get enabled => _values['enabled'];
    String get host => _values['host'];
    String get key => _values['key'];

    Future<bool> testConnection() async {
        try {
            Response response = await _dio.get('system/status');
            if(response.statusCode  == 200) return true;
        } catch (error) {
            logError('testConnection', 'Connection test failed', error);
        }
        return false;
    }

    Future<bool> refreshSeries(int seriesID) async {
        try {
            await _dio.post(
                'command',
                data: json.encode({
                    'name': 'RefreshSeries',
                    'seriesId': seriesID,
                }),
            );
            return true;
        } catch (error) {
            logError('refreshSeries', 'Failed to refresh series ($seriesID)', error);
            return Future.error(error);
        }
    }

    Future<bool> removeSeries(int seriesID, { deleteFiles = false }) async {
        try {
            await _dio.delete(
                'series/$seriesID',
                queryParameters: {
                    'deleteFiles': deleteFiles,
                },
            );
            return true;
        } catch (error) {
            logError('removeSeries', 'Failed to remove series ($seriesID)', error);
            return Future.error(error);
        }
    }

    Future<List<SonarrSearchData>> searchSeries(String search) async {
        if(search == '') return [];
        try {
            Response response = await _dio.get(
                'series/lookup',
                queryParameters: {
                    'term': search,
                }
            );
            List<SonarrSearchData> entries = [];
            for(var entry in response.data) {
                entries.add(SonarrSearchData(
                    title: entry['title'] ?? 'Unknown Title',
                    overview: entry['overview'] == null || entry['overview'] == '' ? 'No summary is available.' : entry['overview'],
                    seasonCount: entry['seasonCount'] ?? 0,
                    status: entry['status'] ?? 'Unknown Status',
                    images: entry['images'] ?? [],
                    seasons: entry['seasons'] ?? [],
                    tvdbId: entry['tvdbId'] ?? 0,
                    tvMazeId: entry['tvMazeId'] ?? 0,
                    imdbId: entry['imdbId'] ?? '',
                    year: entry['year'] ?? 0,
                ));
            }
            return entries;
        } catch (error) {
            logError('searchSeries', 'Failed to search ($search)', error);
            return  Future.error(error);
        }
    }

    Future<bool> addSeries(
        SonarrSearchData entry,
        SonarrQualityProfile qualityProfile,
        SonarrRootFolder rootFolder,
        SonarrSeriesType seriesType,
        SonarrMonitorStatus monitorStatus,
        bool seasonFolders,
        bool monitored,
        { bool search = false }
    ) async {
        monitorStatus.process(entry.seasons);
        bool _ignoreWithFiles =
            monitorStatus == SonarrMonitorStatus.MISSING ||
            monitorStatus == SonarrMonitorStatus.FUTURE;
        bool _ignoreWithoutFiles = 
            monitorStatus == SonarrMonitorStatus.EXISTING ||
            monitorStatus == SonarrMonitorStatus.FUTURE;
        try {
            await _dio.post(
                'series',
                data: json.encode({
                    'addOptions': {
                        'ignoreEpisodesWithFiles': _ignoreWithFiles,
                        'ignoreEpisodesWithoutFiles': _ignoreWithoutFiles,
                        'searchForMissingEpisodes': search,
                    },
                    'tvdbId': entry.tvdbId,
                    'title': entry.title,
                    'titleSlug': entry.titleSlug,
                    'profileId': qualityProfile.id,
                    'images': entry.images,
                    'seasons': entry.seasons,
                    'rootFolderPath': rootFolder.path,
                    'monitored': monitored,
                    'seriesType': seriesType.type,
                    'seasonFolder': seasonFolders,
                }),
            );
            return true;
        } catch (error) {
            logError('addSeries', 'Failed to add series (${entry.title})', error);
            return Future.error(error);
        }
    }

    Future<bool> editSeries(int seriesID, SonarrQualityProfile qualityProfile, SonarrSeriesType seriesType, String path, bool monitored, bool seasonFolder) async {
        try {
            Response response = await _dio.get('series/$seriesID');
            Map series = response.data;
            series['monitored'] = monitored;
            series['seasonFolder'] = seasonFolder;
            series['profileId'] = qualityProfile.id;
            series['seriesType'] = seriesType.type;
            series['path'] = path;
            await _dio.put(
                'series',
                data: json.encode(series),
            );
            return true;
        } catch (error) {
            logError('editSeries', 'Failed to edit series ($seriesID)', error);
            return Future.error(error);
        }
    }

    Future<SonarrCatalogueData> getSeries(int seriesID) async {
        try {
            Map<int, SonarrQualityProfile> _qualities = await getQualityProfiles().catchError((error) { return Future.error(error); });
            Response response = await _dio.get('series/$seriesID');
            Map body = response.data;
            List<dynamic> _seasonData = body['seasons'];
            _seasonData.sort((a, b) => a['seasonNumber'].compareTo(b['seasonNumber']));
            return SonarrCatalogueData(
                title: body['title'] ?? 'Unknown Title',
                sortTitle: body['sortTitle'] ?? 'Unknown Title',
                seasonCount: body['seasonCount'] ?? 0,
                seasonData: _seasonData ?? [],
                episodeCount: body['episodeCount'] ?? 0,
                episodeFileCount: body['episodeFileCount'] ?? 0,
                status: body['status'] ?? 'Unknown Status',
                seriesID: body['id'] ?? -1,
                previousAiring: body['previousAiring'] ?? '',
                nextAiring: body['nextAiring'] ?? '',
                network: body['network'] ?? 'Unknown Network',
                monitored: body['monitored'] ?? false,
                path: body['path'] ?? 'Unknown Path',
                qualityProfile: body['qualityProfileId'] ?? 0,
                type: body['seriesType'] ?? 'Unknown Series Type',
                seasonFolder: body['seasonFolder'] ?? false,
                overview: body['overview'] ?? 'No summary is available.',
                tvdbId: body['tvdbId'] ?? 0,
                tvMazeId: body['tvMazeId'] ?? 0,
                imdbId: body['imdbId'] ?? '',
                runtime: body['runtime'] ?? 0,
                profile: body['profileId'] != null ? _qualities[body['qualityProfileId']].name : 'Unknown Quality Profile',
                sizeOnDisk: body['sizeOnDisk'] ?? 0,
            );
        } catch (error) {
            logError('getSeries', 'Failed to fetch series ($seriesID)', error);
            return Future.error(error);
        }
    }

    Future<List<SonarrCatalogueData>> getAllSeries() async {
        try {
            Map<int, SonarrQualityProfile> _qualities = await getQualityProfiles().catchError((error) { return Future.error(error); });
            Response response = await _dio.get('series');
            List<SonarrCatalogueData> entries = [];
            for(var entry in response.data) {
                List<dynamic> _seasonData = entry['seasons'];
                _seasonData.sort((a, b) => a['seasonNumber'].compareTo(b['seasonNumber']));
                entries.add(SonarrCatalogueData(
                    title: entry['title'] ?? 'Unknown Title',
                    sortTitle: entry['sortTitle'] ?? 'Unknown Title',
                    seasonCount: entry['seasonCount'] ?? 0,
                    seasonData: _seasonData ?? [],
                    episodeCount: entry['episodeCount'] ?? 0,
                    episodeFileCount: entry['episodeFileCount'] ?? 0,
                    status: entry['status'] ?? 'Unknown Status',
                    seriesID: entry['id'] ?? -1,
                    previousAiring: entry['previousAiring'] ?? '',
                    nextAiring: entry['nextAiring'] ?? '',
                    network: entry['network'] ?? 'Unknown Network',
                    monitored: entry['monitored'] ?? false,
                    path: entry['path'] ?? 'Unknown Path',
                    qualityProfile: entry['qualityProfileId'] ?? 0,
                    type: entry['seriesType'] ?? 'Unknown Series Type',
                    seasonFolder: entry['seasonFolder'] ?? false,
                    overview: entry['overview'] ?? 'No summary is available.',
                    tvdbId: entry['tvdbId'] ?? 0,
                    tvMazeId: entry['tvMazeId'] ?? 0,
                    imdbId: entry['imdbId'] ?? '',
                    runtime: entry['runtime'] ?? 0,
                    profile: entry['profileId'] != null ? _qualities[entry['qualityProfileId']].name : '',
                    sizeOnDisk: entry['sizeOnDisk'] ?? 0,
                ));
            }
            return entries;
        } catch (error) {
            logError('getAllSeries', 'Failed to fetch all series', error);
            return Future.error(error);
        }
    }

    Future<List<int>> getAllSeriesIDs() async {
        try {
            Response response = await _dio.get('series');
            List<int> _entries = [];
            for(var entry in response.data) _entries.add(entry['tvdbId'] ?? 0);
            return _entries;
        } catch (error) {
            logError('getAllSeriesIDs', 'Failed to fetch all series IDs', error);
            return Future.error(error);
        }
    }

    Future<Map> getUpcoming({int duration = 7}) async {
        try {
            DateTime now = DateTime.now();
            String start = DateFormat('y-MM-dd').format(now);
            String end = DateFormat('y-MM-dd').format(now.add(Duration(days: duration)));
            Response response = await _dio.get(
                'calendar',
                queryParameters: {
                    'start': start,
                    'end': end,
                }
            );
            if(response.data.length <= 0) return {};
            Map _entries = {};
            for(int i=0; i<duration; i++) {
                _entries[DateFormat('y-MM-dd').format(now.add(Duration(days: i)))] = {
                    'date': DateFormat('EEEE / MMMM dd, y').format(now.add(Duration(days: i))),
                    'entries': [],
                };
            }
            for(var entry in response.data) {
                DateTime date = DateTime.tryParse(entry['airDateUtc'])?.toLocal();
                if(date != null) {
                    String dateParsed = DateFormat('y-MM-dd').format(date);
                    if(_entries.containsKey(dateParsed)) {
                        _entries[dateParsed]['entries'].add(SonarrUpcomingData(
                        seriesTitle: entry['series']['title'] ?? 'Unknown Series Title',
                            episodeTitle: entry['title'] ?? 'Unknown Episode Title',
                            seasonNumber: entry['seasonNumber'] ?? 0,
                            episodeNumber: entry['episodeNumber'] ?? 0,
                            seriesID: entry['series']['id'] ?? -1,
                            id: entry['id'] ?? -1,
                            airTime: entry['airDateUtc'] ?? '',
                            hasFile: entry['hasFile'] ?? false,
                            filePath: entry['hasFile'] ? entry['episodeFile']['quality']['quality']['name'] : '',
                        ));
                    }
                }
            }
            return _entries;
        } catch (error) {
            logError('getUpcoming', 'Failed to fetch upcoming episodes', error);
            return Future.error(error);
        }
    }

    Future<List<SonarrHistoryData>> getHistory() async {
        try {
            Response response = await _dio.get(
                'history',
                queryParameters: {
                    'sortKey': 'date',
                    'pageSize': 250,
                    'sortDir': 'desc',
                }
            );
            List<SonarrHistoryData> _entries = [];
            for(var entry in response.data['records']) {
                switch(entry['eventType']) {
                    case 'downloadFolderImported': {
                        _entries.add(SonarrHistoryDataDownloadImported(
                            seriesID: entry['seriesId'] ?? -1,
                            seriesTitle: entry['series']['title'] ?? 'Unknown Series Title',
                            episodeTitle: entry['episode']['title'] ?? 'Unknown Episode Title',
                            episodeNumber: entry['episode']['episodeNumber'] ?? 0,
                            seasonNumber: entry['episode']['seasonNumber'] ?? 0,
                            timestamp: entry['date'] ?? '',
                            quality: entry['quality']['quality']['name'] ?? '',
                        ));
                        break;
                    }
                    case 'downloadFailed': {
                        _entries.add(SonarrHistoryDataDownloadFailed(
                            seriesID: entry['seriesId'] ?? -1,
                            seriesTitle: entry['series']['title'] ?? 'Unknown Series Title',
                            episodeTitle: entry['episode']['title'] ?? 'Unknown Episode Title',
                            episodeNumber: entry['episode']['episodeNumber'] ?? 0,
                            seasonNumber: entry['episode']['seasonNumber'] ?? 0,
                            timestamp: entry['date'] ?? '',
                        ));
                        break;
                    }
                    case 'episodeFileDeleted': {
                        _entries.add(SonarrHistoryDataEpisodeDeleted(
                            seriesID: entry['seriesId'] ?? -1,
                            seriesTitle: entry['series']['title'] ?? 'Unknown Series Title',
                            episodeTitle: entry['episode']['title'] ?? 'Unknown Episode Title',
                            episodeNumber: entry['episode']['episodeNumber'] ?? 0,
                            seasonNumber: entry['episode']['seasonNumber'] ?? 0,
                            timestamp: entry['date'] ?? '',
                            reason: entry['data']['reason'] ?? 'Unknown Deletion Reason',
                        ));
                        break;
                    }
                    case 'episodeFileRenamed': {
                        _entries.add(SonarrHistoryDataEpisodeRenamed(
                            seriesID: entry['seriesId'] ?? -1,
                            seriesTitle: entry['series']['title'] ?? 'Unknown Series Title',
                            episodeTitle: entry['episode']['title'] ?? 'Unknown Episode Title',
                            episodeNumber: entry['episode']['episodeNumber'] ?? 0,
                            seasonNumber: entry['episode']['seasonNumber'] ?? 0,
                            timestamp: entry['date'] ?? '',
                        ));
                        break;
                    }
                    case 'grabbed': {
                        _entries.add(SonarrHistoryDataGrabbed(
                            seriesID: entry['seriesId'] ?? -1,
                            seriesTitle: entry['series']['title'] ?? 'Unknown Series Title',
                            episodeTitle: entry['episode']['title'] ?? 'Unknown Episode Title',
                            episodeNumber: entry['episode']['episodeNumber'] ?? 0,
                            seasonNumber: entry['episode']['seasonNumber'] ?? 0,
                            timestamp: entry['date'] ?? '',
                            indexer: entry['data']['indexer'] ?? 'Unknown Indexer',
                        ));
                        break;
                    }
                    default: {
                        _entries.add(SonarrHistoryDataGeneric(
                            seriesID: entry['seriesId'] ?? -1,
                            seriesTitle: entry['series']['title'] ?? 'Unknown Series Title',
                            episodeTitle: entry['episode']['title'] ?? 'Unknown Episode Title',
                            episodeNumber: entry['episode']['episodeNumber'] ?? 0,
                            seasonNumber: entry['episode']['seasonNumber'] ?? 0,
                            timestamp: entry['date'] ?? '',
                            eventType: entry['eventType'] ?? 'Unknown Event Type',
                        ));
                        break;
                    }
                }
            }
            return _entries;
        } catch (error) {
            logError('getHistory', 'Failed to fetch history', error);
            return Future.error(error);
        }
    }

    Future<Map> getEpisodes(int seriesID, int seasonNumber) async {
        try {
            Map _queue = await getQueue().catchError((error) { return Future.error(error); });
            Response response = await _dio.get(
                'episode',
                queryParameters: {
                    'seriesId': seriesID,
                }
            );
            Map entries = {};
            for(var entry in response.data) {
                if(seasonNumber == -1 || entry['seasonNumber'] == seasonNumber) {
                    if(!entries.containsKey(entry['seasonNumber'])) {
                        entries[entry['seasonNumber']] = [];
                        entries[-1] = response.data.length;
                    }
                    String quality = '';
                    bool cutoffMet = false;
                    int size = 0;
                    SonarrQueueData _queueEntry;
                    if(entry['hasFile']) {
                        quality = entry['episodeFile']['quality']['quality']['name'];
                        cutoffMet = entry['episodeFile']['qualityCutoffNotMet'];
                        size = entry['episodeFile']['size'];
                    }
                    if(_queue.containsKey(entry['id'])) {
                        _queueEntry = _queue[entry['id']];
                    }
                    entries[entry['seasonNumber']].add(SonarrEpisodeData(
                        episodeTitle: entry['title'] ?? 'Unknown Title',
                        seasonNumber: entry['seasonNumber'] ?? 0,
                        episodeNumber: entry['episodeNumber'] ?? 0,
                        overview: entry['overview'] ?? 'No summary is available.',
                        airDate: entry['airDateUtc'] ?? '',
                        episodeID: entry['id'] ?? -1,
                        episodeFileID: entry['episodeFileId'] ?? -1,
                        isMonitored: entry['monitored'] ?? false,
                        hasFile: entry['hasFile'] ?? false,
                        quality: quality ?? 'Unknown Quality',
                        cutoffNotMet: cutoffMet ?? false,
                        size: size ?? 0,
                        queue: _queueEntry ?? null,
                    ));
                }
            }
            return entries;
        } catch (error) {
            logError('getEpisodes', 'Failed to fetch episodes ($seriesID, $seasonNumber)', error);
            return Future.error(error);
        }
    }

    Future<Map> getQueue() async {
        try {
            Response response = await _dio.get('queue');
            Map entries = {};
            for(var entry in response.data) {
                if(entry['episode'] != null) entries[entry['episode']['id']] = SonarrQueueData(
                    episodeID: entry['episode']['id'] ?? 0,
                    size: entry['size'] ?? 0.0,
                    sizeLeft: entry['sizeleft'] ?? 0.0,
                    status: entry['status'] ?? 'Unknown Status',
                    releaseTitle: entry['title'] ?? 'Unknown Release',
                    seriesTitle: entry['series']['title'] ?? 'Unknown Series',
                    seasonNumber: entry['episode']['seasonNumber'] ?? -1,
                    episodeNumber: entry['episode']['episodeNumber'] ?? -1,
                );
            }
            return entries;
        } catch (error) {
            logError('getQueue', 'Failed to fetch queue', error);
            return Future.error(error);
        }
    }

    Future<List<SonarrMissingData>> getMissing() async {
        try {
            Response response = await _dio.get(
                'wanted/missing',
                queryParameters: {
                    'pageSize': 200,
                }  
            );
            List<SonarrMissingData> entries = [];
            for(var entry in response.data['records']) {
                entries.add(SonarrMissingData(
                    showTitle: entry['series']['title'] ?? 'Unknown Series Title',
                    episodeTitle: entry['title'] ?? 'Unknown Episode Title',
                    seasonNumber: entry['seasonNumber'] ?? 0,
                    episodeNumber: entry['episodeNumber'] ?? 0,
                    airDateUTC: entry['airDateUtc'] ?? '',
                    seriesID: entry['series']['id'] ?? -1,
                    episodeID: entry['id'] ?? -1,
                ));
            }
            return entries;
        } catch (error) {
            logError('getMissing', 'Failed to fetch missing episodes', error);
            return Future.error(error);
        }
    }

    Future<bool> searchAllMissing() async {
        try {
            await _dio.post(
                'command',
                data: json.encode({
                    'name': 'missingEpisodeSearch',
                }),
            );
            return true;
        } catch (error) {
            logError('searchAllMissing', 'Failed to search for all missing episodes', error);
            return Future.error(error);
        }
    }

    Future<bool> updateLibrary() async {
        try {
            await _dio.post(
                'command',
                data: json.encode({
                    'name': 'refreshSeries',
                }),
            );
            return true;
        } catch (error) {
            logError('updateLibrary', 'Failed to update library', error);
            return Future.error(error);
        }
    }

    Future<bool> triggerRssSync() async {
        try {
            await _dio.post(
                'command',
                data: json.encode({
                    'name': 'RssSync',
                }),
            );
            return true;
        } catch (error) {
            logError('triggerRssSync', 'Failed to trigger RSS sync', error);
            return Future.error(error);
        }
    }

    Future<bool> triggerBackup() async {
        try {
            await _dio.post(
                'command',
                data: json.encode({
                    'name': 'Backup',
                }),
            );
            return true;
        } catch (error) {
            logError('triggerBackup', 'Failed to backup database', error);
            return Future.error(error);
        }
    }

    Future<bool> searchSeason(int seriesID, int season) async {
        try {
            await _dio.post(
                'command',
                data: json.encode({
                    'name': 'SeasonSearch',
                    'seriesId': seriesID,
                    'seasonNumber': season,
                }),
            );
            return true;
        } catch (error) {
            logError('searchSeason', 'Failed to search for season ($seriesID, $season)', error);
            return Future.error(error);
        }
    }

    Future<bool> searchEpisodes(List<int> episodeIDs) async {
        try {
            await _dio.post(
                'command',
                data: json.encode({
                    'name': 'EpisodeSearch',
                    'episodeIds': episodeIDs,
                }),
            );
            return true;
        } catch (error) {
            logError('searchEpisodes', 'Failed to search for episodes (${episodeIDs.toString()})', error);
            return Future.error(error);
        }
    }

    Future<bool> toggleSeriesMonitored(int seriesID, bool status) async {
        try {
            Response response = await _dio.get('series/$seriesID');
            Map body = response.data;
            body['monitored'] = status;
            await _dio.put(
                'series',
                data: json.encode(body),
            );
            return true;
        } catch (error) {
            logError('toggleSeriesMonitored', 'Failed to toggle series monitored ($seriesID)', error);
            return Future.error(error);
        }
    }

    Future<bool> toggleSeasonMonitored(int seriesID, int seasonID, bool status) async {
        try {
            Response response = await _dio.get('series/$seriesID');
            Map body = response.data;
            for(var season in body['seasons']) {
                if(season['seasonNumber'] == seasonID) {
                    season['monitored'] = status;
                }
            }
            await _dio.put(
                'series',
                data: json.encode(body),
            );
            return true;
        } catch (error) {
            logError('toggleSeasonMonitored', 'Failed to toggle season monitored ($seriesID, $seasonID)', error);
            return Future.error(error);
        }
    }

    Future<List<SonarrRootFolder>> getRootFolders() async {
        try {
            Response response = await _dio.get('rootfolder');
            List<SonarrRootFolder> _entries = [];
            for(var entry in response.data) {
                _entries.add(SonarrRootFolder(
                    id: entry['id'] ?? -1,
                    path: entry['path'] ?? 'Unknown Root Folder',
                    freeSpace: entry['freeSpace'] ?? 0,
                ));
            }
            return _entries;
        } catch (error) {
            logError('getRootFolders', 'Failed to fetch root folders', error);
            return Future.error(error);
        }
    }

    Future<Map<int, SonarrQualityProfile>> getQualityProfiles() async {
        try {
            Response response = await _dio.get('profile');
            var _entries = new Map<int, SonarrQualityProfile>();
            for(var entry in response.data) {
                _entries[entry['id']] = SonarrQualityProfile(
                    id: entry['id'] ?? -1,
                    name: entry['name'] ?? 'Unknown Quality Profile',
                );
            }
            return _entries;
        } catch (error) {
            logError('getQualityProfiles', 'Failed to fetch quality profiles', error);
            return Future.error(error);
        }
    }

    Future<List<SonarrReleaseData>> getReleases(int episodeID) async {
        try {
            Response response = await _dio.get(
                'release',
                queryParameters: {
                    'episodeId': episodeID,
                }
            );
            List<SonarrReleaseData> _entries = [];
            for(var entry in response.data) {
                _entries.add(SonarrReleaseData(
                    title: entry['title'] ?? 'Unknown Release Title',
                    guid: entry['guid'] ?? '',
                    quality: entry['quality']['quality']['name'] ?? 'Unknown',
                    protocol: entry['protocol'] ?? 'Unknown Protocol',
                    indexer: entry['indexer'] ?? 'Unknown Indexer',
                    infoUrl: entry['infoUrl'] ?? '',
                    approved: entry['approved'] ?? false,
                    releaseWeight: entry['releaseWeight'] ?? 0,
                    size: entry['size'] ?? 0,
                    indexerId: entry['indexerId'] ?? 0,
                    ageHours: entry['ageHours'] ?? 0,
                    rejections: entry['rejections'] ?? [],
                    seeders: entry['seeders'] ?? 0,
                    leechers: entry['leechers'] ?? 0,
                ));
            }
            return _entries;
        } catch (error) {
            logError('getReleases', 'Failed to fetch releases ($episodeID)', error);
            return Future.error(error);
        }
    }

    Future<bool> downloadRelease(String guid, int indexerId) async {
        try {
            await _dio.post(
                'release',
                data: json.encode({
                    'guid': guid,
                    'indexerId': indexerId,
                }),
            );
            return true;
        } catch (error) {
            logError('downloadRelease', 'Failed to download release ($guid)', error);
            return Future.error(error);
        }
    }

    Future<bool> toggleEpisodeMonitored(int episodeID, bool status) async {
        try {
            Response response = await _dio.get('episode/$episodeID');
            Map body = response.data;
            body['monitored'] = status;
            await _dio.put(
                'episode',
                data: json.encode(body),
            );
            return true;
        } catch (error) {
            logError('toggleEpisodeMonitored', 'Failed to toggle episode monitored state ($episodeID, $status)', error);
            return Future.error(error);
        }
    }

    Future<bool> deleteEpisodeFile(int episodeFileID) async {
        try {
            await _dio.delete('episodefile/$episodeFileID');
            return true;
        } catch (error) {
            logError('deleteEpisodeFile', 'Failed to delete episode file ($episodeFileID)', error);
            return Future.error(error);
        }
    }
}
