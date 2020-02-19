import 'package:lunasea/system.dart';
import 'package:intl/intl.dart';

class LidarrAlbumEntry {
    String title;
    String releaseDate;
    int albumID;
    int trackCount;
    double percentageTracks;
    bool monitored;
    
    LidarrAlbumEntry(
        this.albumID,
        this.title,
        this.monitored,
        this.trackCount,
        this.percentageTracks,
        this.releaseDate,
    );

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
        List<dynamic> values = Values.lidarrValues;
        if(highRes) {
            return '${values[1]}/api/v1/MediaCover/Album/$albumID/cover.jpg?apikey=${values[2]}';
        }
        return '${values[1]}/api/v1/MediaCover/Album/$albumID/cover-500.jpg?apikey=${values[2]}';
    }
}
