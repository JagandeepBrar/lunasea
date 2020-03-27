import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lunasea/core.dart';
import '../../home.dart';

class CalendarAPI extends API {
    final Map<String, dynamic> lidarr;
    final Map<String, dynamic> radarr;
    final Map<String, dynamic> sonarr;

    CalendarAPI._internal({
        @required this.lidarr,
        @required this.radarr,
        @required this.sonarr,
    });

    factory CalendarAPI.from(ProfileHiveObject profile) {
        return CalendarAPI._internal(
            lidarr: profile?.getLidarr(),
            radarr: profile?.getRadarr(),
            sonarr: profile?.getSonarr(),
        );
    }

    void logError(String methodName, String text, Object error) => Logger.error('package:lunasea/core/api/calendar/api.dart', methodName, 'Home: $text', error, StackTrace.current);
    void logWarning(String methodName, String text) => Logger.warning('package:lunasea/core/api/calendar/api.dart', methodName, 'Home: $text');

    Future<bool> testConnection() async => true;

    Future<Map<DateTime, List>> getUpcoming(DateTime today) async {
        Map<DateTime, List> _upcoming = {};
        await _getLidarrUpcoming(_upcoming, today);
        await _getRadarrUpcoming(_upcoming, today);
        await _getSonarrUpcoming(_upcoming, today);
        return _upcoming.isEmpty
            ? await Future.delayed(Duration(milliseconds: 500), () => {})
            : _upcoming;
    }

    Future<void> _getLidarrUpcoming(Map<DateTime, List> map, DateTime today, { int startOffset = 7, int endOffset = 60 }) async {
        try {
            if(lidarr['enabled']) {
                String start = DateFormat('y-MM-dd').format(today.subtract(Duration(days: startOffset)));
                String end = DateFormat('y-MM-dd').format(today.add(Duration(days: endOffset)));
                String uri = '${lidarr['host']}/api/v1/calendar?apikey=${lidarr['key']}&start=$start&end=$end';
                Response response = await Dio().get(uri);
                if(response.data.length > 0) {
                    for(var entry in response.data) {
                       DateTime date = DateTime.tryParse(entry['releaseDate'] ?? '')?.toLocal()?.lsDateTime_floor();
                       if(date != null) {
                           List day = map[date] ?? [];
                           day.add(CalendarLidarrData(
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
            }
        } catch (error) {
            logError('_getLidarrUpcoming', 'Failed to fetch Lidarr upcoming content', error);
            return;
        }
    }

    Future<void> _getRadarrUpcoming(Map<DateTime, List> map, DateTime today, { int startOffset = 7, int endOffset = 60 }) async {
        try {
            if(radarr['enabled']) {
                String start = DateFormat('y-MM-dd').format(today.subtract(Duration(days: startOffset)));
                String end = DateFormat('y-MM-dd').format(today.add(Duration(days: endOffset)));
                String uri = '${radarr['host']}/api/calendar?apikey=${radarr['key']}&start=$start&end=$end';
                Response response = await Dio().get(uri);
                if(response.data.length > 0) {
                    for(var entry in response.data) {
                        DateTime date = DateTime.tryParse(entry['physicalRelease'] ?? '')?.toLocal()?.lsDateTime_floor();
                        if(date != null) {
                            List day = map[date] ?? [];
                            day.add(CalendarRadarrData(
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
            }
        } catch (error) {
            logError('_getRadarrUpcoming', 'Failed to fetch Radarr upcoming content', error);
            return;
        }
    }

    Future<void> _getSonarrUpcoming(Map<DateTime, List> map, DateTime today, { int startOffset = 7, int endOffset = 60 }) async {
        try {
            if(sonarr['enabled']) {
                String start = DateFormat('y-MM-dd').format(today.subtract(Duration(days: startOffset)));
                String end = DateFormat('y-MM-dd').format(today.add(Duration(days: endOffset)));
                String uri = '${sonarr['host']}/api/calendar?apikey=${sonarr['key']}&start=$start&end=$end';
                Response response = await Dio().get(uri);
                if(response.data.length > 0) {
                    for(var entry in response.data) {
                        DateTime date = DateTime.tryParse(entry['airDateUtc'] ?? '')?.toLocal()?.lsDateTime_floor();
                        if(date != null) {
                            List day = map[date] ?? [];
                            day.add(CalendarSonarrData(
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
            }
        } catch (error) {
            logError('_getSonarrUpcoming', 'Failed to fetch Sonarr upcoming content', error);
            return;
        }
    }
}