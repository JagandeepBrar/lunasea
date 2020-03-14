import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:lunasea/core.dart';
import '../abstract.dart';

class LidarrAPI extends API {
    final Map<String, dynamic> _values;
    final Dio _dio;

    LidarrAPI._internal(this._values, this._dio);
    factory LidarrAPI.from(ProfileHiveObject profile) => LidarrAPI._internal(
        profile.getLidarr(),
        Dio(
            BaseOptions(
                baseUrl: '${profile.getLidarr()['host']}/api/v1/',
                queryParameters: {
                    'apikey': profile.getLidarr()['key'],
                },
            ),
        ),
    );

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
            Map<int, LidarrQualityProfile> _qualities = await getQualityProfiles();
            Map<int, LidarrMetadataProfile> _metadatas = await getMetadataProfiles();
            if(_qualities != null && _metadatas != null) {
                String uri = '$host/api/v1/artist?apikey=$key';
                http.Response response = await http.get(
                    Uri.encodeFull(uri),
                );
                if(response.statusCode == 200) {
                    List<LidarrCatalogueData> entries = [];
                    List body = json.decode(response.body);
                    for(var entry in body) {
                        entries.add(LidarrCatalogueData(
                            title: entry['artistName'] ?? 'Unknown Artist',
                            sortTitle: entry['sortName'] ?? 'Unknown Artist',
                            overview: entry['overview'] ?? 'No summary is available',
                            path: entry['path'] ?? 'Unknown Path',
                            artistID: entry['id'] ?? 0,
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
                } else {
                    logError('getAllArtists', '<GET> HTTP Status Code (${response.statusCode})', null);
                }
            }
        } catch (e) {
            logError('getAllArtists', 'Failed to fetch artists', e);
            return null;
        }
        logWarning('getAllArtists', 'Failed to fetch artists');
        return null;
    }

    Future<List<String>> getAllArtistIDs() async {
        try {
            String uri = '$host/api/v1/artist?apikey=$key';
            http.Response response = await http.get(
                Uri.encodeFull(uri),
            );
            if(response.statusCode == 200) {
                List<String> _entries = [];
                List body = json.decode(response.body);
                for(var entry in body) {
                    _entries.add(entry['foreignArtistId'] ?? '');
                }
                return _entries;
            } else {
                logError('getAllArtistIDs', '<GET> HTTP Status Code (${response.statusCode})', null);
            }
        } catch (e) {
            logError('getAllArtistIDs', 'Failed to fetch artist IDs', e);
            return null;
        }
        logWarning('getAllArtistIDs', 'Failed to fetch artist IDs');
        return null;
    }

    Future<bool> refreshArtist(int artistID) async {
        try {
            String uri = "$host/api/v1/command?apikey=$key";
            http.Response response = await http.post(
                Uri.encodeFull(uri),
                headers: {
                    'Content-Type': 'application/json',
                },
                body: json.encode({
                    'name': 'RefreshArtist',
                    'artistId': artistID,
                }),
            );
            if(response.statusCode == 201) {
                Map body = json.decode(response.body);
                if(body.containsKey('status')) {
                    return true;
                }
            } else {
                logError('refreshArtist', '<POST> HTTP Status Code (${response.statusCode})', null);
            }
        } catch (e) {
            logError('refreshArtist', 'Failed to refresh artist ($artistID)', e);
            return false;
        }
        logWarning('refreshArtist', 'Failed to refresh artist ($artistID)');
        return false;
    }

    Future<LidarrCatalogueData> getArtist(int artistID) async {
        try {
            Map<int, LidarrQualityProfile> _qualities = await getQualityProfiles();
            Map<int, LidarrMetadataProfile> _metadatas = await getMetadataProfiles();
            if(_qualities != null && _metadatas != null) {
                String uri = '$host/api/v1/artist/$artistID?apikey=$key';
                http.Response response = await http.get(
                    Uri.encodeFull(uri),
                );
                if(response.statusCode == 200) {
                    Map body = json.decode(response.body);
                    return LidarrCatalogueData(
                        title: body['artistName'] ?? 'Unknown Artist',
                        sortTitle: body['sortName'] ?? 'Unknown Artist',
                        overview: body['overview'] ?? 'No summary is available',
                        path: body['path'] ?? 'Unknown Path',
                        artistID: body['id'] ?? 0,
                        monitored: body['monitored'] ?? false,
                        statistics: body['statistics'] ?? {},
                        qualityProfile: body['qualityProfileId'] ?? 0,
                        metadataProfile: body['metadataProfileId'] ?? 0,
                        quality: body['qualityProfileId'] != null ? _qualities[body['qualityProfileId']].name ?? 'Unknown Quality Profile' : '',
                        metadata: body['metadataProfileId'] != null ? _metadatas[body['metadataProfileId']].name ?? 'Unknown Metadata Profile' : '',
                        genres: body['genres'] ?? [],
                        links: body['links'] ?? [],
                        albumFolders: body['albumFolder'] ?? false,
                        foreignArtistID: body['foreignArtistId'] ?? '',
                        sizeOnDisk: body['statistics'] != null ? body['statistics']['sizeOnDisk'] ?? 0 : 0,
                    );
                } else {
                    logError('getArtist', '<GET> HTTP Status Code (${response.statusCode})', null);
                }
            }
        } catch (e) {
            logError('getArtist', 'Failed to fetch artist ($artistID)', e);
            return null;
        }
        logWarning('getArtist', 'Failed to fetch artist ($artistID)');
        return null;
    }

    Future<bool> removeArtist(int artistID, { deleteFiles = false }) async {
        try {
            String uri = '$host/api/v1/artist/$artistID?apikey=$key&deleteFiles=$deleteFiles';
            http.Response response = await http.delete(
                Uri.encodeFull(uri),
            );
            if(response.statusCode == 200) {
                Map body = json.decode(response.body);
                if(body.length == 0) {
                    return true;
                }
            } else {
                logError('removeArtist', '<DELETE> HTTP Status Code (${response.statusCode})', null);
            }
        } catch (e) {
            logError('removeArtist', 'Failed to remove artist ($artistID)', e);
            return false;
        }
        logWarning('removeArtist', 'Failed to remove artist ($artistID)');
        return false;
    }

    Future<bool> editArtist(int artistID, LidarrQualityProfile qualityProfile, LidarrMetadataProfile metadataProfile, String path, bool monitored, bool albumFolders) async {
        try {
            String uriGet = '$host/api/v1/artist/$artistID?apikey=$key';
            String uriPut = '$host/api/v1/artist?apikey=$key';
            http.Response response = await http.get(
                Uri.encodeFull(uriGet),
            );
            if(response.statusCode == 200) {
                Map artist = json.decode(response.body);
                artist['monitored'] = monitored;
                artist['albumFolder'] = albumFolders;
                artist['path'] = path;
                artist['profileId'] = qualityProfile.id;
                artist['qualityProfileId'] = qualityProfile.id;
                artist['metadataProfileId'] = metadataProfile.id;
                response = await http.put(
                    Uri.encodeFull(uriPut),
                    headers: {
                        'Content-Type': 'application/json',
                    },
                    body: json.encode(artist),
                );
                if(response.statusCode == 202) {
                    return true;
                } else {
                    logError('editArtist', '<PUT> HTTP Status Code (${response.statusCode})', null);
                }
            } else {
                logError('editArtist', '<GET> HTTP Status Code (${response.statusCode})', null);
            }
        } catch (e) {
            logError('editArtist', 'Failed to edit artist ($artistID)', e);
            return false;
        }
        logWarning('editArtist', 'Failed to edit artist ($artistID)');
        return false;
    }

    Future<List<LidarrAlbumData>> getArtistAlbums(int artistID) async {
        try {
            Map<int, LidarrQualityProfile> _qualities = await getQualityProfiles();
            if(_qualities != null) {
                String uri = '$host/api/v1/album?apikey=$key&artistId=$artistID';
                http.Response response = await http.get(
                    Uri.encodeFull(uri),
                );
                if(response.statusCode == 200) {
                    List body = json.decode(response.body);
                    List<LidarrAlbumData> entries = [];
                    for(var entry in body) {
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
                        if(a.releaseDateObject == null) {
                            return 1;
                        }
                        if(b.releaseDateObject == null) {
                            return -1;
                        }
                        return b.releaseDateObject.compareTo(a.releaseDateObject);
                    });
                    return entries;
                } else {
                    logError('getArtistAlbums', '<GET> HTTP Status Code (${response.statusCode})', null);
                }
            }
        } catch (e) {
            logError('getArtistAlbums', 'Failed to fetch albums ($artistID)', e);
            return null;
        }
        logWarning('getArtistAlbums', 'Failed to fetch albums ($artistID)');
        return null;
    }

    Future<LidarrAlbumData> getAlbum(int albumID) async {
        try {
            Map<int, LidarrQualityProfile> _qualities = await getQualityProfiles();
            if(_qualities != null) {
                String uri = '$host/api/v1/album?apikey=$key&albumIds=$albumID';
                http.Response response = await http.get(
                    Uri.encodeFull(uri),
                );
                if(response.statusCode == 200) {
                    List body = json.decode(response.body);
                    return LidarrAlbumData(
                        albumID: body[0]['id'] ?? -1,
                        title: body[0]['title'] ?? 'Unknown Album Title',
                        monitored: body[0]['monitored'] ?? false,
                        trackCount: body[0]['statistics'] == null ? 0 : body[0]['statistics']['totalTrackCount'] ?? 0,
                        percentageTracks: body[0]['statistics'] == null ? 0 : body[0]['statistics']['percentOfTracks'] ?? 0,
                        releaseDate: body[0]['releaseDate'] ?? '',
                    );
                } else {
                    logError('getAlbum', '<GET> HTTP Status Code (${response.statusCode})', null);
                }
            }
        } catch (e) {
            logError('getAlbum', 'Failed to fetch album ($albumID)', e);
            return null;
        }
        logWarning('getAlbum', 'Failed to fetch album ($albumID)');
        return null;
    }

    Future<List<LidarrTrackEntry>> getAlbumTracks(int albumID) async {
        try {
            String uri = '$host/api/v1/track?apikey=$key&albumId=$albumID';
            http.Response response = await http.get(
                Uri.encodeFull(uri),
            );
            if(response.statusCode == 200) {
                List body = json.decode(response.body);
                List<LidarrTrackEntry> entries = [];
                for(var entry in body) {
                    entries.add(LidarrTrackEntry(
                        entry['id'] ?? -1,
                        entry['title'] ?? 'Unknown Track Title',
                        entry['trackNumber'] ?? '',
                        entry['duration'] ?? 0,
                        entry['explicit'] ?? false,
                        entry['hasFile'] ?? false,
                    ));
                }
                return entries;
            } else {
                logError('getAlbumTracks', '<GET> HTTP Status Code (${response.statusCode})', null);
            }
        } catch (e) {
            logError('getAlbumTracks', 'Failed to fetch album tracks ($albumID)', e);
            return null;
        }
        logWarning('getAlbumTracks', 'Failed to fetch album tracks ($albumID)');
        return null;
    }

    Future<Map<int, LidarrQualityProfile>> getQualityProfiles() async {
        try {
            String uri = '$host/api/v1/qualityprofile?apikey=$key';
            http.Response response = await http.get(
                Uri.encodeFull(uri),
            );
            if(response.statusCode == 200) {
                List body = json.decode(response.body);
                var _entries = new Map<int, LidarrQualityProfile>();
                for(var entry in body) {
                    _entries[entry['id']] = LidarrQualityProfile(
                        entry['id'] ?? -1,
                        entry['name'] ?? 'Unknown Quality Profile',
                    );
                }
                return _entries;
            } else {
                logError('getQualityProfiles', '<GET> HTTP Status Code (${response.statusCode})', null);
            }
        } catch (e) {
            logError('getQualityProfiles', 'Failed to fetch quality profiles', e);
            return null;
        }
        logWarning('getQualityProfiles', 'Failed to fetch quality profiles');
        return null;
    }

    Future<Map<int, LidarrMetadataProfile>> getMetadataProfiles() async {
        try {
            String uri = '$host/api/v1/metadataprofile?apikey=$key';
            http.Response response = await http.get(
                Uri.encodeFull(uri),
            );
            if(response.statusCode == 200) {
                List body = json.decode(response.body);
                var _entries = new Map<int, LidarrMetadataProfile>();
                for(var entry in body) {
                    _entries[entry['id']] = LidarrMetadataProfile(
                        entry['id'] ?? -1,
                        entry['name'] ?? 'Unknown Metadata Profile',
                    );
                }
                return _entries;
            } else {
                logError('getMetadataProfiles', '<GET> HTTP Status Code (${response.statusCode})', null);
            }
        } catch (e) {
            logError('getMetadataProfiles', 'Failed to fetch metadata profiles', e);
            return null;
        }
        logWarning('getMetadataProfiles', 'Failed to fetch metadata profiles');
        return null;
    }

    Future<List<LidarrHistoryEntry>> getHistory() async {
        try {
            String uri = '$host/api/v1/history?apikey=$key&sortKey=date&pageSize=250&sortDir=desc';
            http.Response response = await http.get(
                Uri.encodeFull(uri),
            );
            if(response.statusCode == 200) {
                List<LidarrHistoryEntry> _entries = [];
                Map body = json.decode(response.body);
                for(var entry in body['records']) {
                    switch(entry['eventType']) {
                        case 'grabbed': {
                            _entries.add(LidarrHistoryEntryGrabbed(
                                entry['sourceTitle'] ?? 'Unknown Title',
                                entry['date'] ?? '',
                                entry['data']['indexer'] ?? 'Unknown Indexer',
                                entry['artistId'] ?? -1,
                                entry['albumId'] ?? -1,
                            ));
                            break;
                        }
                        case 'trackFileImported': {
                            _entries.add(LidarrHistoryEntryTrackFileImported(
                                entry['sourceTitle'] ?? 'Unknown Title',
                                entry['date'] ?? '',
                                entry['quality']['quality']['name'] ?? 'Unknown Quality',
                                entry['artistId'] ?? -1,
                                entry['albumId'] ?? -1,
                            ));
                            break;
                        }
                        case 'albumImportIncomplete': {
                            _entries.add(LidarrHistoryEntryAlbumImportIncomplete(
                                entry['sourceTitle'] ?? 'Unknown Title',
                                entry['date'] ?? '',
                                entry['artistId'] ?? -1,
                                entry['albumId'] ?? -1,
                            ));
                            break;
                        }
                        case 'downloadImported': {
                            _entries.add(LidarrHistoryEntryDownloadImported(
                                entry['sourceTitle'] ?? 'Unknown Title',
                                entry['date'] ?? '',
                                entry['quality']['quality']['name'] ?? 'Unknown Quality',
                                entry['artistId'] ?? -1,
                                entry['albumId'] ?? -1,
                            ));
                            break;
                        }
                        case 'trackFileDeleted': {
                            _entries.add(LidarrHistoryEntryTrackFileDeleted(
                                entry['sourceTitle'] ?? 'Unknown Title',
                                entry['date'] ?? '',
                                entry['data']['reason'] ?? 'Unknown Reason',
                                entry['artistId'] ?? -1,
                                entry['albumId'] ?? -1,
                            ));
                            break;
                        }
                        case 'trackFileRenamed': {
                            _entries.add(LidarrHistoryEntryTrackFileRenamed(
                                entry['sourceTitle'] ?? 'Unknown Title',
                                entry['date'] ?? '',
                                entry['artistId'] ?? -1,
                                entry['albumId'] ?? -1,
                            ));
                            break;
                        }
                        default: {
                            _entries.add(LidarrHistoryEntryGeneric(
                                entry['sourceTitle'] ?? 'Unknown Title',
                                entry['date'] ?? '',
                                entry['eventType'] ?? 'Unknown Event Type',
                                entry['artistId'] ?? -1,
                                entry['albumId'] ?? -1,
                            ));
                            break;
                        }
                    }
                }
                return _entries;
            } else {
                logError('getHistory', '<GET> HTTP Status Code (${response.statusCode})', null);
            }
        } catch (e) {
            logError('getHistory', 'Failed to fetch history', e);
            return null;
        }
        logWarning('getHistory', 'Failed to fetch history');
        return null;
    }

    Future<List<LidarrMissingEntry>> getMissing() async {
        try {
            List<LidarrMissingEntry> entries = [];
            String uri = "$host/api/v1/wanted/missing?apikey=$key&pageSize=200&sortDirection=descending&sortKey=releaseDate&monitored=true";
            http.Response response = await http.get(
                Uri.encodeFull(uri),
            );
            if(response.statusCode == 200) {
                Map body = json.decode(response.body);
                for(var entry in body['records']) {
                    entries.add(LidarrMissingEntry(
                        entry['title'] ?? 'Unknown Title',
                        entry['artist']['artistName'] ?? 'Unknown Artist Title',
                        entry['artistId'] ?? -1,
                        entry['id'] ?? -1,
                        entry['releaseDate'] ?? '',
                        entry['monitored'] ?? false,
                    ));
                }
                return entries;
            } else {
                logError('getMissing', '<GET> HTTP Status Code (${response.statusCode})', null);
            }
        } catch (e) {
            logError('getMissing', 'Failed to fetch missing albums', e);
            return null;
        }
        logWarning('getMissing', 'Failed to fetch missing albums');
        return null;
    }

    Future<bool> searchAlbums(List<int> albums) async {
        try {
            String uri = "$host/api/v1/command?apikey=$key";
            http.Response response = await http.post(
                Uri.encodeFull(uri),
                headers: {
                    'Content-Type': 'application/json',
                },
                body: json.encode({
                    'name': 'AlbumSearch',
                    'albumIds': albums,
                }),
            );
            if(response.statusCode == 201) {
                Map body = json.decode(response.body);
                if(body.containsKey('status')) {
                    return true;
                }
            } else {
                logError('searchAlbums', '<POST> HTTP Status Code (${response.statusCode})', null);
            }
        } catch (e) {
            logError('searchAlbums', 'Failed to search for albums (${albums.toString()})', e);
            return false;
        }
        logWarning('searchAlbums', 'Failed to search for albums (${albums.toString()})');
        return false;
    }

    Future<bool> searchAllMissing() async {
        try {
            String uri = "$host/api/v1/command?apikey=$key";
            http.Response response = await http.post(
                Uri.encodeFull(uri),
                headers: {
                    'Content-Type': 'application/json',
                },
                body: json.encode({
                    'name': 'MissingAlbumSearch',
                    'filterKey': 'monitored',
                    'filterValue': true,
                }),
            );
            if(response.statusCode == 201) {
                Map body = json.decode(response.body);
                if(body.containsKey('status')) {
                    return true;
                }
            } else {
                logError('searchAllMissing', '<POST> HTTP Status Code (${response.statusCode})', null);
            }
        } catch (e) {
            logError('searchAllMissing', 'Failed to search for all missing albums', e);
            return false;
        }
        logWarning('searchAllMissing', 'Failed to search for all missing albums');
        return false;
    }

    Future<bool> updateLibrary() async {
        try {
            String uri = "$host/api/v1/command?apikey=$key";
            http.Response response = await http.post(
                Uri.encodeFull(uri),
                headers: {
                    'Content-Type': 'application/json',
                },
                body: json.encode({
                    'name': 'RefreshArtist',
                }),
            );
            if(response.statusCode == 201) {
                Map body = json.decode(response.body);
                if(body.containsKey('status')) {
                    return true;
                }
            } else {
                logError('updateLibrary', '<POST> HTTP Status Code (${response.statusCode})', null);
            }
        } catch (e) {
            logError('updateLibrary', 'Failed to update library', e);
            return false;
        }
        logWarning('updateLibrary', 'Failed to update library');
        return false;
    }

    Future<bool> triggerRssSync() async {
        try {
            String uri = "$host/api/v1/command?apikey=$key";
            http.Response response = await http.post(
                Uri.encodeFull(uri),
                headers: {
                    'Content-Type': 'application/json',
                },
                body: json.encode({
                    'name': 'RssSync',
                }),
            );
            if(response.statusCode == 201) {
                Map body = json.decode(response.body);
                if(body.containsKey('status')) {
                    return true;
                }
            } else {
                logError('triggerRssSync', '<POST> HTTP Status Code (${response.statusCode})', null);
            }
        } catch (e) {
            logError('triggerRssSync', 'Failed to trigger RSS sync', e);
            return false;
        }
        logWarning('triggerRssSync', 'Failed to trigger RSS sync');
        return false;
    }

    Future<bool> triggerBackup() async {
        try {
            String uri = "$host/api/v1/command?apikey=$key";
            http.Response response = await http.post(
                Uri.encodeFull(uri),
                headers: {
                    'Content-Type': 'application/json',
                },
                body: json.encode({
                    'name': 'Backup',
                }),
            );
            if(response.statusCode == 201) {
                Map body = json.decode(response.body);
                if(body.containsKey('status')) {
                    return true;
                }
            } else {
                logError('triggerBackup', '<POST> HTTP Status Code (${response.statusCode})', null);
            }
        } catch (e) {
            logError('triggerBackup', 'Failed to backup database', e);
            return false;
        }
        logWarning('triggerBackup', 'Failed to backup database');
        return false;
    }

    Future<bool> toggleArtistMonitored(int artistID, bool status) async {
        try {
            String uriGet = '$host/api/v1/artist/$artistID?apikey=$key';
            String uriPut = '$host/api/v1/artist?apikey=$key';
            http.Response response = await http.get(
                Uri.encodeFull(uriGet),
            );
            if(response.statusCode == 200) {
                Map body = json.decode(response.body);
                body['monitored'] = status;
                response = await http.put(
                    Uri.encodeFull(uriPut),
                    body: json.encode(body),
                    headers: {
                        'Content-Type': 'application/json',
                    },
                );
                if(response.statusCode == 202) {
                    return true;
                } else {
                    logError('toggleArtistMonitored', '<PUT> HTTP Status Code (${response.statusCode})', null);
                }
            } else {
                logError('toggleArtistMonitored', '<GET> HTTP Status Code (${response.statusCode})', null);
            }
        } catch (e) {
            logError('toggleArtistMonitored', 'Failed to toggle artist monitored status ($artistID)', e);
            return false;
        }
        logWarning('toggleArtistMonitored', 'Failed to toggle artist monitored status ($artistID)');
        return false;
    }

    Future<bool> toggleAlbumMonitored(int albumID, bool status) async {
        try {
            String uriGet = '$host/api/v1/album?apikey=$key&albumIds=$albumID';
            String uriPut = '$host/api/v1/album?apikey=$key';
            http.Response response = await http.get(
                Uri.encodeFull(uriGet),
            );
            if(response.statusCode == 200) {
                List body = json.decode(response.body);
                body[0]['monitored'] = status;
                response = await http.put(
                    Uri.encodeFull(uriPut),
                    body: json.encode(body[0]),
                    headers: {
                        'Content-Type': 'application/json',
                    },
                );
                if(response.statusCode == 202) {
                    return true;
                } else {
                    logError('downloadRelease', '<PUT> HTTP Status Code (${response.statusCode})', null);
                }
            } else {
                logError('downloadRelease', '<GET> HTTP Status Code (${response.statusCode})', null);
            }
        } catch (e) {
            logError('toggleAlbumMonitored', 'Failed to toggle album monitored status ($albumID)', e);
            return false;
        }
        logWarning('toggleAlbumMonitored', 'Failed to toggle album monitored status ($albumID)');
        return false;
    }

    Future<List<LidarrSearchEntry>> searchArtists(String search) async {
        if(search == '') {
            return [];
        }
        try {
            List<LidarrSearchEntry> entries = [];
            String uri = '$host/api/v1/artist/lookup?term=$search&apikey=$key';
            http.Response response = await http.get(
                Uri.encodeFull(uri),
            );
            if(response.statusCode == 200) {
                List body = json.decode(response.body);
                for(var entry in body) {
                    entries.add(LidarrSearchEntry(
                        entry['artistName'] ?? 'Unknown Artist Name',
                        entry['foreignArtistId'] ?? '',
                        entry['overview'] == null || entry['overview'] == '' ? 'No summary is available' : entry['overview'],
                        entry['tadbId'] ?? 0,
                        entry['artistType'] ?? 'Unknown Artist Type',
                        entry['links'] ?? [],
                        entry['images'] ?? [],
                    ));
                }
                return entries;
            } else {
                logError('searchArtists', '<GET> HTTP Status Code (${response.statusCode})', null);
            }
        } catch (e) {
            logError('searchArtists', 'Failed to search ($search)', e);
            return null;
        }
        logWarning('searchArtists', 'Failed to search ($search)');
        return null;
    }

    Future<bool> addArtist(LidarrSearchEntry entry, LidarrQualityProfile quality, LidarrRootFolder rootFolder, LidarrMetadataProfile metadata, bool monitored, bool albumFolders, {bool search = false}) async {
        try {
            String uri = '$host/api/v1/artist?apikey=$key';
            http.Response response = await http.post(
                Uri.encodeFull(uri),
                headers: {
                    'Content-Type': 'application/json',
                },
                body: json.encode({
                    'ArtistName': entry.title,
                    'foreignArtistId': entry.foreignArtistId,
                    'qualityProfileId': quality.id,
                    'metadataProfileId': metadata.id,
                    'rootFolderPath': rootFolder.path,
                    'monitored': monitored,
                    'albumFolder': albumFolders,
                    'addOptions': {
                        'searchForMissingAlbums': search,
                    }
                }),
            );
            if(response.statusCode == 201) {
                return true;
            } else {
                logError('addArtist', '<POST> HTTP Status Code (${response.statusCode})', null);
            }
        } catch (e) {
            logError('addArtist', 'Failed to add artist (${entry.title})', e);
            return false;
        }
        logWarning('addArtist', 'Failed to add artist (${entry.title})');
        return false;
    }

    Future<List<LidarrReleaseEntry>> getReleases(int albumID) async {
        try {
            String uri = '$host/api/v1/release?apikey=$key&albumId=$albumID';
            http.Response response = await http.get(
                Uri.encodeFull(uri),
            );
            if(response.statusCode == 200) {
                List body = json.decode(response.body);
                List<LidarrReleaseEntry> entries = [];
                for(var entry in body) {
                    entries.add(LidarrReleaseEntry(
                        entry['title'] ?? 'Unknown Title',
                        entry['guid'] ?? '',
                        entry['quality']['quality']['name'] ?? 'Unknown',
                        entry['protocol'] ?? 'Unknown Protocol',
                        entry['indexer'] ?? 'Unknown Indexer',
                        entry['infoUrl'] ?? '',
                        entry['approved'] ?? false,
                        entry['releaseWeight'] ?? 0,
                        entry['size'] ?? 0,
                        entry['indexerId'] ?? 0,
                        entry['ageHours'] ?? 0,
                        entry['rejections'] ?? [],
                        entry['seeders'] ?? 0,
                        entry['leechers'] ?? 0,
                    ));
                }
                return entries;
            } else {
                logError('getReleases', '<GET> HTTP Status Code (${response.statusCode})', null);
            }
        } catch (e) {
            logError('getReleases', 'Failed to fetch releases ($albumID)', e);
            return null;
        }
        logWarning('getReleases', 'Failed to fetch releases ($albumID)');
        return null;
    }

    Future<bool> downloadRelease(String guid, int indexerId) async {
        try {
            String uri = '$host/api/v1/release?apikey=$key';
            http.Response response = await http.post(
                Uri.encodeFull(uri),
                headers: {
                    'Content-Type': 'application/json',
                },
                body: json.encode({
                    'guid': guid,
                    'indexerId': indexerId,
                })
            );
            if(response.statusCode == 200) {
                return true;
            } else {
                logError('downloadRelease', '<POST> HTTP Status Code (${response.statusCode})', null);
            }
        } catch (e) {
            logError('downloadRelease', 'Failed to download release ($guid)', e);
            return false;
        }
        logWarning('downloadRelease', 'Failed to download release ($guid)');
        return false;
    }

    Future<List<LidarrRootFolder>> getRootFolders() async {
        try {
            String uri = '$host/api/v1/rootfolder?apikey=$key';
            http.Response response = await http.get(
                Uri.encodeFull(uri),
            );
            if(response.statusCode == 200) {
                List body = json.decode(response.body);
                List<LidarrRootFolder> _entries = [];
                for(var entry in body) {
                    _entries.add(LidarrRootFolder(
                        entry['id'] ?? -1,
                        entry['path'] ?? 'Unknown Root Folder',
                    ));
                }
                return _entries;
            } else {
                logError('getRootFolders', '<GET> HTTP Status Code (${response.statusCode})', null);
            }
        } catch (e) {
            logError('getRootFolders', 'Failed to fetch root folders', e);
            return null;
        }
        logWarning('getRootFolders', 'Failed to fetch root folders');
        return null;
    }
}
