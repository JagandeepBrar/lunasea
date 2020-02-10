import 'package:lunasea/core.dart';

class RadarrUpcomingEntry {
    String title;
    int movieID;

    RadarrUpcomingEntry(
        this.title,
        this.movieID,
    );

    String posterURI({bool highRes = false}) {
        List<dynamic> values = Values.radarrValues;
        if(highRes) {
            return '${values[1]}/api/MediaCover/$movieID/poster.jpg?apikey=${values[2]}';
        }
        return '${values[1]}/api/MediaCover/$movieID/poster-500.jpg?apikey=${values[2]}';
    }

    String fanartURI({bool highRes = false}) {
        List<dynamic> values = Values.radarrValues;
        if(highRes) {
            return '${values[1]}/api/MediaCover/$movieID/fanart.jpg?apikey=${values[2]}';
        }
        return '${values[1]}/api/MediaCover/$movieID/fanart-360.jpg?apikey=${values[2]}';
    }
}
