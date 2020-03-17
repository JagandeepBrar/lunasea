import 'package:flutter/material.dart';
import 'package:lunasea/core/database.dart';

class RadarrUpcomingData {
    final Map<String, dynamic> api = Database.currentProfileObject.getRadarr();
    String title;
    int movieID;

    RadarrUpcomingData({
        @required this.title,
        @required this.movieID,
    });

    String posterURI({bool highRes = false}) {
        if(api['enabled']) {
            return highRes
                ? '${api['host']}/api/MediaCover/$movieID/poster.jpg?apikey=${api['key']}'
                : '${api['host']}/api/MediaCover/$movieID/poster-500.jpg?apikey=${api['key']}';
        }
        return '';
    }

    String fanartURI({bool highRes = false}) {
        if(api['enabled']) {
            return highRes
                ? '${api['host']}/api/mediacover/$movieID/fanart.jpg?apikey=${api['key']}'
                : '${api['host']}/api/mediacover/$movieID/fanart-360.jpg?apikey=${api['key']}'; 
        }
        return '';
    }
}
