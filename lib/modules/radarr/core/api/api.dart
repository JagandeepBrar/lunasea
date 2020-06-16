import 'dart:convert';
import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrAPI extends API {
    final Map<String, dynamic> _values;
    final Dio _dio;

    RadarrAPI._internal(this._values, this._dio);
    factory RadarrAPI.from(ProfileHiveObject profile) {
        Map<String, dynamic> _headers = Map<String, dynamic>.from(profile.getRadarr()['headers']);
        Dio _client = Dio(
            BaseOptions(
                baseUrl: '${profile.getRadarr()['host']}/api/',
                queryParameters: {
                    if(profile.getRadarr()['key'] != '') 'apikey': profile.getRadarr()['key'],
                },
                headers: _headers,
                followRedirects: true,
                maxRedirects: 5,
            ),
        );
        if(!profile.getRadarr()['strict_tls']) {
            (_client.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
                client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
            };
        }
        return RadarrAPI._internal(
            profile.getRadarr(),
            _client,
        );
    }

    void logWarning(String methodName, String text) => Logger.warning('package:lunasea/core/api/radarr/api.dart', methodName, 'Radarr: $text');
    void logError(String methodName, String text, Object error) => Logger.error('package:lunasea/core/api/radarr/api.dart', methodName, 'Radarr: $text', error, StackTrace.current);
    
    bool get enabled => _values['enabled'];
    String get host => _values['host'];
    String get key => _values['key'];

    Future<bool> testConnection() async {
        try {
            Response response = await _dio.get('system/status');
            if(response.statusCode == 200) return true;
        } catch (error) {
            logError('testConnection', 'Connection test failed', error);
        }
        return false;
    }

    Future<bool> addMovie(RadarrSearchData entry, RadarrQualityProfile quality, RadarrRootFolder rootFolder, RadarrAvailability minAvailability, bool monitored, {bool search = false}) async {
        try {
            await _dio.post(
                'movie',
                data: json.encode({
                    'title': entry.title,
                    'titleSlug': entry.titleSlug,
                    'qualityProfileId': quality.id,
                    'rootFolderPath': rootFolder.path,
                    'images': entry.images,
                    'tmdbId': entry.tmdbId,
                    'year': entry.year,
                    'minimumAvailability': minAvailability.id,
                    'monitored': monitored,
                    'addOptions': {
                        'searchForMovie': search,
                    }
                }),
            );
            return true;
        } catch (error) {
            logError('addMovie', 'Failed to add movie (${entry.title})', error);
            return Future.error(error);
        }
    }

    Future<bool> refreshMovie(int id) async {
        try {
            await _dio.post(
                'command',
                data: json.encode({
                    'name': 'RefreshMovie',
                    'movieId': id,
                }),
            );
            return true;
        } catch (error) {
            logError('refreshMovie', 'Failed to refresh movie ($id)', error);
            return Future.error(error);
        }
    }

    Future<bool> updateLibrary() async {
        try {
            await _dio.post(
                'command',
                data: json.encode({
                    'name': 'RefreshMovie',
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

    Future<bool> editMovie(int movieID, RadarrQualityProfile qualityProfile, RadarrAvailability availability, String path, bool monitored, bool staticPath) async {
        try {
            Response response = await _dio.get('movie/$movieID');
            Map movie = response.data;
            movie['monitored'] = monitored;
            movie['minimumAvailability'] = availability.id;
            movie['profileId'] = qualityProfile.id;
            movie['path'] = path;
            movie['pathState'] = staticPath ? 'static' : 'dynamic';
            response = await _dio.put(
                'movie',
                data: json.encode(movie),
            );
            return true;
        } catch (error) {
            logError('editMovie', 'Failed to edit movie ($movieID)', error);
            return Future.error(error);
        }
    }

    Future<bool> removeMovie(int movieID, {bool deleteFiles = false }) async {
        try {
            await _dio.delete(
                'movie/$movieID',
                queryParameters: {
                    'deleteFiles': deleteFiles,
                },
            );
            return true;
        } catch (error) {
            logError('removeMovie', 'Failed to remove movie ($movieID)', error);
            return Future.error(error);
        }
    }

    Future<List<RadarrCatalogueData>> getAllMovies() async {
        try {
            Map<int, RadarrQualityProfile> _qualities = await getQualityProfiles().catchError((error) { return Future.error(error); });
            Response response = await _dio.get('movie');
            List<RadarrCatalogueData> entries = [];
            for(var entry in response.data) {
                var _quality = entry['qualityProfileId'] != null ? _qualities[entry['qualityProfileId']] : null;
                entries.add(RadarrCatalogueData(
                    title: entry['title'] ?? 'Unknown Title',
                    sortTitle: entry['sortTitle'] ?? 'Unknown Title',
                    studio: entry['studio'] ?? 'Unknown Studio',
                    physicalRelease: entry['physicalRelease'] ?? '',
                    inCinemas: entry['inCinemas'] ?? '',
                    status: entry['status'] ?? 'Unknown Status',
                    year: entry['year'] ?? 0,
                    movieID: entry['id'] ?? -1,
                    monitored: entry['monitored'] ?? false,
                    downloaded: entry['downloaded'] ?? false,
                    sizeOnDisk: entry['sizeOnDisk'] ?? 0,
                    runtime: entry['runtime'] ?? 0,
                    profile: _quality != null ? _quality.name : '',
                    movieFile: entry['downloaded'] ? entry['movieFile'] : null,
                    overview: entry['overview'] ?? 'No summary is available.',
                    path: entry['path'] ?? 'Unknown Path',
                    qualityProfile: entry['qualityProfileId'] ?? -1,
                    minimumAvailability: entry['minimumAvailability'] ?? '',
                    youtubeId: entry['youTubeTrailerId'] ?? '',
                    imdbId: entry['imdbId'] ?? '',
                    tmdbId: entry['tmdbId'] ?? 0,
                    staticPath: entry['pathState'] == 'static' ? true : false,
                ));
            }
            return entries;
        } catch (error) {
            logError('getAllMovies', 'Failed to fetch all movies', error);
            return Future.error(error);
        }
    }

    Future<List<int>> getAllMovieIDs() async {
        try {
            Response response = await _dio.get('movie');
            List<int> _entries = [];
            for(var entry in response.data) {
                _entries.add(entry['tmdbId'] ?? '');
            }
            return _entries;
        } catch (error) {
            logError('getAllMovieIDs', 'Failed to fetch all movie IDs', error);
            return Future.error(error);
        }
    }

    Future<RadarrCatalogueData> getMovie(int movieID) async {
        try {
            Map<int, RadarrQualityProfile> _qualities = await getQualityProfiles().catchError((error) { return Future.error(error); });
            Response response = await _dio.get('movie/$movieID');
            var _quality = response.data['qualityProfileId'] != null ? _qualities[response.data['qualityProfileId']] : null;
            return RadarrCatalogueData(
                title: response.data['title'] ?? 'Unknown Title',
                sortTitle: response.data['sortTitle'] ?? 'Unknown Title',
                studio: response.data['studio'] ?? 'Unknown Studio',
                physicalRelease: response.data['physicalRelease'] ?? '',
                inCinemas: response.data['inCinemas'] ?? '',
                status: response.data['status'] ?? 'Unknown Status',
                year: response.data['year'] ?? 0,
                movieID: response.data['id'] ?? -1,
                monitored: response.data['monitored'] ?? false,
                downloaded: response.data['downloaded'] ?? false,
                sizeOnDisk: response.data['sizeOnDisk'] ?? 0,
                runtime: response.data['runtime'] ?? 0,
                profile: _quality != null ? _quality.name : '',
                movieFile: response.data['downloaded'] ? response.data['movieFile'] : null,
                overview: response.data['overview'] ?? 'No summary is available.',
                path: response.data['path'] ?? 'Unknown Path',
                qualityProfile: response.data['qualityProfileId'] ?? -1,
                minimumAvailability: response.data['minimumAvailability'] ?? '',
                youtubeId: response.data['youTubeTrailerId'] ?? '',
                imdbId: response.data['imdbId'] ?? '',
                tmdbId: response.data['tmdbId'] ?? 0,
                staticPath: response.data['pathState'] == 'static' ? true : false,
            );
        } catch (error) {
            logError('getMovie', 'Failed to fetch movie ($movieID)', error);
            return Future.error(error);
        }
    }

    Future<bool> removeMovieFile(int movieID) async {
        try {
            await _dio.delete('moviefile/$movieID');
            return true;
        } catch (error) {
            logError('removeMovieFile', 'Failed to remove movie file ($movieID)', error);
            return Future.error(error);
        }
    }

    Future<List<RadarrMissingData>> getMissing() async {
        try {
            Map<int, RadarrQualityProfile> _qualities = await getQualityProfiles().catchError((error) { return Future.error(error); });
            Response response = await _dio.get('movie');
            List<RadarrMissingData> _entries = [];
            for(var entry in response.data) {
                if(!entry['downloaded'] && entry['monitored'] && entry['status'] == 'released') {
                    var _quality = entry['qualityProfileId'] != null ? _qualities[entry['qualityProfileId']] : null;
                    _entries.add(RadarrMissingData(
                        movieID: entry['id'] ?? -1,
                        title: entry['title'] ?? 'Unknown Title',
                        sortTitle: entry['sortTitle'] ?? 'Unknown Title',
                        studio: entry['studio'] ?? 'Unknown Studio',
                        physicalRelease: entry['physicalRelease'] ?? '',
                        inCinemas: entry['inCinemas'] ?? '',
                        profile: _quality != null ? _quality.name : '',
                        year: entry['year'] ?? 0,
                        runtime: entry['runtime'] ?? 0,
                        status: entry['status'] ?? 'Unknown Status',
                    ));
                }
            }
            //Sort the list by the appropriate dates
            _entries.sort((a,b) {
                if(a.physicalReleaseObject == null) return 1;
                if(b.physicalReleaseObject == null) return -1;
                return b.physicalReleaseObject.compareTo(a.physicalReleaseObject);
            });
            return _entries;
        } catch (error) {
            logError('getMissing', 'Failed to fetch missing movies', error);
            return Future.error(error);
        }
    }

    Future<List<RadarrMissingData>> getUpcoming() async {
        try {
            Map<int, RadarrQualityProfile> _qualities = await getQualityProfiles().catchError((error) { return Future.error(error); });
            Response response = await _dio.get('movie');
            List<RadarrMissingData> _cinemaEntries = [];
            List<RadarrMissingData> _announcedEntries = [];
            for(var entry in response.data) {
                if(!entry['downloaded'] && entry['monitored']) {
                    var _quality = entry['qualityProfileId'] != null ? _qualities[entry['qualityProfileId']] : null;
                    if(entry['status'] == 'inCinemas') {
                        _cinemaEntries.add(RadarrMissingData(
                            movieID: entry['id'] ?? -1,
                            title: entry['title'] ?? 'Unknown Title',
                            sortTitle: entry['sortTitle'] ?? 'Unknown Title',
                            studio: entry['studio'] ?? 'Unknown Studio',
                            physicalRelease: entry['physicalRelease'] ?? '',
                            inCinemas: entry['inCinemas'] ?? '',
                            profile: _quality != null ? _quality.name : '',
                            year: entry['year'] ?? 0,
                            runtime: entry['runtime'] ?? 0,
                            status: entry['status'] ?? 'Unknown Status',
                        ));
                    }
                    if(entry['status'] == 'announced') {
                        _announcedEntries.add(RadarrMissingData(
                            movieID: entry['id'] ?? -1,
                            title: entry['title'] ?? 'Unknown Title',
                            sortTitle: entry['sortTitle'] ?? 'Unknown Title',
                            studio: entry['studio'] ?? 'Unknown Studio',
                            physicalRelease: entry['physicalRelease'] ?? '',
                            inCinemas: entry['inCinemas'] ?? '',
                            profile: _quality != null ? _quality.name : '',
                            year: entry['year'] ?? 0,
                            runtime: entry['runtime'] ?? 0,
                            status: entry['status'] ?? 'Unknown Status',
                        ));
                    }
                }
            }
            _cinemaEntries.sort((a,b) {
                if(a.physicalReleaseObject == null) return 1;
                if(b.physicalReleaseObject == null) return -1;
                return a.physicalReleaseObject.compareTo(b.physicalReleaseObject);
            });
            _announcedEntries.sort((a,b) {
                if(a.inCinemasObject == null) return 1;
                if(b.inCinemasObject == null) return -1;
                return a.inCinemasObject.compareTo(b.inCinemasObject);
            });
            return [_cinemaEntries, _announcedEntries].expand((x) => x).toList();
        } catch (error) {
            logError('getUpcoming', 'Failed to fetch upcoming movies', error);
            return Future.error(error);
        }
    }

    Future<List<RadarrHistoryData>> getHistory({ String sortKey = 'date', int pageSize = 250, String sortDir = 'desc' }) async {
        try {
            Response response = await _dio.get(
                'history',
                queryParameters: {
                    'sortKey': sortKey,
                    'pageSize': pageSize,
                    'sortDir': sortDir,
                },
            );
            List<RadarrHistoryData> _entries = [];
            for(var entry in response.data['records']) {
                switch(entry['eventType']) {
                    case 'downloadFolderImported': {
                        _entries.add(RadarrHistoryDataDownloadImported(
                            movieID: entry['movieId'] ?? -1,
                            movieTitle: entry['movie']['title'] ?? 'Unknown Title',
                            timestamp: entry['date'] ?? '',
                            quality: entry['quality']['quality']['name'] ?? 'Unknown Quality',
                        ));
                        break;
                    }
                    case 'downloadFailed': {
                        _entries.add(RadarrHistoryDataDownloadFailed(
                            movieID: entry['movieId'] ?? -1,
                            movieTitle: entry['movie']['title'] ?? 'Unknown Title',
                            timestamp: entry['date'] ?? '',
                        ));
                        break;
                    }
                    case 'movieFileDeleted': {
                        _entries.add(RadarrHistoryDataFileDeleted(
                            movieID: entry['movieId'] ?? -1,
                            movieTitle: entry['movie']['title'] ?? 'Unknown Title',
                            timestamp: entry['date'] ?? '',
                            reason: entry['data']['reason'] ?? 'Unknown Reason',
                        ));
                        break;
                    }
                    case 'movieFileRenamed': {
                        _entries.add(RadarrHistoryDataFileRenamed(
                            movieID: entry['movieId'] ?? -1,
                            movieTitle: entry['movie']['title'] ?? 'Unknown Title',
                            timestamp: entry['date'] ?? '',
                        ));
                        break;
                    }
                    case 'grabbed': {
                        _entries.add(RadarrHistoryDataGrabbed(
                            movieID: entry['movieId'] ?? -1,
                            movieTitle: entry['movie']['title'] ?? 'Unknown Title',
                            timestamp: entry['date'] ?? '',
                            indexer: entry['data']['indexer'] ?? 'Unknown Indexer',
                        ));
                        break;
                    }
                    default: {
                        _entries.add(RadarrHistoryDataGeneric(
                            movieID: entry['movieId'] ?? -1,
                            movieTitle: entry['movie']['title'] ?? 'Unknown Title',
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

    Future<bool> searchMissingMovies(List<int> movieIDs) async {
        try {
            await _dio.post(
                'command',
                data: json.encode({
                    'name': 'MoviesSearch',
                    'movieIds': movieIDs,
                }),
            );
            return true;
        } catch (error) {
            logError('searchMissingMovies', 'Failed to search for missing movies (${movieIDs.toString()})', error);
            return Future.error(error);
        }
    }

    Future<bool> searchAllMissing() async {
        try {
            await _dio.post(
                'command',
                data: json.encode({
                    'name': 'missingMoviesSearch',
                    'filterKey': 'monitored',
                    'filterValue': true,
                }),
            );
            return true;
        } catch (error) {
            logError('searchAllMissing', 'Failed to search for all missing movies', error);
            return Future.error(error);
        }
    }

    Future<bool> toggleMovieMonitored(int movieID, bool status) async {
        try {
            Response response = await _dio.get('movie/$movieID');
            Map data = response.data;
            data['monitored'] = status;
            response = await _dio.put(
                'movie',
                data: json.encode(data),
            );
            return true;
        } catch (error) {
            logError('toggleMovieMonitored', 'Failed to toggle movie monitored status ($movieID)', error);
            return Future.error(error);
        }
    }

    Future<Map<int, RadarrQualityProfile>> getQualityProfiles() async {
        try {
            Response response = await _dio.get('profile');
            var _entries = new Map<int, RadarrQualityProfile>();
            for(var entry in response.data) {
                _entries[entry['id']] = RadarrQualityProfile(
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

    Future<List<RadarrReleaseData>> getReleases(int movieID) async {
        try {
            Response response = await _dio.get(
                'release',
                queryParameters: {
                    'movieId': movieID,
                },
            );
            List<RadarrReleaseData> _entries = [];
            for(var entry in response.data) {
                _entries.add(RadarrReleaseData(
                    title: entry['title'] ?? 'Unknown Title',
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
                    customFormats: entry['quality']['customFormats'] ?? [],
                ));
            }
            return _entries;
        } catch (error) {
            logError('getReleases', 'Failed to get releases ($movieID)', error);
            return Future.error(error);
        }
    }

    Future<bool> downloadRelease(String guid, int indexerID) async {
        try {
            await _dio.post(
                'release',
                data: json.encode({
                    'guid': guid,
                    'indexerId': indexerID,
                }),
            );
            return true;
        } catch (error) {
            logError('downloadRelease', 'Failed to download release ($guid)', error);
            return Future.error(error);
        }
    }

    Future<bool> automaticSearchMovie(int movieID) async {
        try {
            await _dio.post(
                'command',
                data: json.encode({
                    'name': 'MoviesSearch',
                    'movieIds': [movieID],
                }),
            );
            return true;
        } catch (error) {
            logError('automaticSearchMovie', 'Failed to automatically search for movie releases ($movieID)', error);
            return  Future.error(error);
        }
    }

    Future<List<RadarrSearchData>> searchMovies(String search) async {
        if(search == '') return [];
        try {
            Response response = await _dio.get(
                'movie/lookup',
                queryParameters: {
                    'term': search,
                }
            );
            List<RadarrSearchData> entries = [];
            for(var entry in response.data) {
                entries.add(RadarrSearchData(
                    title: entry['title'] ?? 'Unknown Title',
                    titleSlug: entry['titleSlug'] ?? 'unknown-title',
                    overview: entry['overview'] == null || entry['overview'] == '' ? 'No summary is available.' : entry['overview'],
                    year: entry['year'] ?? 0,
                    tmdbId: entry['tmdbId'] ?? 0,
                    images: entry['images'] ?? [],
                    status: entry['status'] ?? 'Unknown Status',
                ));
            }
            return entries;
        } catch (error) {
            logError('searchMovies', 'Failed to search ($search)', error);
            return  Future.error(error);
        }
    }

    Future<List<RadarrRootFolder>> getRootFolders() async {
        try {
            Response response = await _dio.get('rootfolder');
            List<RadarrRootFolder> _entries = [];
            for(var entry in response.data) {
                _entries.add(RadarrRootFolder(
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
}
