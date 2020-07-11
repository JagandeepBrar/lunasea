import 'package:flutter/material.dart';
import 'package:lunasea/core/database.dart';
import 'package:intl/intl.dart';

class LidarrAlbumData {
    final Map<String, dynamic> api = Database.currentProfileObject.getLidarr();
    String title;
    String releaseDate;
    int albumID;
    int trackCount;
    double percentageTracks;
    bool monitored;
    
    LidarrAlbumData({
        @required this.albumID,
        @required this.title,
        @required this.monitored,
        @required this.trackCount,
        @required this.percentageTracks,
        @required this.releaseDate,
    });

    DateTime get releaseDateObject {
        if(releaseDate != null) {
            return DateTime.tryParse(releaseDate)?.toLocal();
        }
        return null;
    }

    String get releaseDateString {
        if(releaseDateObject != null) {
            return DateFormat('MMMM dd, y').format(releaseDateObject);

        }
        return 'Unknown Release Date';
    }

    String get tracks {
        return trackCount != 1 ?
            '$trackCount Tracks' :
            '$trackCount Track';
    }

    String albumCoverURI({bool highRes = false}) {
        if(api['enabled']) {
            String _base = (api['host'] as String).endsWith('/')
                ? '${api['host']}api/v1/MediaCover/Album'
                : '${api['host']}/api/v1/MediaCover/Album';
            return highRes
                ? '$_base/$albumID/cover.jpg?apikey=${api['key']}'
                : '$_base/$albumID/cover-500.jpg?apikey=${api['key']}';
        }
        return '';
    }
}
