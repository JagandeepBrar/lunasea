import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lunasea/core.dart';

class SonarrUpcomingData {
    final Map<String, dynamic> api = Database.currentProfileObject.getSonarr();
    String seriesTitle;
    String episodeTitle;
    int seasonNumber;
    int episodeNumber;
    int seriesID;
    int id;
    String airTime;
    String filePath;
    bool hasFile;

    SonarrUpcomingData({
        @required this.seriesTitle,
        @required this.episodeTitle,
        @required this.seasonNumber,
        @required this.episodeNumber,
        @required this.seriesID,
        @required this.id,
        @required this.airTime,
        @required this.hasFile,
        @required this.filePath,
    });

    DateTime get airTimeObject {
        return DateTime.tryParse(airTime)?.toLocal();
    }

    String get airTimeString {
        if(airTimeObject != null) {
            return DateFormat('KK:mm\na').format(airTimeObject);
        }
        return 'N/A';
    }

    String posterURI({bool highRes = false}) {
        if(api['enabled']) {
            return highRes
                ? '${api['host']}/api/mediacover/$seriesID/poster.jpg?apikey=${api['key']}'
                : '${api['host']}/api/mediacover/$seriesID/poster-500.jpg?apikey=${api['key']}';
        }
        return '';
    }

    String fanartURI({bool highRes = false}) {
        if(api['enabled']) {
            return highRes
                ? '${api['host']}/api/mediacover/$seriesID/fanart.jpg?apikey=${api['key']}'
                : '${api['host']}/api/mediacover/$seriesID/fanart-360.jpg?apikey=${api['key']}'; 
        }
        return '';
    }

    String bannerURI({bool highRes = false}) {
        if(api['enabled']) {
            return highRes
                ? '${api['host']}/api/mediacover/$seriesID/banner.jpg?apikey=${api['key']}'
                : '${api['host']}/api/mediacover/$seriesID/banner-70.jpg?apikey=${api['key']}'; 
        }
        return '';
    }

    String get seasonEpisode {
        return 'Season $seasonNumber Episode $episodeNumber';
    }

    TextSpan get downloaded {
        if(hasFile) {
            return TextSpan(
                text: 'Downloaded ($filePath)',
                style: TextStyle(
                    color: Color(Constants.ACCENT_COLOR),
                    fontWeight: FontWeight.bold,
                ),
            );
        }
        return TextSpan(
            text: 'Not Downloaded',
            style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
            ),
        );
    }
}