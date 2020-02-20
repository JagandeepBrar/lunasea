import 'package:lunasea/core/database.dart';

class LidarrMissingEntry {
    final Map<String, dynamic> api = Database.getProfileObject().getLidarr();
    String title;
    String artistTitle;
    String releaseDate;
    int artistID;
    int albumID;
    bool monitored;

    LidarrMissingEntry(
        this.title,
        this.artistTitle,
        this.artistID,
        this.albumID,
        this.releaseDate,
        this.monitored,
    );

    DateTime get releaseDateObject {
        return DateTime.tryParse(releaseDate)?.toLocal();
    }

    String get releaseDateString {
        if(releaseDateObject != null) {
            Duration age = DateTime.now().difference(releaseDateObject);
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
            return highRes
                ? '${api['host']}/api/v1/MediaCover/Artist/$artistID/poster.jpg?apikey=${api['key']}'
                : '${api['host']}/api/v1/MediaCover/Artist/$artistID/poster-500.jpg?apikey=${api['key']}';
        }
        return '';
    }

    String fanartURI({bool highRes = false}) {
        if(api['enabled']) {
            return highRes
                ? '${api['host']}/api/v1/MediaCover/Artist/$artistID/fanart.jpg?apikey=${api['key']}'
                : '${api['host']}/api/v1/MediaCover/Artist/$artistID/fanart-360.jpg?apikey=${api['key']}';
        }
        return '';
    }

    String bannerURI({bool highRes = false}) {
        if(api['enabled']) {
            return highRes
                ? '${api['host']}/api/v1/MediaCover/Artist/$artistID/banner.jpg?apikey=${api['key']}'
                : '${api['host']}/api/v1/MediaCover/Artist/$artistID/banner-70.jpg?apikey=${api['key']}';
        }
        return '';
    }
}