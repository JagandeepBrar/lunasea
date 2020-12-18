import 'dart:convert';
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
                baseUrl: (profile.getRadarr()['host'] as String).endsWith('/')
                    ? '${profile.getRadarr()['host']}api/'
                    : '${profile.getRadarr()['host']}/api/',
                queryParameters: {
                    if(profile.getRadarr()['key'] != '') 'apikey': profile.getRadarr()['key'],
                },
                headers: _headers,
                followRedirects: true,
                maxRedirects: 5,
            ),
        );
        return RadarrAPI._internal(
            profile.getRadarr(),
            _client,
        );
    }

    void logError(String text, Object error, StackTrace trace) => LunaLogger().error('Radarr: $text', error, trace);
    
    bool get enabled => _values['enabled'];
    String get host => _values['host'];
    String get key => _values['key'];

    Future<dynamic> testConnection() async => _dio.get('system/status');

    /// addMovie: Adds a movie to Radarr, returns Radarr ID (integer) for added movie
    Future<int> addMovie(RadarrSearchData entry, RadarrQualityProfile quality, RadarrRootFolder rootFolder, RadarrAvailability minAvailability, bool monitored, {bool search = false}) async {
        try {
            Response response = await _dio.post(
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
            return response.data['id'];
        } on DioError catch (error, stack) {
            logError('Failed to add movie (${entry.title})', error, stack);
            return Future.error(error);
        } catch (error, stack) {
            logError('Failed to add movie (${entry.title})', error, stack);
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
        } on DioError catch (error, stack) {
            logError('Failed to refresh movie ($id)', error, stack);
            return Future.error(error);
        } catch (error, stack) {
            logError('Failed to refresh movie ($id)', error, stack);
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
        } on DioError catch (error, stack) {
            logError('Failed to update library', error, stack);
            return Future.error(error);
        } catch (error, stack) {
            logError('Failed to update library', error, stack);
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
        } on DioError catch (error, stack) {
            logError('Failed to trigger RSS sync', error, stack);
            return Future.error(error);
        } catch (error, stack) {
            logError('Failed to trigger RSS sync', error, stack);
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
        } on DioError catch (error, stack) {
            logError('Failed to backup database', error, stack);
            return Future.error(error);
        } catch (error, stack) {
            logError('Failed to backup database', error, stack);
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
        } on DioError catch (error, stack) {
            logError('Failed to edit movie ($movieID)', error, stack);
            return Future.error(error);
        } catch (error, stack) {
            logError('Failed to edit movie ($movieID)', error, stack);
            return Future.error(error);
        }
    }

    Future<bool> removeMovie(int movieID, {bool deleteFiles = false, bool addExclusion = false }) async {
        try {
            await _dio.delete(
                'movie/$movieID',
                queryParameters: {
                    'deleteFiles': deleteFiles,
                    'addExclusion': addExclusion,
                },
            );
            return true;
        } on DioError catch (error, stack) {
            logError('Failed to remove movie ($movieID)', error, stack);
            return Future.error(error);
        } catch (error, stack) {
            logError('Failed to remove movie ($movieID)', error, stack);
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
                    added: entry['added'] ?? '',
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
        } on DioError catch (error, stack) {
            logError('Failed to fetch all movies', error, stack);
            return Future.error(error);
        } catch (error, stack) {
            logError('Failed to fetch all movies', error, stack);
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
        } on DioError catch (error, stack) {
            logError('Failed to fetch all movie IDs', error, stack);
            return Future.error(error);
        } catch (error, stack) {
            logError('Failed to fetch all movie IDs', error, stack);
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
                added: response.data['added'] ?? '',
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
        } on DioError catch (error, stack) {
            logError('Failed to fetch movie ($movieID)', error, stack);
            return Future.error(error);
        } catch (error, stack) {
            logError('Failed to fetch movie ($movieID)', error, stack);
            return Future.error(error);
        }
    }

    Future<bool> removeMovieFile(int movieID) async {
        try {
            await _dio.delete('moviefile/$movieID');
            return true;
        } on DioError catch (error, stack) {
            logError('Failed to remove movie file ($movieID)', error, stack);
            return Future.error(error);
        } catch (error, stack) {
            logError('Failed to remove movie file ($movieID)', error, stack);
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
        } on DioError catch (error, stack) {
            logError('Failed to fetch missing movies', error, stack);
            return Future.error(error);
        } catch (error, stack) {
            logError('Failed to fetch missing movies', error, stack);
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
        } on DioError catch (error, stack) {
            logError('Failed to fetch upcoming movies', error, stack);
            return Future.error(error);
        } catch (error, stack) {
            logError('Failed to fetch upcoming movies', error, stack);
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
        } on DioError catch (error, stack) {
            logError('Failed to fetch history', error, stack);
            return Future.error(error);
        } catch (error, stack) {
            logError('Failed to fetch history', error, stack);
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
        } on DioError catch (error, stack) {
            logError('Failed to search for missing movies (${movieIDs.toString()})', error, stack);
            return Future.error(error);
        } catch (error, stack) {
            logError('Failed to search for missing movies (${movieIDs.toString()})', error, stack);
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
        } on DioError catch (error, stack) {
            logError('Failed to search for all missing movies', error, stack);
            return Future.error(error);
        } catch (error, stack) {
            logError('Failed to search for all missing movies', error, stack);
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
        } on DioError catch (error, stack) {
            logError('Failed to toggle movie monitored status ($movieID)', error, stack);
            return Future.error(error);
        } catch (error, stack) {
            logError('Failed to toggle movie monitored status ($movieID)', error, stack);
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
        } on DioError catch (error, stack) {
            logError('Failed to fetch quality profiles', error, stack);
            return Future.error(error);
        } catch (error, stack) {
            logError('Failed to fetch quality profiles', error, stack);
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
        } on DioError catch (error, stack) {
            logError('Failed to get releases ($movieID)', error, stack);
            return Future.error(error);
        } catch (error, stack) {
            logError('Failed to get releases ($movieID)', error, stack);
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
        } on DioError catch (error, stack) {
            logError('Failed to download release ($guid)', error, stack);
            return Future.error(error);
        } catch (error, stack) {
            logError('Failed to download release ($guid)', error, stack);
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
        } on DioError catch (error, stack) {
            logError('Failed to automatically search for movie releases ($movieID)', error, stack);
            return  Future.error(error);
        } catch (error, stack) {
            logError('Failed to automatically search for movie releases ($movieID)', error, stack);
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
                    titleSlug: entry['titleSlug'] ?? ((entry['title'] as String) ?? 'Unknown Title').lunaConvertToSlug(),
                    overview: entry['overview'] == null || entry['overview'] == '' ? 'No summary is available.' : entry['overview'],
                    year: entry['year'] ?? 0,
                    tmdbId: entry['tmdbId'] ?? 0,
                    images: entry['images'] ?? [],
                    status: entry['status'] ?? 'Unknown Status',
                ));
            }
            return entries;
        } on DioError catch (error, stack) {
            logError('Failed to search ($search)', error, stack);
            return  Future.error(error);
        } catch (error, stack) {
            logError('Failed to search ($search)', error, stack);
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
        } on DioError catch (error, stack) {
            logError('Failed to fetch root folders', error, stack);
            return Future.error(error);
        } catch (error, stack) {
            logError('Failed to fetch root folders', error, stack);
            return Future.error(error);
        }
    }
}
