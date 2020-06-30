import 'dart:io';
import 'dart:convert';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/lidarr.dart';

class LidarrAPI extends API {
    final Map<String, dynamic> _values;
    final Dio _dio;

    LidarrAPI._internal(this._values, this._dio);
    factory LidarrAPI.from(ProfileHiveObject profile) {
        Map<String, dynamic> _headers = Map<String, dynamic>.from(profile.getLidarr()['headers']);
        Dio _client = Dio(
            BaseOptions(
                baseUrl: '${profile.getLidarr()['host']}/api/v1/',
                queryParameters: {
                    if(profile.getLidarr()['key'] != '') 'apikey': profile.getLidarr()['key'],
                },
                headers: _headers,
                followRedirects: true,
                maxRedirects: 5,
            ),
        );
        if(!profile.getLidarr()['strict_tls']) {
            (_client.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
                client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
            };
        }
        return LidarrAPI._internal(
            profile.getLidarr(),
            _client,
        );
    }

    void logWarning(String methodName, String text) => Logger.warning('package:lunasea/core/api/lidarr/api.dart', methodName, 'Lidarr: $text');
    void logError(String methodName, String text, Object error) => Logger.error('package:lunasea/core/api/lidarr/api.dart', methodName, 'Lidarr: $text', error, StackTrace.current);

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

    Future<List<LidarrCatalogueData>> getAllArtists() async {
        try {
            Map<int, LidarrQualityProfile> _qualities = await getQualityProfiles().catchError((error) { return Future.error(error); });
            Map<int, LidarrMetadataProfile> _metadatas = await getMetadataProfiles().catchError((error) { return Future.error(error); });
            Response response = await _dio.get('artist');
            List<LidarrCatalogueData> entries = [];
            for(var entry in response.data) {
                entries.add(LidarrCatalogueData(
                    title: entry['artistName'] ?? 'Unknown Artist',
                    sortTitle: entry['sortName'] ?? 'Unknown Artist',
                    overview: entry['overview'] ?? 'No summary is available.',
                    path: entry['path'] ?? 'Unknown Path',
                    artistID: entry['id'] ?? 0,
                    artistType: entry['artistType'] ?? 'Unknown Artist Type',
                    monitored: entry['monitored'] ?? false,
                    statistics: entry['statistics'] ?? {},
                    qualityProfile: entry['qualityProfileId'] ?? 0,
                    metadataProfile: entry['metadataProfileId'] ?? 0,
                    quality: entry['qualityProfileId'] != null ? _qualities[entry['qualityProfileId']].name ?? 'Unknown Quality Profile' : '',
                    metadata: entry['metadataProfileId'] != null ? _metadatas[entry['metadataProfileId']].name ?? 'Unknown Metadata Profile' : '',
                    genres: entry['genres'] ?? [],
                    links: entry['links'] ?? [],
                    albumFolders: entry['albumFolder'] ?? false,
                    foreignArtistID: entry['foreignArtistId'] ?? '',
                    sizeOnDisk: entry['statistics'] != null ? entry['statistics']['sizeOnDisk'] ?? 0 : 0,
                ));
            }
            return entries;
        } catch (error) {
            logError('getAllArtists', 'Failed to fetch artists', error);
            return Future.error(error);
        }
    }

    Future<List<String>> getAllArtistIDs() async {
        try {
            Response response = await _dio.get('artist');
            List<String> _entries = [];
            for(var entry in response.data) {
                _entries.add(entry['foreignArtistId'] ?? '');
            }
            return _entries;
        } catch (error) {
            logError('getAllArtistIDs', 'Failed to fetch artist IDs', error);
            return Future.error(error);
        }
    }

    Future<bool> refreshArtist(int artistID) async {
        try {
            await _dio.post(
                'command',
                data: json.encode({
                    'name': 'RefreshArtist',
                    'artistId': artistID,
                }),
            );
            return true;
        } catch (error) {
            logError('refreshArtist', 'Failed to refresh artist ($artistID)', error);
            return Future.error(error);
        }
    }

    Future<LidarrCatalogueData> getArtist(int artistID) async {
        try {
            Map<int, LidarrQualityProfile> _qualities = await getQualityProfiles().catchError((error) { return Future.error(error); });
            Map<int, LidarrMetadataProfile> _metadatas = await getMetadataProfiles().catchError((error) { return Future.error(error); });
            Response response = await _dio.get('artist/$artistID');
            return LidarrCatalogueData(
                title: response.data['artistName'] ?? 'Unknown Artist',
                sortTitle: response.data['sortName'] ?? 'Unknown Artist',
                overview: response.data['overview'] ?? 'No summary is available.',
                artistType: response.data['artistType'] ?? 'Unknown Artist Type',
                path: response.data['path'] ?? 'Unknown Path',
                artistID: response.data['id'] ?? 0,
                monitored: response.data['monitored'] ?? false,
                statistics: response.data['statistics'] ?? {},
                qualityProfile: response.data['qualityProfileId'] ?? 0,
                metadataProfile: response.data['metadataProfileId'] ?? 0,
                quality: response.data['qualityProfileId'] != null ? _qualities[response.data['qualityProfileId']].name ?? 'Unknown Quality Profile' : '',
                metadata: response.data['metadataProfileId'] != null ? _metadatas[response.data['metadataProfileId']].name ?? 'Unknown Metadata Profile' : '',
                genres: response.data['genres'] ?? [],
                links: response.data['links'] ?? [],
                albumFolders: response.data['albumFolder'] ?? false,
                foreignArtistID: response.data['foreignArtistId'] ?? '',
                sizeOnDisk: response.data['statistics'] != null ? response.data['statistics']['sizeOnDisk'] ?? 0 : 0,
            );
        } catch (error) {
            logError('getArtist', 'Failed to fetch artist ($artistID)', error);
            return Future.error(error);
        }
    }

    Future<bool> removeArtist(int artistID, { bool deleteFiles = false }) async {
        try {
            await _dio.delete(
                'artist/$artistID',
                queryParameters: {
                    'deleteFiles': deleteFiles,
                },
            );
            return true;
        } catch (error) {
            logError('removeArtist', 'Failed to remove artist ($artistID)', error);
            return Future.error(error);
        }
    }

    Future<bool> editArtist(int artistID, LidarrQualityProfile qualityProfile, LidarrMetadataProfile metadataProfile, String path, bool monitored, bool albumFolders) async {
        try {
            Response response = await _dio.get('artist/$artistID');
            Map artist = response.data;
            artist['monitored'] = monitored;
            artist['albumFolder'] = albumFolders;
            artist['path'] = path;
            artist['profileId'] = qualityProfile.id;
            artist['qualityProfileId'] = qualityProfile.id;
            artist['metadataProfileId'] = metadataProfile.id;
            response = await _dio.put(
                'artist',
                data: json.encode(artist),
            );
            return true;
        } catch (error) {
            logError('editArtist', 'Failed to edit artist ($artistID)', error);
            return Future.error(error);
        }
    }

    Future<List<LidarrAlbumData>> getArtistAlbums(int artistID) async {
        try {
            Response response = await _dio.get(
                'album',
                queryParameters: {
                    'artistId': artistID,
                }
            );
            List<LidarrAlbumData> entries = [];
            for(var entry in response.data) {
                entries.add(LidarrAlbumData(
                    albumID: entry['id'] ?? -1,
                    title: entry['title'] ?? 'Unknown Album Title',
                    monitored: entry['monitored'] ?? false,
                    trackCount: entry['statistics'] == null ? 0 : entry['statistics']['totalTrackCount'] ?? 0,
                    percentageTracks: entry['statistics'] == null ? 0 : entry['statistics']['percentOfTracks'] ?? 0,
                    releaseDate: entry['releaseDate'] ?? '',
                ));
            }
            entries.sort((a, b) {
                if(a.releaseDateObject == null) return 1;
                if(b.releaseDateObject == null) return -1;
                return b.releaseDateObject.compareTo(a.releaseDateObject);
            });
            return entries;
        } catch (error) {
            logError('getArtistAlbums', 'Failed to fetch albums ($artistID)', error);
            return Future.error(error);
        }
    }

    Future<LidarrAlbumData> getAlbum(int albumID) async {
        try {
            Response response = await _dio.get(
                'album',
                queryParameters: {
                    'albumIds': albumID,
                },
            );
            return LidarrAlbumData(
                albumID: response.data[0]['id'] ?? -1,
                title: response.data[0]['title'] ?? 'Unknown Album Title',
                monitored: response.data[0]['monitored'] ?? false,
                trackCount: response.data[0]['statistics'] == null ? 0 : response.data[0]['statistics']['totalTrackCount'] ?? 0,
                percentageTracks: response.data[0]['statistics'] == null ? 0 : response.data[0]['statistics']['percentOfTracks'] ?? 0,
                releaseDate: response.data[0]['releaseDate'] ?? '',
            );
        } catch (error) {
            logError('getAlbum', 'Failed to fetch album ($albumID)', error);
            return Future.error(error);
        }
    }

    Future<List<LidarrTrackData>> getAlbumTracks(int albumID) async {
        try {
            Response response = await _dio.get(
                'track',
                queryParameters: {
                    'albumId': albumID,
                },
            );
            List<LidarrTrackData> entries = [];
            for(var entry in response.data) {
                entries.add(LidarrTrackData(
                    trackID: entry['id'] ?? -1,
                    title: entry['title'] ?? 'Unknown Track Title',
                    trackNumber: entry['trackNumber'] ?? '',
                    duration: entry['duration'] ?? 0,
                    explicit: entry['explicit'] ?? false,
                    hasFile: entry['hasFile'] ?? false,
                ));
            }
            return entries;
        } catch (error) {
            logError('getAlbumTracks', 'Failed to fetch album tracks ($albumID)', error);
            return Future.error(error);
        }
    }

    Future<Map<int, LidarrQualityProfile>> getQualityProfiles() async {
        try {
            Response response = await _dio.get('qualityprofile');
            var _entries = new Map<int, LidarrQualityProfile>();
            for(var entry in response.data) {
                _entries[entry['id']] = LidarrQualityProfile(
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

    Future<Map<int, LidarrMetadataProfile>> getMetadataProfiles() async {
        try {
            Response response = await _dio.get('metadataprofile');
            var _entries = new Map<int, LidarrMetadataProfile>();
            for(var entry in response.data) {
                _entries[entry['id']] = LidarrMetadataProfile(
                    id: entry['id'] ?? -1,
                    name: entry['name'] ?? 'Unknown Metadata Profile',
                );
            }
            return _entries;
        } catch (error) {
            logError('getMetadataProfiles', 'Failed to fetch metadata profiles', error);
            return Future.error(error);
        }
    }

    Future<List<LidarrRootFolder>> getRootFolders() async {
        try {
            Response response = await _dio.get('rootfolder');
            List<LidarrRootFolder> _entries = [];
            for(var entry in response.data) {
                _entries.add(LidarrRootFolder(
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

    Future<List<LidarrHistoryData>> getHistory({ String sortKey = 'date',  String sortDir = 'desc', int pageSize = 250}) async {
        try {
            Response response = await _dio.get(
                'history',
                queryParameters: {
                    'sortKey': sortKey,
                    'pageSize': pageSize,
                    'sortDir': sortDir, 
                }
            );
            List<LidarrHistoryData> _entries = [];
            for(var entry in response.data['records']) {
                switch(entry['eventType']) {
                    case 'grabbed': {
                        _entries.add(LidarrHistoryDataGrabbed(
                            title: entry['sourceTitle'] ?? 'Unknown Title',
                            timestamp: entry['date'] ?? '',
                            indexer: entry['data']['indexer'] ?? 'Unknown Indexer',
                            artistID: entry['artistId'] ?? -1,
                            albumID: entry['albumId'] ?? -1,
                        ));
                        break;
                    }
                    case 'trackFileImported': {
                        _entries.add(LidarrHistoryDataTrackFileImported(
                            title: entry['sourceTitle'] ?? 'Unknown Title',
                            timestamp: entry['date'] ?? '',
                            quality: entry['quality']['quality']['name'] ?? 'Unknown Quality',
                            artistID: entry['artistId'] ?? -1,
                            albumID: entry['albumId'] ?? -1,
                        ));
                        break;
                    }
                    case 'albumImportIncomplete': {
                        _entries.add(LidarrHistoryDataAlbumImportIncomplete(
                            title: entry['sourceTitle'] ?? 'Unknown Title',
                            timestamp: entry['date'] ?? '',
                            artistID: entry['artistId'] ?? -1,
                            albumID: entry['albumId'] ?? -1,
                        ));
                        break;
                    }
                    case 'downloadImported': {
                        _entries.add(LidarrHistoryDataDownloadImported(
                            title: entry['sourceTitle'] ?? 'Unknown Title',
                            timestamp: entry['date'] ?? '',
                            quality: entry['quality']['quality']['name'] ?? 'Unknown Quality',
                            artistID: entry['artistId'] ?? -1,
                            albumID: entry['albumId'] ?? -1,
                        ));
                        break;
                    }
                    case 'trackFileDeleted': {
                        _entries.add(LidarrHistoryDataTrackFileDeleted(
                            title: entry['sourceTitle'] ?? 'Unknown Title',
                            timestamp: entry['date'] ?? '',
                            reason: entry['data']['reason'] ?? 'Unknown Reason',
                            artistID: entry['artistId'] ?? -1,
                            albumID: entry['albumId'] ?? -1,
                        ));
                        break;
                    }
                    case 'trackFileRenamed': {
                        _entries.add(LidarrHistoryDataTrackFileRenamed(
                            title: entry['sourceTitle'] ?? 'Unknown Title',
                            timestamp: entry['date'] ?? '',
                            artistID: entry['artistId'] ?? -1,
                            albumID: entry['albumId'] ?? -1,
                        ));
                        break;
                    }
                    default: {
                        _entries.add(LidarrHistoryDataGeneric(
                            title: entry['sourceTitle'] ?? 'Unknown Title',
                            timestamp: entry['date'] ?? '',
                            eventType: entry['eventType'] ?? 'Unknown Event Type',
                            artistID: entry['artistId'] ?? -1,
                            albumID: entry['albumId'] ?? -1,
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

    Future<List<LidarrMissingData>> getMissing({ int pageSize = 250, String sortDir = 'descending', String sortKey = 'releaseDate', bool monitored = true}) async {
        try {
            Response response = await _dio.get(
                'wanted/missing',
                queryParameters: {
                    'pageSize': pageSize,
                    'sortDirection': sortDir,
                    'sortKey': sortKey,
                    'monitored': monitored,
                }
            );
            List<LidarrMissingData> entries = [];
            for(var entry in response.data['records']) {
                entries.add(LidarrMissingData(
                    title: entry['title'] ?? 'Unknown Title',
                    artistTitle: entry['artist']['artistName'] ?? 'Unknown Artist Title',
                    artistID: entry['artistId'] ?? -1,
                    albumID: entry['id'] ?? -1,
                    releaseDate: entry['releaseDate'] ?? '',
                    monitored: entry['monitored'] ?? false,
                ));
            }
            return entries;
        } catch (error) {
            logError('getMissing', 'Failed to fetch missing albums', error);
            return Future.error(error);
        }
    }

    Future<bool> searchAlbums(List<int> albums) async {
        try {
            await _dio.post(
                'command',
                data: json.encode({
                    'name': 'AlbumSearch',
                    'albumIds': albums,
                }),
            );
            return true;
        } catch (error) {
            logError('searchAlbums', 'Failed to search for albums (${albums.toString()})', error);
            return Future.error(error);
        }
    }

    Future<bool> searchAllMissing() async {
        try {
            await _dio.post(
                'command',
                data: json.encode({
                    'name': 'MissingAlbumSearch',
                    'filterKey': 'monitored',
                    'filterValue': true,
                }),
            );
            return true;
        } catch (error) {
            logError('searchAllMissing', 'Failed to search for all missing albums', error);
            return Future.error(error);
        }
    }

    Future<bool> updateLibrary() async {
        try {
            await _dio.post(
                'command',
                data: json.encode({
                    'name': 'RefreshArtist',
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

    Future<bool> toggleArtistMonitored(int artistID, bool status) async {
        try {
            Response response = await _dio.get('artist/$artistID');
            Map body = response.data;
            body['monitored'] = status;
            response = await _dio.put(
                'artist',
                data: json.encode(body),
            );
            return true;
        } catch (error) {
            logError('toggleArtistMonitored', 'Failed to toggle artist monitored status ($artistID)', error);
            return Future.error(error);
        }
    }

    Future<bool> toggleAlbumMonitored(int albumID, bool status) async {
        try {
            Response response = await _dio.get(
                'album',
                queryParameters: {
                    'albumIds': albumID,
                }
            );
            Map body = response.data[0];
            body['monitored'] = status;
            response = await _dio.put(
                'album',
                data: json.encode(body),
            );
            return true;
        } catch (error) {
            logError('toggleAlbumMonitored', 'Failed to toggle album monitored status ($albumID)', error);
            return Future.error(error);
        }
    }

    Future<List<LidarrSearchData>> searchArtists(String search) async {
        if(search == '') return [];
        try {
            Response response = await _dio.get(
                'artist/lookup',
                queryParameters: {
                    'term': search,
                }
            );
            List<LidarrSearchData> entries = [];
            for(var entry in response.data) {
                entries.add(LidarrSearchData(
                    title: entry['artistName'] ?? 'Unknown Artist Name',
                    foreignArtistId: entry['foreignArtistId'] ?? '',
                    overview: entry['overview'] == null || entry['overview'] == '' ? 'No summary is available.' : entry['overview'],
                    tadbId: entry['tadbId'] ?? 0,
                    artistType: entry['artistType'] ?? 'Unknown Artist Type',
                    links: entry['links'] ?? [],
                    images: entry['images'] ?? [],
                ));
            }
            return entries;
        } catch (error) {
            logError('searchArtists', 'Failed to search ($search)', error);
            return Future.error(error);
        }
    }

    Future<bool> addArtist(LidarrSearchData entry, LidarrQualityProfile quality, LidarrRootFolder rootFolder, LidarrMetadataProfile metadata, bool monitored, bool albumFolders, {bool search = false}) async {
        try {
            await _dio.post(
                'artist',
                data: json.encode({
                    'ArtistName': entry.title,
                    'foreignArtistId': entry.foreignArtistId,
                    'qualityProfileId': quality.id,
                    'metadataProfileId': metadata.id,
                    'rootFolderPath': rootFolder.path,
                    'monitored': monitored,
                    'albumFolder': albumFolders,
                    'addOptions': {
                        'searchForMissingAlbums': search,
                    },
                }),
            );
            return true;
        } catch (error) {
            logError('addArtist', 'Failed to add artist (${entry.title})', error);
            return Future.error(error);
        }
    }

    Future<List<LidarrReleaseData>> getReleases(int albumID) async {
        try {
            Response response = await _dio.get(
                'release',
                queryParameters: {
                    'albumId': albumID,
                },
            );
            List<LidarrReleaseData> entries = [];
            for(var entry in response.data) {
                entries.add(LidarrReleaseData(
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
                ));
            }
            return entries;
        } catch (error) {
            logError('getReleases', 'Failed to fetch releases ($albumID)', error);
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
}
