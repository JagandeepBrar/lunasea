import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lunasea/system.dart';
import 'package:lunasea/logic/automation/lidarr.dart';

class LidarrAPI {
    LidarrAPI._();

    static void logWarning(String methodName, String text) {
        Logger.warning('package:lunasea/logic/automation/lidarr/api.dart', methodName, 'Lidarr: $text');
    }

    static void logError(String methodName, String text, Object error) {
        Logger.error('package:lunasea/logic/automation/lidarr/api.dart', methodName, 'Lidarr: $text', error, StackTrace.current);
    }
    
    static Future<bool> testConnection(List<dynamic> values) async {
        try {
            String uri = '${values[1]}/api/v1/system/status?apikey=${values[2]}';
            http.Response response = await http.get(
                Uri.encodeFull(uri),
            );
            if(response.statusCode == 200) {
                Map body = json.decode(response.body);
                if(body.containsKey('version')) {
                    return true;
                }
            }
        } catch (e) {
            logError('testConnection', 'Connection test failed', e);
            return false;
        }
        logWarning('testConnection', 'Connection test failed');
        return false;
    }

    static Future<int> getArtistCount() async {
        List<dynamic> values = Values.lidarrValues;
        if(values[0] == false) {
            return -1;
        }
        try {
            String uri = '${values[1]}/api/v1/artist?apikey=${values[2]}';
            http.Response response = await http.get(
                Uri.encodeFull(uri),
            );
            if(response.statusCode == 200) {
                List body = json.decode(response.body);
                return body.length ?? 0;
            } else {
                logError('getArtistCount', '<GET> HTTP Status Code (${response.statusCode})', null);
            }
        } catch (e) {
            logError('getArtistCount', 'Failed to fetch artist count', e);
            return -1;
        }
        logWarning('getArtistCount', 'Failed to fetch artist count');
        return -1;
    }

    static Future<List<LidarrCatalogueEntry>> getAllArtists() async {
        List<dynamic> values = Values.lidarrValues;
        if(values[0] == false) {
            return null;
        }
        try {
            Map<int, LidarrQualityProfile> _qualities = await getQualityProfiles();
            Map<int, LidarrMetadataProfile> _metadatas = await getMetadataProfiles();
            if(_qualities != null && _metadatas != null) {
                String uri = '${values[1]}/api/v1/artist?apikey=${values[2]}';
                http.Response response = await http.get(
                    Uri.encodeFull(uri),
                );
                if(response.statusCode == 200) {
                    List<LidarrCatalogueEntry> entries = [];
                    List body = json.decode(response.body);
                    for(var entry in body) {
                        entries.add(LidarrCatalogueEntry(
                            entry['artistName'] ?? 'Unknown Artist',
                            entry['sortName'] ?? 'Unknown Artist',
                            entry['overview'] ?? 'No summary is available',
                            entry['path'] ?? 'Unknown Path',
                            entry['id'] ?? 0,
                            entry['monitored'] ?? false,
                            entry['statistics'] ?? {},
                            entry['qualityProfileId'] ?? 0,
                            entry['metadataProfileId'] ?? 0,
                            entry['qualityProfileId'] != null ? _qualities[entry['qualityProfileId']].name ?? 'Unknown Quality Profile' : '',
                            entry['metadataProfileId'] != null ? _metadatas[entry['metadataProfileId']].name ?? 'Unknown Metadata Profile' : '',
                            entry['genres'] ?? [],
                            entry['links'] ?? [],
                            entry['albumFolder'] ?? false,
                            entry['foreignArtistId'] ?? '',
                            entry['statistics'] != null ? entry['statistics']['sizeOnDisk'] ?? 0 : 0,
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

    static Future<List<String>> getAllArtistIDs() async {
        List<dynamic> values = Values.lidarrValues;
        if(values[0] == false) {
            return null;
        }
        try {
            String uri = '${values[1]}/api/v1/artist?apikey=${values[2]}';
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

    static Future<bool> refreshArtist(int artistID) async {
        List<dynamic> values = Values.lidarrValues;
        if(values[0] == false) {
            return false;
        }
        try {
            String uri = "${values[1]}/api/v1/command?apikey=${values[2]}";
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

    static Future<LidarrCatalogueEntry> getArtist(int artistID) async {
        List<dynamic> values = Values.lidarrValues;
        if(values[0] == false) {
            return null;
        }
        try {
            Map<int, LidarrQualityProfile> _qualities = await getQualityProfiles();
            Map<int, LidarrMetadataProfile> _metadatas = await getMetadataProfiles();
            if(_qualities != null && _metadatas != null) {
                String uri = '${values[1]}/api/v1/artist/$artistID?apikey=${values[2]}';
                http.Response response = await http.get(
                    Uri.encodeFull(uri),
                );
                if(response.statusCode == 200) {
                    Map body = json.decode(response.body);
                    return LidarrCatalogueEntry(
                        body['artistName'] ?? 'Unknown Artist',
                        body['sortName'] ?? 'Unknown Artist',
                        body['overview'] ?? 'No summary is available',
                        body['path'] ?? 'Unknown Path',
                        body['id'] ?? -1,
                        body['monitored'] ?? false,
                        body['statistics'] ?? {},
                        body['qualityProfileId'] ?? 0,
                        body['metadataProfileId'] ?? 0,
                        body['qualityProfileId'] != null ? _qualities[body['qualityProfileId']].name : '',
                        body['metadataProfileId'] != null ? _metadatas[body['metadataProfileId']].name : '',
                        body['genres'] ?? [],
                        body['links'] ?? [],
                        body['albumFolder'] ?? false,
                        body['foreignArtistId'] ?? '',
                        body['statistics'] != null ? body['statistics']['sizeOnDisk'] ?? 0 : 0,
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

    static Future<bool> removeArtist(int artistID, { deleteFiles = false }) async {
        List<dynamic> values = Values.lidarrValues;
        if(values[0] == false) {
            return false;
        }
        try {
            String uri = '${values[1]}/api/v1/artist/$artistID?apikey=${values[2]}&deleteFiles=$deleteFiles';
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

    static Future<bool> editArtist(int artistID, LidarrQualityProfile qualityProfile, LidarrMetadataProfile metadataProfile, String path, bool monitored, bool albumFolders) async {
        List<dynamic> values = Values.lidarrValues;
        if(values[0] == false) {
            return false;
        }
        try {
            String uriGet = '${values[1]}/api/v1/artist/$artistID?apikey=${values[2]}';
            String uriPut = '${values[1]}/api/v1/artist?apikey=${values[2]}';
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

    static Future<List<LidarrAlbumEntry>> getArtistAlbums(int artistID) async {
        List<dynamic> values = Values.lidarrValues;
        if(values[0] == false) {
            return null;
        }
        try {
            Map<int, LidarrQualityProfile> _qualities = await getQualityProfiles();
            if(_qualities != null) {
                String uri = '${values[1]}/api/v1/album?apikey=${values[2]}&artistId=$artistID';
                http.Response response = await http.get(
                    Uri.encodeFull(uri),
                );
                if(response.statusCode == 200) {
                    List body = json.decode(response.body);
                    List<LidarrAlbumEntry> entries = [];
                    for(var entry in body) {
                        entries.add(LidarrAlbumEntry(
                            entry['id'] ?? -1,
                            entry['title'] ?? 'Unknown Album Title',
                            entry['monitored'] ?? false,
                            entry['statistics'] == null ? 0 : entry['statistics']['totalTrackCount'] ?? 0,
                            entry['statistics'] == null ? 0 : entry['statistics']['percentOfTracks'] ?? 0,
                            entry['releaseDate'] ?? '',
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

    static Future<LidarrAlbumEntry> getAlbum(int albumID) async {
        List<dynamic> values = Values.lidarrValues;
        if(values[0] == false) {
            return null;
        }
        try {
            Map<int, LidarrQualityProfile> _qualities = await getQualityProfiles();
            if(_qualities != null) {
                String uri = '${values[1]}/api/v1/album?apikey=${values[2]}&albumIds=$albumID';
                http.Response response = await http.get(
                    Uri.encodeFull(uri),
                );
                if(response.statusCode == 200) {
                    List body = json.decode(response.body);
                    return LidarrAlbumEntry(
                        body[0]['id'] ?? -1,
                        body[0]['title'] ?? 'Unknown Album Title',
                        body[0]['monitored'] ?? false,
                        body[0]['statistics'] == null ? 0 : body[0]['statistics']['totalTrackCount'] ?? 0,
                        body[0]['statistics'] == null ? 0 : body[0]['statistics']['percentOfTracks'] ?? 0,
                        body[0]['releaseDate'] ?? '',
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

    static Future<List<LidarrTrackEntry>> getAlbumTracks(int albumID) async {
        List<dynamic> values = Values.lidarrValues;
        if(values[0] == false) {
            return null;
        }
        try {
            String uri = '${values[1]}/api/v1/track?apikey=${values[2]}&albumId=$albumID';
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

    static Future<Map<int, LidarrQualityProfile>> getQualityProfiles() async {
        List<dynamic> values = Values.lidarrValues;
        if(values[0] == false) {
            return null;
        }
        try {
            String uri = '${values[1]}/api/v1/qualityprofile?apikey=${values[2]}';
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

    static Future<Map<int, LidarrMetadataProfile>> getMetadataProfiles() async {
        List<dynamic> values = Values.lidarrValues;
        if(values[0] == false) {
            return null;
        }
        try {
            String uri = '${values[1]}/api/v1/metadataprofile?apikey=${values[2]}';
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

    static Future<List<LidarrHistoryEntry>> getHistory() async {
        List<dynamic> values = Values.lidarrValues;
        if(values[0] == false) {
            return null;
        }
        try {
            String uri = '${values[1]}/api/v1/history?apikey=${values[2]}&sortKey=date&pageSize=250&sortDir=desc';
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

    static Future<List<LidarrMissingEntry>> getMissing() async {
        List<dynamic> values = Values.lidarrValues;
        if(values[0] == false) {
            return null;
        }
        try {
            List<LidarrMissingEntry> entries = [];
            String uri = "${values[1]}/api/v1/wanted/missing?apikey=${values[2]}&pageSize=200&sortDirection=descending&sortKey=releaseDate&monitored=true";
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

    static Future<bool> searchAlbums(List<int> albums) async {
        List<dynamic> values = Values.lidarrValues;
        if(values[0] == false) {
            return false;
        }
        try {
            String uri = "${values[1]}/api/v1/command?apikey=${values[2]}";
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

    static Future<bool> searchAllMissing() async {
        List<dynamic> values = Values.lidarrValues;
        if(values[0] == false) {
            return false;
        }
        try {
            String uri = "${values[1]}/api/v1/command?apikey=${values[2]}";
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

    static Future<bool> updateLibrary() async {
        List<dynamic> values = Values.lidarrValues;
        if(values[0] == false) {
            return false;
        }
        try {
            String uri = "${values[1]}/api/v1/command?apikey=${values[2]}";
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

    static Future<bool> triggerRssSync() async {
        List<dynamic> values = Values.lidarrValues;
        if(values[0] == false) {
            return false;
        }
        try {
            String uri = "${values[1]}/api/v1/command?apikey=${values[2]}";
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

    static Future<bool> triggerBackup() async {
        List<dynamic> values = Values.lidarrValues;
        if(values[0] == false) {
            return false;
        }
        try {
            String uri = "${values[1]}/api/v1/command?apikey=${values[2]}";
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

    static Future<bool> toggleArtistMonitored(int artistID, bool status) async {
        List<dynamic> values = Values.lidarrValues;
        if(values[0] == false) {
            return false;
        }
        try {
            String uriGet = '${values[1]}/api/v1/artist/$artistID?apikey=${values[2]}';
            String uriPut = '${values[1]}/api/v1/artist?apikey=${values[2]}';
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

    static Future<bool> toggleAlbumMonitored(int albumID, bool status) async {
        List<dynamic> values = Values.lidarrValues;
        if(values[0] == false) {
            return false;
        }
        try {
            String uriGet = '${values[1]}/api/v1/album?apikey=${values[2]}&albumIds=$albumID';
            String uriPut = '${values[1]}/api/v1/album?apikey=${values[2]}';
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

    static Future<List<LidarrSearchEntry>> searchArtists(String search) async {
        List<dynamic> values = Values.lidarrValues;
        if(values[0] == false) {
            return null;
        }
        if(search == '') {
            return [];
        }
        try {
            List<LidarrSearchEntry> entries = [];
            String uri = '${values[1]}/api/v1/artist/lookup?term=$search&apikey=${values[2]}';
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

    static Future<bool> addArtist(LidarrSearchEntry entry, LidarrQualityProfile quality, LidarrRootFolder rootFolder, LidarrMetadataProfile metadata, bool monitored, bool albumFolders, {bool search = false}) async {
        List<dynamic> values = Values.lidarrValues;
        if(values[0] == false) {
            return false;
        }
        try {
            String uri = '${values[1]}/api/v1/artist?apikey=${values[2]}';
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

    static Future<List<LidarrReleaseEntry>> getReleases(int albumID) async {
        List<dynamic> values = Values.lidarrValues;
        if(values[0] == false) {
            return null;
        }
        try {
            String uri = '${values[1]}/api/v1/release?apikey=${values[2]}&albumId=$albumID';
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

    static Future<bool> downloadRelease(String guid, int indexerId) async {
        List<dynamic> values = Values.lidarrValues;
        if(values[0] == false) {
            return false;
        }
        try {
            String uri = '${values[1]}/api/v1/release?apikey=${values[2]}';
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

    static Future<List<LidarrRootFolder>> getRootFolders() async {
        List<dynamic> values = Values.lidarrValues;
        if(values[0] == false) {
            return null;
        }
        try {
            String uri = '${values[1]}/api/v1/rootfolder?apikey=${values[2]}';
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
