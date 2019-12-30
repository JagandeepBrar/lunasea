import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lunasea/configuration/values.dart';
import 'package:lunasea/logic/automation/sonarr.dart';
import 'package:intl/intl.dart';

class SonarrAPI {
    SonarrAPI._();
    
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

    static Future<int> getSeriesCount() async {
        List<dynamic> values = Values.sonarrValues;
        if(values[0] == false) {
            return -1;
        }
        try {
            String uri = '${values[1]}/api/series?apikey=${values[2]}';
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

    static Future<bool> refreshSeries(int id) async {
        List<dynamic> values = Values.sonarrValues;
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
                    'name': 'RefreshSeries',
                    'seriesId': id,
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

    static Future<bool> removeSeries(int id) async {
        List<dynamic> values = Values.sonarrValues;
        if(values[0] == false) {
            return false;
        }
        try {
            String uri = '${values[1]}/api/series/$id?apikey=${values[2]}';
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

    static Future<List<SonarrSearchEntry>> searchSeries(String search) async {
        List<dynamic> values = Values.sonarrValues;
        if(values[0] == false) {
            return null;
        }
        if(search == '') {
            return [];
        }
        try {
            List<SonarrSearchEntry> entries = [];
            String uri = '${values[1]}/api/series/lookup?term=$search&apikey=${values[2]}';
            http.Response response = await http.get(
                Uri.encodeFull(uri),
            );
            if(response.statusCode == 200) {
                List body = json.decode(response.body);
                for(var entry in body) {
                    entries.add(SonarrSearchEntry(
                        entry['title'] ?? 'Unknown Title',
                        entry['overview'] == null || entry['overview'] == '' ? 'No summary is available' : entry['overview'],
                        entry['seasonCount'] ?? 0,
                        entry['status'] ?? 'Unknown Status',
                        entry['images'] ?? [],
                        entry['seasons'] ?? [],
                        entry['tvdbId'] ?? 0,
                        entry['tvMazeId'] ?? 0,
                        entry['imdbId'] ?? '',
                    ));
                }
                return entries;
            }
        } catch (e) {
            return null;
        }
        return null;
    }

    static Future<bool> addSeries(SonarrSearchEntry entry, SonarrQualityProfile qualityProfile, SonarrRootFolder rootFolder, SonarrSeriesType seriesType, bool seasonFolders, bool monitored) async {
        List<dynamic> values = Values.sonarrValues;
        if(values[0] == false) {
            return false;
        }
        try {
            String uri = '${values[1]}/api/series?apikey=${values[2]}';
            http.Response response = await http.post(
                Uri.encodeFull(uri),
                headers: {
                    'Content-Type': 'application/json',
                },
                body: json.encode({
                    'addOptions': {
                        'ignoreEpisodesWithFiles': true,
                        'ignoreEpisodesWithoutFiles': false,
                        'searchForMissingEpisodes': false,
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
            if(response.statusCode == 201) {
                return true;
            }
        } catch (e) {
            return false;
        }
        return false;
    }

    static Future<bool> editSeries(int seriesID, SonarrQualityProfile qualityProfile, SonarrSeriesType seriesType, String path, bool monitored, bool seasonFolder) async {
        List<dynamic> values = Values.sonarrValues;
        if(values[0] == false) {
            return false;
        }
        try {
            String uriGet = '${values[1]}/api/series/$seriesID?apikey=${values[2]}';
            String uriPut = '${values[1]}/api/series?apikey=${values[2]}';
            http.Response response = await http.get(
                Uri.encodeFull(uriGet),
            );
            if(response.statusCode == 200) {
                Map series = json.decode(response.body);
                series['monitored'] = monitored;
                series['seasonFolder'] = seasonFolder;
                series['profileId'] = qualityProfile.id;
                series['seriesType'] = seriesType.type;
                series['path'] = path;
                response = await http.put(
                    Uri.encodeFull(uriPut),
                    headers: {
                        'Content-Type': 'application/json',
                    },
                    body: json.encode(series),
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

    static Future<SonarrCatalogueEntry> getSeries(int id) async {
        List<dynamic> values = Values.sonarrValues;
        if(values[0] == false) {
            return null;
        }
        try {
            Map<int, SonarrQualityProfile> _qualities = await getQualityProfiles();
            if(_qualities != null) {
                String uri = '${values[1]}/api/series/$id?apikey=${values[2]}';
                http.Response response = await http.get(
                    Uri.encodeFull(uri),
                );
                if(response.statusCode == 200) {
                    Map body = json.decode(response.body);
                    List<dynamic> _seasonData = body['seasons'];
                    _seasonData.sort((a, b) => a['seasonNumber'].compareTo(b['seasonNumber']));
                    SonarrCatalogueEntry entry = SonarrCatalogueEntry(
                        body['title'] ?? 'Unknown Title',
                        body['sortTitle'] ?? 'Unknown Title',
                        body['seasonCount'] ?? 0,
                        _seasonData ?? [],
                        body['episodeCount'] ?? 0,
                        body['episodeFileCount'] ?? 0,
                        body['status'] ?? 'Unknown Status',
                        body['id'] ?? -1,
                        body['previousAiring'] ?? '',
                        body['nextAiring'] ?? '',
                        body['network'] ?? 'Unknown Network',
                        body['monitored'] ?? false,
                        body['path'] ?? 'Unknown Path',
                        body['qualityProfileId'] ?? 0,
                        body['seriesType'] ?? 'Unknown Series Type',
                        body['seasonFolder'] ?? false,
                        body['overview'] ?? 'No summary is available',
                        body['tvdbId'] ?? 0,
                        body['tvMazeId'] ?? 0,
                        body['imdbId'] ?? '',
                        body['runtime'] ?? 0,
                        body['profileId'] != null ? _qualities[body['qualityProfileId']].name : '',
                    );
                    return entry;
                }
            }
        } catch (e) {
            return null;
        }
        return null;
    }

    static Future<List<SonarrCatalogueEntry>> getAllSeries() async {
        List<dynamic> values = Values.sonarrValues;
        if(values[0] == false) {
            return null;
        }
        try {
            Map<int, SonarrQualityProfile> _qualities = await getQualityProfiles();
            List<SonarrCatalogueEntry> entries = [];
            if(_qualities != null) {
                String uri = '${values[1]}/api/series?apikey=${values[2]}';
                http.Response response = await http.get(
                    Uri.encodeFull(uri),
                );
                if(response.statusCode == 200) {
                    List body = json.decode(response.body);
                    for(var entry in body) {
                        List<dynamic> _seasonData = entry['seasons'];
                        _seasonData.sort((a, b) => a['seasonNumber'].compareTo(b['seasonNumber']));
                        entries.add(
                            SonarrCatalogueEntry(
                                entry['title'] ?? 'Unknown Title',
                                entry['sortTitle'] ?? 'Unknown Title',
                                entry['seasonCount'] ?? 0,
                                _seasonData ?? [],
                                entry['episodeCount'] ?? 0,
                                entry['episodeFileCount'] ?? 0,
                                entry['status'] ?? 'Unknown Status',
                                entry['id'] ?? -1,
                                entry['previousAiring'] ?? '',
                                entry['nextAiring'] ?? '',
                                entry['network'] ?? 'Unknown Network',
                                entry['monitored'] ?? false,
                                entry['path'] ?? 'Unknown Path',
                                entry['qualityProfileId'] ?? 0,
                                entry['seriesType'] ?? 'Unknown Series Type',
                                entry['seasonFolder'] ?? false,
                                entry['overview'] ?? 'No summary is available',
                                entry['tvdbId'] ?? 0,
                                entry['tvMazeId'] ?? 0,
                                entry['imdbId'] ?? '',
                                entry['runtime'] ?? 0,
                                entry['profileId'] != null ? _qualities[entry['qualityProfileId']].name : '',
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

    static Future<Map> getUpcoming({int duration = 7}) async {
        List<dynamic> values = Values.sonarrValues;
        if(values[0] == false) {
            return null;
        }
        try {
            DateTime now = DateTime.now();
            String start = DateFormat('y-MM-dd').format(now);
            String end = DateFormat('y-MM-dd').format(now.add(Duration(days: duration)));
            String uri = '${values[1]}/api/calendar?apikey=${values[2]}&start=$start&end=$end';
            http.Response response = await http.get(
                Uri.encodeFull(uri),
            );
            if(response.statusCode == 200) {
                List body = json.decode(response.body);
                if(body.length <= 0) {
                    return {};
                }
                Map entries = {};
                for(int i=0; i<duration; i++) {
                    entries[DateFormat('y-MM-dd').format(now.add(Duration(days: i)))] = {
                        'date': DateFormat('EEEE\nMMMM dd, y').format(now.add(Duration(days: i))),
                        'entries': [],
                    };
                }
                for(var entry in body) {
                    DateTime date = DateTime.tryParse(entry['airDateUtc'])?.toLocal();
                    if(date != null) {
                        String dateParsed = DateFormat('y-MM-dd').format(date);
                        if(entries.containsKey(dateParsed)) {
                            entries[dateParsed]['entries'].add(SonarrUpcomingEntry(
                                entry['series']['title'] ?? 'Unknown Series Title',
                                entry['title'] ?? 'Unknown Episode Title',
                                entry['seasonNumber'] ?? 0,
                                entry['episodeNumber'] ?? 0,
                                entry['series']['id'] ?? -1,
                                entry['id'] ?? -1,
                                entry['airDateUtc'] ?? '',
                                entry['hasFile'] ?? false,
                                entry['hasFile'] ? entry['episodeFile']['quality']['quality']['name'] : '',
                            ));
                        }
                    }
                }
                return entries;
            }
        } catch (e) {
            return null;
        }
        return null;
    }

    static Future<List<SonarrHistoryEntry>> getHistory() async {
        List<dynamic> values = Values.sonarrValues;
        if(values[0] == false) {
            return null;
        }
        try {
            String uri = '${values[1]}/api/history?apikey=${values[2]}&sortKey=date&pageSize=250&sortDir=desc';
            http.Response response = await http.get(
                Uri.encodeFull(uri),
            );
            if(response.statusCode == 200) {
                List<SonarrHistoryEntry> _entries = [];
                Map body = json.decode(response.body);
                for(var entry in body['records']) {
                    switch(entry['eventType']) {
                        case 'downloadFolderImported': {
                            _entries.add(SonarrHistoryEntryDownloadImported(
                                entry['seriesId'] ?? -1,
                                entry['series']['title'] ?? 'Unknown Series Title',
                                entry['episode']['title'] ?? 'Unknown Episode Title',
                                entry['episode']['episodeNumber'] ?? 0,
                                entry['episode']['seasonNumber'] ?? 0,
                                entry['date'] ?? '',
                                entry['quality']['quality']['name'] ?? '',
                            ));
                            break;
                        }
                        case 'downloadFailed': {
                            _entries.add(SonarrHistoryEntryDownloadFailed(
                                entry['seriesId'] ?? -1,
                                entry['series']['title'] ?? 'Unknown Series Title',
                                entry['episode']['title'] ?? 'Unknown Episode Title',
                                entry['episode']['episodeNumber'] ?? 0,
                                entry['episode']['seasonNumber'] ?? 0,
                                entry['date'] ?? '',
                            ));
                            break;
                        }
                        case 'episodeFileDeleted': {
                            _entries.add(SonarrHistoryEntryEpisodeDeleted(
                                entry['seriesId'] ?? -1,
                                entry['series']['title'] ?? 'Unknown Series Title',
                                entry['episode']['title'] ?? 'Unknown Episode Title',
                                entry['episode']['episodeNumber'] ?? 0,
                                entry['episode']['seasonNumber'] ?? 0,
                                entry['date'] ?? '',
                                entry['data']['reason'] ?? 'Unknown Deletion Reason',
                            ));
                            break;
                        }
                        case 'episodeFileRenamed': {
                            _entries.add(SonarrHistoryEntryEpisodeRenamed(
                                entry['seriesId'] ?? -1,
                                entry['series']['title'] ?? 'Unknown Series Title',
                                entry['episode']['title'] ?? 'Unknown Episode Title',
                                entry['episode']['episodeNumber'] ?? 0,
                                entry['episode']['seasonNumber'] ?? 0,
                                entry['date'] ?? '',
                            ));
                            break;
                        }
                        case 'grabbed': {
                            _entries.add(SonarrHistoryEntryGrabbed(
                                entry['seriesId'] ?? -1,
                                entry['series']['title'] ?? 'Unknown Series Title',
                                entry['episode']['title'] ?? 'Unknown Episode Title',
                                entry['episode']['episodeNumber'] ?? 0,
                                entry['episode']['seasonNumber'] ?? 0,
                                entry['date'] ?? '',
                                entry['data']['indexer'] ?? 'Unknown Indexer',
                            ));
                            break;
                        }
                        default: {
                            _entries.add(SonarrHistoryEntryGeneric(
                                entry['seriesId'] ?? -1,
                                entry['series']['title'] ?? 'Unknown Series Title',
                                entry['episode']['title'] ?? 'Unknown Episode Title',
                                entry['episode']['episodeNumber'] ?? 0,
                                entry['episode']['seasonNumber'] ?? 0,
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

    static Future<Map> getEpisodes(int seriesID, int seasonNumber) async {
        List<dynamic> values = Values.sonarrValues;
        if(values[0] == false) {
            return null;
        }
        try {
            Map _queue = await getQueue() ?? {};
            Map entries = {};
            String uri = '${values[1]}/api/episode?apikey=${values[2]}&seriesId=$seriesID';
            http.Response response = await http.get(
                Uri.encodeFull(uri),
            );
            if(response.statusCode == 200) {
                List body = json.decode(response.body);
                for(var entry in body) {
                    if(seasonNumber == -1 || entry['seasonNumber'] == seasonNumber) {
                        if(!entries.containsKey(entry['seasonNumber'])) {
                            entries[entry['seasonNumber']] = [];
                            entries[-1] = body.length;
                        }
                        String quality = '';
                        bool cutoffMet = false;
                        int size = 0;
                        SonarrQueueEntry _queueEntry;
                        if(entry['hasFile']) {
                            quality = entry['episodeFile']['quality']['quality']['name'];
                            cutoffMet = entry['episodeFile']['qualityCutoffNotMet'];
                            size = entry['episodeFile']['size'];
                        }
                        if(_queue.containsKey(entry['id'])) {
                            _queueEntry = _queue[entry['id']];
                        }
                        entries[entry['seasonNumber']].add(SonarrEpisodeEntry(
                            entry['title'] ?? 'Unknown Title',
                            entry['seasonNumber'] ?? 0,
                            entry['episodeNumber'] ?? 0,
                            entry['airDateUtc'] ?? '',
                            entry['id'] ?? -1,
                            entry['monitored'] ?? false,
                            entry['hasFile'] ?? false,
                            quality ?? 'Unknown Quality',
                            cutoffMet ?? false,
                            size ?? 0,
                            _queueEntry ?? null,
                        ));
                    }
                }
                return entries;
            }
        } catch (e) {
            return null;
        }
        return null;
    }

    static Future<Map> getQueue() async {
        List<dynamic> values = Values.sonarrValues;
        if(values[0] == false) {
            return null;
        }
        try {
            String uri = "${values[1]}/api/queue?apikey=${values[2]}";
            http.Response response = await http.get(
                Uri.encodeFull(uri),
            );
            if(response.statusCode == 200) {
                List body = json.decode(response.body);
                Map entries = {};
                for(var entry in body) {
                    entries[entry['episode']['id']] = SonarrQueueEntry(
                        entry['episode']['id'] ?? 0,
                        entry['size'] ?? 0.0,
                        entry['sizeleft'] ?? 0.9,
                        entry['status'] ?? 'Unknown Status',
                    );
                }
                return entries;
            }
        } catch (e) {
            return null;
        }
        return null;
    }

    static Future<List<SonarrMissingEntry>> getMissing() async {
        List<dynamic> values = Values.sonarrValues;
        if(values[0] == false) {
            return null;
        }
        try {
            List<SonarrMissingEntry> entries = [];
            String uri = "${values[1]}/api/wanted/missing?apikey=${values[2]}&pageSize=200";
            http.Response response = await http.get(
                Uri.encodeFull(uri),
            );
            if(response.statusCode == 200) {
                Map body = json.decode(response.body);
                for(var entry in body['records']) {
                    entries.add(SonarrMissingEntry(
                        entry['series']['title'] ?? 'Unknown Series Title',
                        entry['title'] ?? 'Unknown Episode Title',
                        entry['seasonNumber'] ?? 0,
                        entry['episodeNumber'] ?? 0,
                        entry['airDateUtc'] ?? '',
                        entry['series']['id'] ?? -1,
                        entry['id'] ?? -1,
                    ));
                }
                return entries;
            }
        } catch (e) {
            return null;
        }
        return null;
    }

    static Future<bool> searchAllMissing() async {
        List<dynamic> values = Values.sonarrValues;
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
                    'name': 'missingEpisodeSearch',
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
        List<dynamic> values = Values.sonarrValues;
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
                    'name': 'refreshSeries',
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
        List<dynamic> values = Values.sonarrValues;
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
        List<dynamic> values = Values.sonarrValues;
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

    static Future<bool> searchSeason(int seriesID, int season) async {
        List<dynamic> values = Values.sonarrValues;
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
                    'name': 'SeasonSearch',
                    'seriesId': seriesID,
                    'seasonNumber': season,
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

    static Future<bool> searchEpisodes(List<int> episodeIDs) async {
        List<dynamic> values = Values.sonarrValues;
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
                    'name': 'EpisodeSearch',
                    'episodeIds': episodeIDs,
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

    static Future<bool> toggleSeriesMonitored(int seriesID, bool status) async {
        List<dynamic> values = Values.sonarrValues;
        if(values[0] == false) {
            return false;
        }
        try {
            String uriGet = '${values[1]}/api/series/$seriesID?apikey=${values[2]}';
            String uriPut = '${values[1]}/api/series?apikey=${values[2]}';
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
                        "Content-Type": "application/json",
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

    static Future<bool> toggleSeasonMonitored(int seriesID, int seasonID, bool status) async {
        List<dynamic> values = Values.sonarrValues;
        if(values[0] == false) {
            return false;
        }
        try {
            String uriGet = '${values[1]}/api/series/$seriesID?apikey=${values[2]}';
            String uriPut = '${values[1]}/api/series?apikey=${values[2]}';
            http.Response response = await http.get(
                Uri.encodeFull(uriGet),
            );
            if(response.statusCode == 200) {
                Map body = json.decode(response.body);
                for(var season in body['seasons']) {
                    if(season['seasonNumber'] == seasonID) {
                        season['monitored'] = status;
                    }
                }
                response = await http.put(
                    Uri.encodeFull(uriPut),
                    body: json.encode(body),
                    headers: {
                        "Content-Type": "application/json",
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

    static Future<List<SonarrRootFolder>> getRootFolders() async {
        List<dynamic> values = Values.sonarrValues;
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
                List<SonarrRootFolder> _entries = [];
                for(var entry in body) {
                    _entries.add(SonarrRootFolder(
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

    static Future<Map<int, SonarrQualityProfile>> getQualityProfiles() async {
        List<dynamic> values = Values.sonarrValues;
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
                var _entries = new Map<int, SonarrQualityProfile>();
                for(var entry in body) {
                    _entries[entry['id']] = SonarrQualityProfile(
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

    static Future<List<SonarrReleaseEntry>> getReleases(int episodeId) async {
        List<dynamic> values = Values.sonarrValues;
        if(values[0] == false) {
            return null;
        }
        try {
            String uri = '${values[1]}/api/release?apikey=${values[2]}&episodeId=$episodeId';
            http.Response response = await http.get(
                Uri.encodeFull(uri),
            );
            if(response.statusCode == 200) {
                List body = json.decode(response.body);
                List<SonarrReleaseEntry> _entries = [];
                for(var entry in body) {
                    _entries.add(SonarrReleaseEntry(
                        entry['title'] ?? 'Unknown Release Title',
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
        List<dynamic> values = Values.sonarrValues;
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
}
