import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/dashboard.dart';

class CalendarAPI {
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

  Future<Map<DateTime, List<CalendarData>>> getUpcoming(DateTime today) async {
    Map<DateTime, List<CalendarData>> _upcoming = {};
    if (lidarr['enabled'] && DashboardDatabaseValue.CALENDAR_ENABLE_LIDARR.data)
      await _getLidarrUpcoming(_upcoming, today);
    if (radarr['enabled'] && DashboardDatabaseValue.CALENDAR_ENABLE_RADARR.data)
      await _getRadarrUpcoming(_upcoming, today);
    if (sonarr['enabled'] && DashboardDatabaseValue.CALENDAR_ENABLE_SONARR.data)
      await _getSonarrUpcoming(_upcoming, today);
    return _upcoming;
  }

  Future<void> _getLidarrUpcoming(
    Map<DateTime, List<CalendarData>> map,
    DateTime today,
  ) async {
    Map<String, dynamic> _headers =
        Map<String, dynamic>.from(lidarr['headers']);
    Dio _client = Dio(
      BaseOptions(
        baseUrl: '${lidarr['host']}/api/v1/',
        queryParameters: {
          if (lidarr['key'] != '') 'apikey': lidarr['key'],
          'start': _startDate(today),
          'end': _endDate(today),
        },
        headers: _headers,
        followRedirects: true,
        maxRedirects: 5,
      ),
    );
    Response response = await _client.get('calendar');
    if (response.data.length > 0) {
      for (var entry in response.data) {
        DateTime date =
            DateTime.tryParse(entry['releaseDate'] ?? '')?.toLocal()?.lunaFloor;
        if (date != null && _isDateWithinBounds(date, today)) {
          List<CalendarData> day = map[date] ?? [];
          day.add(CalendarLidarrData(
            id: entry['id'] ?? 0,
            title: entry['artist']['artistName'] ?? 'Unknown Artist',
            albumTitle: entry['title'] ?? 'Unknown Album Title',
            artistId: entry['artist']['id'] ?? 0,
            hasAllFiles: (entry['statistics'] != null
                    ? entry['statistics']['percentOfTracks'] ?? 0
                    : 0) ==
                100,
          ));
          map[date] = day;
        }
      }
    }
  }

  Future<void> _getRadarrUpcoming(
    Map<DateTime, List<CalendarData>> map,
    DateTime today,
  ) async {
    Map<String, dynamic> _headers =
        Map<String, dynamic>.from(radarr['headers']);
    Dio _client = Dio(
      BaseOptions(
        baseUrl: '${radarr['host']}/api/v3/',
        queryParameters: {
          if (radarr['key'] != '') 'apikey': radarr['key'],
          'start': _startDate(today),
          'end': _endDate(today),
        },
        headers: _headers,
        followRedirects: true,
        maxRedirects: 5,
      ),
    );
    Response response = await _client.get('calendar');
    if (response.data.length > 0) {
      for (var entry in response.data) {
        DateTime physicalRelease =
            DateTime.tryParse(entry['physicalRelease'] ?? '')
                ?.toLocal()
                ?.lunaFloor;
        DateTime digitalRelease =
            DateTime.tryParse(entry['digitalRelease'] ?? '')
                ?.toLocal()
                ?.lunaFloor;
        DateTime release;
        if (physicalRelease != null || digitalRelease != null) {
          if (physicalRelease == null) release = digitalRelease;
          if (digitalRelease == null) release = physicalRelease;
          release ??= digitalRelease.isBefore(physicalRelease)
              ? digitalRelease
              : physicalRelease;
          if (release != null && _isDateWithinBounds(release, today)) {
            List<CalendarData> day = map[release] ?? [];
            day.add(CalendarRadarrData(
              id: entry['id'] ?? 0,
              title: entry['title'] ?? 'Unknown Title',
              hasFile: entry['hasFile'] ?? false,
              fileQualityProfile: entry['hasFile']
                  ? entry['movieFile']['quality']['quality']['name']
                  : '',
              year: entry['year'] ?? 0,
              runtime: entry['runtime'] ?? 0,
              studio: entry['studio'] ?? LunaUI.TEXT_EMDASH,
            ));
            map[release] = day;
          }
        }
      }
    }
  }

  Future<void> _getSonarrUpcoming(
    Map<DateTime, List<CalendarData>> map,
    DateTime today,
  ) async {
    Map<String, dynamic> _headers =
        Map<String, dynamic>.from(sonarr['headers']);
    Dio _client = Dio(
      BaseOptions(
        baseUrl: '${sonarr['host']}/api/v3/',
        queryParameters: {
          if (sonarr['key'] != '') 'apikey': sonarr['key'],
          'start': _startDate(today),
          'end': _endDate(today),
        },
        headers: _headers,
        followRedirects: true,
        maxRedirects: 5,
      ),
    );
    Response response = await _client.get('calendar', queryParameters: {
      'includeSeries': true,
      'includeEpisodeFile': true,
    });
    if (response.data.length > 0) {
      for (var entry in response.data) {
        DateTime date =
            DateTime.tryParse(entry['airDateUtc'] ?? '')?.toLocal()?.lunaFloor;
        if (date != null && _isDateWithinBounds(date, today)) {
          List<CalendarData> day = map[date] ?? [];
          day.add(CalendarSonarrData(
            id: entry['id'] ?? 0,
            seriesID: entry['seriesId'] ?? 0,
            title: entry['series']['title'] ?? 'Unknown Series',
            episodeTitle: entry['title'] ?? 'Unknown Episode Title',
            seasonNumber: entry['seasonNumber'] ?? -1,
            episodeNumber: entry['episodeNumber'] ?? -1,
            airTime: entry['airDateUtc'] ?? '',
            hasFile: entry['hasFile'] ?? false,
            fileQualityProfile: entry['hasFile']
                ? entry['episodeFile']['quality']['quality']['name']
                : '',
          ));
          map[date] = day;
        }
      }
    }
  }

  String _startDate(DateTime today) {
    return DateFormat('y-MM-dd').format(_startBoundDate(today));
  }

  String _endDate(DateTime today) {
    return DateFormat('y-MM-dd').format(_endBoundDate(today));
  }

  DateTime _startBoundDate(DateTime today) {
    return today.subtract(
      Duration(days: DashboardDatabaseValue.CALENDAR_DAYS_PAST.data + 1),
    );
  }

  DateTime _endBoundDate(DateTime today) {
    return today.add(
      Duration(days: DashboardDatabaseValue.CALENDAR_DAYS_FUTURE.data + 1),
    );
  }

  bool _isDateWithinBounds(DateTime date, DateTime today) {
    return date.isBetween(_startBoundDate(today), _endBoundDate(today));
  }
}
