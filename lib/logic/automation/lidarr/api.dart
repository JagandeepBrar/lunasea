import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lunasea/configuration/values.dart';
import 'package:lunasea/logic/automation/lidarr.dart';

class LidarrAPI {
    LidarrAPI._();
    
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
            return false;
        }
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
            }
        } catch (e) {
            return -1;
        }
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
                        ));
                    }
                    return entries;
                }
            }
        } catch (e) {
            return null;
        }
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
            }
        } catch (e) {
            return false;
        }
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
                    );
                }
            }
        } catch (e) {
            return null;
        }
        return null;
    }

    static Future<bool> removeArtist(int artistID) async {
        List<dynamic> values = Values.lidarrValues;
        if(values[0] == false) {
            return false;
        }
        try {
            String uri = '${values[1]}/api/v1/artist/$artistID?apikey=${values[2]}';
            http.Response response = await http.delete(
                Uri.encodeFull(uri),
            );
            if(response.statusCode == 200) {
                Map body = json.decode(response.body);
                if(body.length == 0) {
                    return true;
                }
            }
        } catch (e) {
            return false;
        }
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
                }
            }
        } catch (e) {
            return false;
        }
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
                }
            }
        } catch (e) {
            return null;
        }
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
                }
            }
        } catch (e) {
            return null;
        }
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
            }
        } catch (e) {
            return null;
        }
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
            }
        } catch (e) {
            return null;
        }
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
            }
        } catch (e) {
            return null;
        }
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
            }
        } catch (e) {
            return null;
        }
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
            }
        } catch (e) {
            return null;
        }
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
            }
        } catch (e) {
            return false;
        }
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
            }
        } catch (e) {
            return false;
        }
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
            }
        } catch (e) {
            return false;
        }
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
            }
        } catch (e) {
            return false;
        }
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
            }
        } catch (e) {
            return false;
        }
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
                }
            }
        } catch (e) {
            return false;
        }
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
                }
            }
        } catch (e) {
            return false;
        }
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
            }
        } catch (e) {
            return null;
        }
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
            }
        } catch (e) {
            return false;
        }
        return false;
    }

    static Future<List<LidarrReleaseEntry>> getReleases(int albumId) async {
        List<dynamic> values = Values.lidarrValues;
        if(values[0] == false) {
            return null;
        }
        try {
            String uri = '${values[1]}/api/v1/release?apikey=${values[2]}&albumId=$albumId';
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
            }
        } catch (e) {
            return null;
        }
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
            }
        } catch (e) {
            return false;
        }
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
            }
        } catch (e) {
            return null;
        }
        return null;
    }
}
