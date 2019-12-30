import 'package:lunasea/configuration/values.dart';

class SonarrMissingEntry {
    String showTitle;
    String episodeTitle;
    String airDateUTC;
    int seasonNumber;
    int episodeNumber;
    int seriesID;
    int episodeID;

    SonarrMissingEntry(
        this.showTitle,
        this.episodeTitle,
        this.seasonNumber,
        this.episodeNumber,
        this.airDateUTC,
        this.seriesID,
        this.episodeID,
    );

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
        List<dynamic> values = Values.sonarrValues;
        if(highRes) {
            return '${values[1]}/api/mediacover/$seriesID/poster.jpg?apikey=${values[2]}';
        }
        return '${values[1]}/api/mediacover/$seriesID/poster-500.jpg?apikey=${values[2]}';
    }

    String fanartURI({bool highRes = false}) {
        List<dynamic> values = Values.sonarrValues;
        if(highRes) {
            return '${values[1]}/api/mediacover/$seriesID/fanart.jpg?apikey=${values[2]}'; 
        }
        return '${values[1]}/api/mediacover/$seriesID/fanart-360.jpg?apikey=${values[2]}'; 
    }

    String bannerURI({bool highRes = false}) {
        List<dynamic> values = Values.sonarrValues;
        if(highRes) {
            return '${values[1]}/api/mediacover/$seriesID/banner.jpg?apikey=${values[2]}';
        }
        return '${values[1]}/api/mediacover/$seriesID/banner-70.jpg?apikey=${values[2]}';
    }
}