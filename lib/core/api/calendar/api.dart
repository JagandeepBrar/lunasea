import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/system.dart';

class CalendarAPI extends API {
    @override
    void logError(String methodName, String text, Object error) {
        Logger.error('package:lunasea/logic/home/api.dart', methodName, 'Home: $text', error, StackTrace.current);
    }

    @override
    void logWarning(String methodName, String text) {
        Logger.warning('package:lunasea/logic/home/api.dart', methodName, 'Home: $text');
    }

    Future<Map<DateTime, List>> getUpcoming(DateTime today) async {
        Map<DateTime, List> _upcoming = {};
        await _getLidarrUpcoming(_upcoming, today);
        await _getRadarrUpcoming(_upcoming, today);
        await _getSonarrUpcoming(_upcoming, today);
        return _upcoming;
    }

    Future<void> _getLidarrUpcoming(Map<DateTime, List> map, DateTime today, { int startOffset = 7, int endOffset = 60 }) async {
        try {
            List<dynamic> values = Values.lidarrValues;
            if(values[0]) {
                String start = DateFormat('y-MM-dd').format(today.subtract(Duration(days: startOffset)));
                String end = DateFormat('y-MM-dd').format(today.add(Duration(days: endOffset)));
                String uri = '${values[1]}/api/v1/calendar?apikey=${values[2]}&start=$start&end=$end';
                http.Response response = await http.get(Uri.encodeFull(uri));
                if(response.statusCode == 200) {
                    List body = json.decode(response.body);
                    if(body.length > 0) {
                        for(var entry in body) {
                           DateTime date = DateTime.tryParse(entry['releaseDate'] ?? '')?.toLocal()?.lsDateTime_floor();
                           if(date != null) {
                               List day = map[date] ?? [];
                               day.add(CalendarLidarrEntry(
                                   id: entry['id'] ?? 0,
                                   title: entry['artist']['artistName'] ?? 'Unknown Artist',
                                   albumTitle: entry['title'] ?? 'Unknown Album Title',
                                   artistId: entry['artist']['id'] ?? 0,
                                   hasAllFiles: (entry['statistics'] != null ? entry['statistics']['percentOfTracks'] ?? 0 : 0) == 100,
                               ));
                               map[date] = day;
                           }
                        }
                    }
                } else {
                    logError('_getLidarrUpcoming', '<GET> HTTP Status Code (${response.statusCode})', null);
                }
            }
        } catch (e) {
            logError('_getLidarrUpcoming', 'Failed to fetch Lidarr upcoming content', e);
            return;
        }
    }

    Future<void> _getRadarrUpcoming(Map<DateTime, List> map, DateTime today, { int startOffset = 7, int endOffset = 60 }) async {
        try {
            List<dynamic> values = Values.radarrValues;
            if(values[0]) {
                String start = DateFormat('y-MM-dd').format(today.subtract(Duration(days: startOffset)));
                String end = DateFormat('y-MM-dd').format(today.add(Duration(days: endOffset)));
                String uri = '${values[1]}/api/calendar?apikey=${values[2]}&start=$start&end=$end';
                http.Response response = await http.get(Uri.encodeFull(uri));
                if(response.statusCode == 200) {
                    List body = json.decode(response.body);
                    if(body.length > 0) {
                        for(var entry in body) {
                            DateTime date = DateTime.tryParse(entry['physicalRelease'] ?? '')?.toLocal()?.lsDateTime_floor();
                            if(date != null) {
                                List day = map[date] ?? [];
                                day.add(CalendarRadarrEntry(
                                    id: entry['id'] ?? 0,
                                    title: entry['title'] ?? 'Unknown Title',
                                    hasFile: entry['hasFile'] ?? false,
                                    fileQualityProfile: entry['hasFile'] ? entry['movieFile']['quality']['quality']['name'] : '',
                                    year: entry['year'] ?? 0,
                                    runtime: entry['runtime'] ?? 0,
                                ));
                                map[date] = day;
                            }
                        }
                    }
                } else {
                    logError('_getRadarrUpcoming', '<GET> HTTP Status Code (${response.statusCode})', null);
                }
            }
        } catch (e) {
            logError('_getRadarrUpcoming', 'Failed to fetch Radarr upcoming content', e);
            return;
        }
    }

    Future<void> _getSonarrUpcoming(Map<DateTime, List> map, DateTime today, { int startOffset = 7, int endOffset = 60 }) async {
        try {
            List<dynamic> values = Values.sonarrValues;
            if(values[0]) {
                String start = DateFormat('y-MM-dd').format(today.subtract(Duration(days: startOffset)));
                String end = DateFormat('y-MM-dd').format(today.add(Duration(days: endOffset)));
                String uri = '${values[1]}/api/calendar?apikey=${values[2]}&start=$start&end=$end';
                http.Response response = await http.get(Uri.encodeFull(uri));
                if(response.statusCode == 200) {
                    List body = json.decode(response.body);
                    if(body.length > 0) {
                        for(var entry in body) {
                            DateTime date = DateTime.tryParse(entry['airDateUtc'] ?? '')?.toLocal()?.lsDateTime_floor();
                            if(date != null) {
                                List day = map[date] ?? [];
                                day.add(CalendarSonarrEntry(
                                    id: entry['id'] ?? 0,
                                    seriesID: entry['seriesId'] ?? 0,
                                    title: entry['series']['title'] ?? 'Unknown Series',
                                    episodeTitle: entry['title'] ?? 'Unknown Episode Title',
                                    seasonNumber: entry['seasonNumber'] ?? -1,
                                    episodeNumber: entry['episodeNumber']  ?? -1,
                                    airTime: entry['airDateUtc'] ?? '',
                                    hasFile: entry['hasFile'] ?? false,
                                    fileQualityProfile: entry['hasFile'] ? entry['episodeFile']['quality']['quality']['name'] : '',
                                ));
                                map[date] = day;
                            }
                        }
                    }
                } else {
                    logError('_getSonarrUpcoming', '<GET> HTTP Status Code (${response.statusCode})', null);
                }
            }
        } catch (e) {
            logError('_getSonarrUpcoming', 'Failed to fetch Sonarr upcoming content', e);
            return;
        }
    }

    @override
    Future<bool> testConnection(List values) async {
        return true;
    }
}