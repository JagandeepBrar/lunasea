import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

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
            String _base = (api['host'] as String).endsWith('/')
                ? '${api['host']}api/MediaCover'
                : '${api['host']}/api/MediaCover';
            return highRes
                ? '$_base/$movieID/poster.jpg?apikey=${api['key']}'
                : '$_base/$movieID/poster-500.jpg?apikey=${api['key']}';
        }
        return '';
    }

    String fanartURI({bool highRes = false}) {
        if(api['enabled']) {
            String _base = (api['host'] as String).endsWith('/')
                ? '${api['host']}api/MediaCover'
                : '${api['host']}/api/MediaCover';
            return highRes
                ? '$_base/$movieID/fanart.jpg?apikey=${api['key']}'
                : '$_base/$movieID/fanart-360.jpg?apikey=${api['key']}'; 
        }
        return '';
    }
}
