import 'package:flutter/material.dart';
import 'package:lunasea/core/database.dart';

class SonarrMissingData {
    final Map<String, dynamic> api = Database.currentProfileObject.getSonarr();
    String showTitle;
    String episodeTitle;
    String airDateUTC;
    int seasonNumber;
    int episodeNumber;
    int seriesID;
    int episodeID;

    SonarrMissingData({
        @required this.showTitle,
        @required this.episodeTitle,
        @required this.seasonNumber,
        @required this.episodeNumber,
        @required this.airDateUTC,
        @required this.seriesID,
        @required this.episodeID,
    });

    DateTime get airDateObject {
        return DateTime.tryParse(airDateUTC)?.toLocal();
    }

    String get seasonEpisode {
        return 'Season $seasonNumber Episode $episodeNumber';
    }

    String get airDateString {
        if(airDateObject != null) {
            Duration age = DateTime.now().difference(airDateObject);
            if(age.inDays >= 1) {
                return age.inDays <= 1 ? '${age.inDays} Day Ago' : '${age.inDays} Days Ago';
            }
            if(age.inHours >= 1) {
                return age.inHours <= 1 ? '${age.inHours} Hour Ago' : '${age.inHours} Hours Ago';
            }
            return age.inMinutes <= 1 ? '${age.inMinutes} Minute Ago' : '${age.inMinutes} Minutes Ago';
        }
        return 'Unknown Date/Time';
    }

    String posterURI({bool highRes = false}) {
        if(api['enabled']) {
            String _base = (api['host'] as String).endsWith('/')
                ? '${api['host']}api/MediaCover'
                : '${api['host']}/api/MediaCover';
            return highRes
                ? '$_base/$seriesID/poster.jpg?apikey=${api['key']}'
                : '$_base/$seriesID/poster-500.jpg?apikey=${api['key']}';
        }
        return '';
    }

    String fanartURI({bool highRes = false}) {
        if(api['enabled']) {
            String _base = (api['host'] as String).endsWith('/')
                ? '${api['host']}api/MediaCover'
                : '${api['host']}/api/MediaCover';
            return highRes
                ? '$_base/$seriesID/fanart.jpg?apikey=${api['key']}'
                : '$_base/$seriesID/fanart-360.jpg?apikey=${api['key']}'; 
        }
        return '';
    }

    String bannerURI({bool highRes = false}) {
        if(api['enabled']) {
            String _base = (api['host'] as String).endsWith('/')
                ? '${api['host']}api/MediaCover'
                : '${api['host']}/api/MediaCover';
            return highRes
                ? '$_base/$seriesID/banner.jpg?apikey=${api['key']}'
                : '$_base/$seriesID/banner-70.jpg?apikey=${api['key']}'; 
        }
        return '';
    }
}