import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lunasea/configuration/values.dart';
import 'package:lunasea/logic/automation/radarr.dart';

class RadarrAPI {
    RadarrAPI._();
    
    static Future<bool> testConnection(List<dynamic> values) async {
        if(values[0] == false) {
            return true;
        }
        try {
            String uri = '${values[1]}/api/system/status?apikey=${values[2]}';
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

    static Future<bool> addMovie(RadarrSearchEntry entry, RadarrQualityProfile quality, RadarrRootFolder rootFolder, RadarrAvailabilityEntry minAvailability, bool monitored) async {
        List<dynamic> values = Values.radarrValues;
        if(values[0] == false) {
            return false;
        }
        try {
            String uri = '${values[1]}/api/movie?apikey=${values[2]}';
            http.Response response = await http.post(
                Uri.encodeFull(uri),
                headers: {
                    'Content-Type': 'application/json',
                },
                body: json.encode({
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
                        'searchForMovie': false,
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

    static Future<bool> refreshMovie(int id) async {
        List<dynamic> values = Values.radarrValues;
        if(values[0] == false) {
            return false;
        }
        try {
            String uri = '${values[1]}/api/command?apikey=${values[2]}';
            http.Response response = await http.post(
                Uri.encodeFull(uri),
                headers: {
                    'Content-Type': 'application/json',
                },
                body: json.encode({
                    'name': 'RefreshMovie',
                    'movieId': id,
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
        List<dynamic> values = Values.radarrValues;
        if(values[0] == false) {
            return false;
        }
        try {
            String uri = '${values[1]}/api/command?apikey=${values[2]}';
            http.Response response = await http.post(
                Uri.encodeFull(uri),
                headers: {
                    'Content-Type': 'application/json',
                },
                body: json.encode({
                    'name': 'RefreshMovie',
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
        List<dynamic> values = Values.radarrValues;
        if(values[0] == false) {
            return false;
        }
        try {
            String uri = '${values[1]}/api/command?apikey=${values[2]}';
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
        List<dynamic> values = Values.radarrValues;
        if(values[0] == false) {
            return false;
        }
        try {
            String uri = '${values[1]}/api/command?apikey=${values[2]}';
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

    static Future<bool> editMovie(int movieID, RadarrQualityProfile qualityProfile, RadarrAvailabilityEntry availability, String path, bool monitored, bool staticPath) async {
        List<dynamic> values = Values.radarrValues;
        if(values[0] == false) {
            return false;
        }
        try {
            String uriGet = '${values[1]}/api/movie/$movieID?apikey=${values[2]}';
            String uriPut = '${values[1]}/api/movie?apikey=${values[2]}';
            http.Response response = await http.get(
                Uri.encodeFull(uriGet),
            );
            if(response.statusCode == 200) {
                Map movie = json.decode(response.body);
                movie['monitored'] = monitored;
                movie['minimumAvailability'] = availability.id;
                movie['profileId'] = qualityProfile.id;
                movie['path'] = path;
                movie['pathState'] = staticPath ? 'static' : 'dynamic';
                response = await http.put(
                    Uri.encodeFull(uriPut),
                    headers: {
                        'Content-Type': 'application/json',
                    },
                    body: json.encode(movie),
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

    static Future<bool> removeMovie(int id) async {
        List<dynamic> values = Values.radarrValues;
        if(values[0] == false) {
            return false;
        }
        try {
            String uri = '${values[1]}/api/movie/$id?apikey=${values[2]}';
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

    static Future<int> getMovieCount() async {
        List<dynamic> values = Values.radarrValues;
        if(values[0] == false) {
            return -1;
        }
        try {
            String uri = '${values[1]}/api/movie?apikey=${values[2]}';
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

    static Future<List<RadarrCatalogueEntry>> getAllMovies() async {
        List<dynamic> values = Values.radarrValues;
        if(values[0] == false) {
            return null;
        }
        try {
            Map<int, RadarrQualityProfile> _qualities = await getQualityProfiles();
            if(_qualities != null) {
                String uri = '${values[1]}/api/movie?apikey=${values[2]}';
                http.Response response = await http.get(
                    Uri.encodeFull(uri),
                );
                if(response.statusCode == 200) {
                    List<RadarrCatalogueEntry> entries = [];
                    List body = json.decode(response.body);
                    for(var entry in body) {
                        entries.add(
                            RadarrCatalogueEntry(
                                entry['title'] ?? 'Unknown Title',
                                entry['sortTitle'] ?? 'Unknown Title',
                                entry['studio'] ?? 'Unknown Studio',
                                entry['physicalRelease'] ?? '',
                                entry['inCinemas'] ?? '',
                                entry['status'] ?? 'Unknown Status',
                                entry['year'] ?? 0,
                                entry['id'] ?? -1,
                                entry['monitored'] ?? false,
                                entry['downloaded'] ?? false,
                                entry['sizeOnDisk'] ?? 0,
                                entry['runtime'] ?? 0,
                                entry['profileId'] != null ? _qualities[entry['qualityProfileId']].name : '',
                                entry['downloaded'] ? entry['movieFile'] : null,
                                entry['overview'] ?? 'No summary is available',
                                entry['path'] ?? 'Unknown Path',
                                entry['profileId'] ?? -1,
                                entry['minimumAvailability'] ?? '',
                                entry['youTubeTrailerId'] ?? '',
                                entry['imdbId'] ?? '',
                                entry['tmdbId'] ?? 0,
                                entry['pathState'] == 'static' ? true : false,
                            ),
                        );
                    }
                    return entries;
                }
            }
        } catch (e) {
            return null;
        }
        return null;
    }

    static Future<RadarrCatalogueEntry> getMovie(int id) async {
        List<dynamic> values = Values.radarrValues;
        if(values[0] == false) {
            return null;
        }
        try {
            Map<int, RadarrQualityProfile> _qualities = await getQualityProfiles();
            if(_qualities != null) {
                String uri = '${values[1]}/api/movie/$id?apikey=${values[2]}';
                http.Response response = await http.get(
                    Uri.encodeFull(uri),
                );
                if(response.statusCode == 200) {
                    Map body = json.decode(response.body);
                    return RadarrCatalogueEntry(
                        body['title'] ?? 'Unknown Title',
                        body['sortTitle'] ?? 'Unknown Title',
                        body['studio'] ?? 'Unknown Studio',
                        body['physicalRelease'] ?? '',
                        body['inCinemas'] ?? '',
                        body['status'] ?? 'Unknown Status',
                        body['year'] ?? 0,
                        body['id'] ?? -1,
                        body['monitored'] ?? false,
                        body['downloaded'] ?? false,
                        body['sizeOnDisk'] ?? 0,
                        body['runtime'] ?? 0,
                        body['profileId'] != null ? _qualities[body['qualityProfileId']].name : '',
                        body['downloaded'] ? body['movieFile'] : null,
                        body['overview'] ?? 'No summary is available',
                        body['path'] ?? 'Unknown Path',
                        body['profileId'] ?? -1,
                        body['minimumAvailability'] ?? '',
                        body['youTubeTrailerId'] ?? '',
                        body['imdbId'] ?? '',
                        body['tmdbId'] ?? 0,
                        body['pathState'] == 'static' ? true : false,
                    );
                }
            }
        } catch (e) {
            return null;
        }
        return null;
    }

    static Future<bool> removeMovieFile(int id) async {
        List<dynamic> values = Values.radarrValues;
        if(values[0] == false) {
            return false;
        }
        try {
            String uri = '${values[1]}/api/moviefile/$id?apikey=${values[2]}';
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

    static Future<List<RadarrMissingEntry>> getMissing() async {
        List<dynamic> values = Values.radarrValues;
        if(values[0] == false) {
            return null;
        }
        try {
            Map<int, RadarrQualityProfile> _qualities = await getQualityProfiles();
            if(_qualities != null) {
                String uri = '${values[1]}/api/movie?apikey=${values[2]}';
                http.Response response = await http.get(
                    Uri.encodeFull(uri),
                );
                if(response.statusCode == 200) {
                    List<RadarrMissingEntry> _availableEntries = [];
                    List<RadarrMissingEntry> _cinemaEntries = [];
                    List<RadarrMissingEntry> _announcedEntries = [];
                    List body = json.decode(response.body);
                    for(var entry in body) {
                        if(!entry['downloaded'] && entry['monitored']) {
                            if(entry['status'] == 'released') {
                                _availableEntries.add(
                                    RadarrMissingEntry(
                                        entry['id'] ?? -1,
                                        entry['title'] ?? 'Unknown Title',
                                        entry['sortTitle'] ?? 'Unknown Title',
                                        entry['studio'] ?? 'Unknown Studio',
                                        entry['physicalRelease'] ?? '',
                                        entry['inCinemas'] ?? '',
                                        entry['profileId'] != null ? _qualities[entry['qualityProfileId']].name : '',
                                        entry['year'] ?? 0,
                                        entry['runtime'] ?? 0,
                                        entry['status'] ?? 'Unknown Status',
                                    ),
                                );
                            }
                            if(entry['status'] == 'inCinemas') {
                                _cinemaEntries.add(
                                    RadarrMissingEntry(
                                        entry['id'] ?? -1,
                                        entry['title'] ?? 'Unknown Title',
                                        entry['sortTitle'] ?? 'Unknown Title',
                                        entry['studio'] ?? 'Unknown Studio',
                                        entry['physicalRelease'] ?? '',
                                        entry['inCinemas'] ?? '',
                                        entry['profileId'] != null ? _qualities[entry['qualityProfileId']].name : '',
                                        entry['year'] ?? 0,
                                        entry['runtime'] ?? 0,
                                        entry['status'] ?? 'Unknown Status',
                                    ),
                                );
                            }
                            if(entry['status'] == 'announced') {
                                _announcedEntries.add(
                                    RadarrMissingEntry(
                                        entry['id'] ?? -1,
                                        entry['title'] ?? 'Unknown Title',
                                        entry['sortTitle'] ?? 'Unknown Title',
                                        entry['studio'] ?? 'Unknown Studio',
                                        entry['physicalRelease'] ?? '',
                                        entry['inCinemas'] ?? '',
                                        entry['profileId'] != null ? _qualities[entry['qualityProfileId']].name : '',
                                        entry['year'] ?? 0,
                                        entry['runtime'] ?? 0,
                                        entry['status'] ?? 'Unknown Status',
                                    ),
                                );
                            }
                        }
                    }
                    //Sort the lists by the appropriate dates
                    _availableEntries.sort((a,b) {
                        if(a.physicalReleaseObject == null) return 1;
                        if(b.physicalReleaseObject == null) return -1;
                        return b.physicalReleaseObject.compareTo(a.physicalReleaseObject);
                    });
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
                    return [_availableEntries, _cinemaEntries, _announcedEntries].expand((x) => x).toList();
                }
            }
        } catch (e) {
            return null;
        }
        return null;
    }

    static Future<List<RadarrHistoryEntry>> getHistory() async {
        List<dynamic> values = Values.radarrValues;
        if(values[0] == false) {
            return null;
        }
        try {
            String uri = '${values[1]}/api/history?apikey=${values[2]}&sortKey=date&pageSize=250&sortDir=desc';
            http.Response response = await http.get(
                Uri.encodeFull(uri),
            );
            if(response.statusCode == 200) {
                List<RadarrHistoryEntry> _entries = [];
                Map body = json.decode(response.body);
                for(var entry in body['records']) {
                    switch(entry['eventType']) {
                        case 'downloadFolderImported': {
                            _entries.add(RadarrHistoryEntryDownloadImported(
                                entry['movie']['title'] ?? 'Unknown Title',
                                entry['date'] ?? '',
                                entry['quality']['quality']['name'] ?? 'Unknown Quality',
                            ));
                            break;
                        }
                        case 'downloadFailed': {
                            _entries.add(RadarrHistoryEntryDownloadFailed(
                                entry['movie']['title'] ?? 'Unknown Title',
                                entry['date'] ?? '',
                            ));
                            break;
                        }
                        case 'movieFileDeleted': {
                            _entries.add(RadarrHistoryEntryFileDeleted(
                                entry['movie']['title'] ?? 'Unknown Title',
                                entry['date'] ?? '',
                                entry['data']['reason'] ?? 'Unknown Reason',
                            ));
                            break;
                        }
                        case 'movieFileRenamed': {
                            _entries.add(RadarrHistoryEntryFileRenamed(
                                entry['movie']['title'] ?? 'Unknown Title',
                                entry['date'] ?? '',
                            ));
                            break;
                        }
                        case 'grabbed': {
                            _entries.add(RadarrHistoryEntryGrabbed(
                                entry['movie']['title'] ?? 'Unknown Title',
                                entry['date'] ?? '',
                                entry['data']['indexer'] ?? 'Unknown Indexer',
                            ));
                            break;
                        }
                        default: {
                            _entries.add(RadarrHistoryEntryGeneric(
                                entry['movie']['title'] ?? 'Unknown Title',
                                entry['date'] ?? '',
                                entry['eventType'] ?? 'Unknown Event Type',
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

    static Future<bool> searchMissingMovies(List<int> movieIDs) async {
        List<dynamic> values = Values.radarrValues;
        if(values[0] == false) {
            return false;
        }
        try {
            String uri = '${values[1]}/api/command?apikey=${values[2]}';
            http.Response response = await http.post(
                Uri.encodeFull(uri),
                headers: {
                    'Content-Type': 'application/json',
                },
                body: json.encode({
                    'name': 'MoviesSearch',
                    'movieIds': movieIDs,
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
        List<dynamic> values = Values.radarrValues;
        if(values[0] == false) {
            return null;
        }
        try {
            String uri = '${values[1]}/api/command?apikey=${values[2]}';
            http.Response response = await http.post(
                Uri.encodeFull(uri),
                headers: {
                    'Content-Type': 'application/json',
                },
                body: json.encode({
                    'name': 'missingMoviesSearch',
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

    static Future<bool> toggleMovieMonitored(int movieID, bool status) async {
        List<dynamic> values = Values.radarrValues;
        if(values[0] == false) {
            return false;
        }
        try {
            String uriGet = '${values[1]}/api/movie/$movieID?apikey=${values[2]}';
            String uriPut = '${values[1]}/api/movie?apikey=${values[2]}';
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
                    }
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

    static Future<Map<int, RadarrQualityProfile>> getQualityProfiles() async {
        List<dynamic> values = Values.radarrValues;
        if(values[0] == false) {
            return null;
        }
        try {
            String uri = '${values[1]}/api/profile?apikey=${values[2]}';
            http.Response response = await http.get(
                Uri.encodeFull(uri),
            );
            if(response.statusCode == 200) {
                List body = json.decode(response.body);
                var _entries = new Map<int, RadarrQualityProfile>();
                for(var entry in body) {
                    _entries[entry['id']] = RadarrQualityProfile(
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

    static Future<List<RadarrReleaseEntry>> getReleases(int movieId) async {
        List<dynamic> values = Values.radarrValues;
        if(values[0] == false) {
            return null;
        }
        try {
            String uri = '${values[1]}/api/release?apikey=${values[2]}&movieId=$movieId';
            http.Response response = await http.get(
                Uri.encodeFull(uri),
            );
            if(response.statusCode == 200) {
                List body = json.decode(response.body);
                List<RadarrReleaseEntry> _entries = [];
                for(var entry in body) {
                    _entries.add(RadarrReleaseEntry(
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
                return _entries;
            }
        } catch (e) {
            return null;
        }
        return null;
    }

    static Future<bool> downloadRelease(String guid, int indexerId) async {
        List<dynamic> values = Values.radarrValues;
        if(values[0] == false) {
            return false;
        }
        try {
            String uri = '${values[1]}/api/release?apikey=${values[2]}';
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
        } catch(e) {
            return false;
        }
        return false;
    }

    static Future<List<RadarrSearchEntry>> searchMovies(String search) async {
        List<dynamic> values = Values.radarrValues;
        if(values[0] == false) {
            return null;
        }
        if(search == '') {
            return [];
        }
        try {
            List<RadarrSearchEntry> entries = [];
            String uri = '${values[1]}/api/movie/lookup?term=$search&apikey=${values[2]}';
            http.Response response = await http.get(
                Uri.encodeFull(uri),
            );
            if(response.statusCode == 200) {
                List body = json.decode(response.body);
                for(var entry in body) {
                    entries.add(RadarrSearchEntry(
                        entry['title'] ?? 'Unknown Title',
                        entry['titleSlug'] ?? 'unknown-title',
                        entry['overview'] == null || entry['overview'] == '' ? 'No summary is available' : entry['overview'],
                        entry['year'] ?? 0,
                        entry['tmdbId'] ?? 0,
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

    static Future<List<RadarrRootFolder>> getRootFolders() async {
        List<dynamic> values = Values.radarrValues;
        if(values[0] == false) {
            return null;
        }
        try {
            String uri = '${values[1]}/api/rootfolder?apikey=${values[2]}';
            http.Response response = await http.get(
                Uri.encodeFull(uri),
            );
            if(response.statusCode == 200) {
                List body = json.decode(response.body);
                List<RadarrRootFolder> _entries = [];
                for(var entry in body) {
                    _entries.add(RadarrRootFolder(
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