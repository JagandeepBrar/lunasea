import 'package:lunasea/configuration/values.dart';
import 'package:intl/intl.dart';

class SonarrCatalogueEntry {
    String title;
    String sortTitle;
    String status;
    String previousAiring;
    String nextAiring;
    String network;
    String overview;
    String path;
    String type;
    List<dynamic> seasonData;
    int qualityProfile;
    int seasonCount;
    int episodeCount;
    int episodeFileCount;
    int seriesID;
    String profile;
    bool seasonFolder;
    bool monitored;
    int tvdbId;
    int tvMazeId;
    String imdbId;
    int runtime;

    SonarrCatalogueEntry(
        this.title,
        this.sortTitle,
        this.seasonCount,
        this.seasonData,
        this.episodeCount,
        this.episodeFileCount,
        this.status,
        this.seriesID,
        this.previousAiring,
        this.nextAiring,
        this.network,
        this.monitored,
        this.path,
        this.qualityProfile,
        this.type,
        this.seasonFolder,
        this.overview,
        this.tvdbId,
        this.tvMazeId,
        this.imdbId,
        this.runtime,
        this.profile,
    );

    DateTime get nextAiringObject {
        return DateTime.tryParse(nextAiring)?.toLocal();
    }

    DateTime get previousAiringObject {
        return DateTime.tryParse(previousAiring)?.toLocal();
    }

    String get seasonCountString {
        return seasonCount == 1 ? '$seasonCount Season' : '$seasonCount Seasons';
    }

    String get nextEpisode {
        if(nextAiringObject != null) {
            return DateFormat('MMMM dd, y').format(nextAiringObject);
        }
        return 'Unknown';
    }

    String get airTimeString {
        if(previousAiringObject != null) {
            return DateFormat('hh:mm a').format(previousAiringObject);
        }
        return 'Unknown';
    }

    String get subtitle {
        if(previousAiringObject != null) {
            if(network == null) {
                return status == 'ended' ?
                    '$seasonCountString (Ended)\nAired on Unknown' :
                    '$seasonCountString\n${DateFormat('hh:mm a').format(previousAiringObject)} on Unknown';
            }
            return status == 'ended' ?
                '$seasonCountString (Ended)\nAired on $network' :
                '$seasonCountString\n${DateFormat('hh:mm a').format(previousAiringObject)} on $network';
        } else {
            if(network == null) {
                return status == 'ended' ? 
                    '$seasonCountString (Ended)\n' :
                    '$seasonCountString\nAirs on Unknown';
            }
            return status == 'ended' ? 
                '$seasonCountString (Ended)\nAired on $network' :
                '$seasonCountString\nAirs on $network';
        }
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