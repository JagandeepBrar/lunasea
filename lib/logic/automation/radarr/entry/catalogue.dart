import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/system.dart';
import 'package:intl/intl.dart';

class RadarrCatalogueEntry {
    String title;
    String sortTitle;
    String studio;
    String physicalRelease;
    String inCinemas;
    String status;
    String profile;
    String overview;
    String path;
    String minimumAvailability;
    int movieID;
    int year;
    int sizeOnDisk;
    int runtime;
    int qualityProfile;
    bool monitored;
    bool downloaded;
    bool staticPath;
    Map movieFile;
    String youtubeId;
    String imdbId;
    int tmdbId;

    RadarrCatalogueEntry(
        this.title,
        this.sortTitle,
        this.studio,
        this.physicalRelease,
        this.inCinemas,
        this.status,
        this.year,
        this.movieID,
        this.monitored,
        this.downloaded,
        this.sizeOnDisk,
        this.runtime,
        this.profile,
        this.movieFile,
        this.overview,
        this.path,
        this.qualityProfile,
        this.minimumAvailability,
        this.youtubeId,
        this.imdbId,
        this.tmdbId,
        this.staticPath,
    );

    bool get isTBA {
        if(status == 'tba') {
            return true;
        }
        return false;
    }

    bool get isAnnounced {
        if(status == 'announced') {
            return true;
        }
        return false;
    }

    bool get isInCinemas {
        if(status == 'released' || status == 'inCinemas') {
            return true;
        }
        return false;
    }

    bool get isPhysicallyReleased {
        if(status == 'released') {
            return true;
        }
        return false;
    }

    String get profileString {
        if(profile == null || profile == '') {
            return '';
        }
        return '\t•\t$profile';
    }

    DateTime get inCinemasObject {
        if(inCinemas != null) {
            return DateTime.tryParse(inCinemas)?.toLocal();
        }
        return null;
    }

    DateTime get physicalReleaseObject {
        if(physicalRelease != null) {
            return DateTime.tryParse(physicalRelease)?.toLocal();
        }
        return null;
    }

    String get inCinemasString {
        if(inCinemasObject != null) {
            return DateFormat('MMMM dd, y').format(inCinemasObject);
        }
        return 'Unknown';
    }

    String get physicalReleaseString {
        if(physicalReleaseObject != null) {
            return DateFormat('MMMM dd, y').format(physicalReleaseObject);
        }
        return 'Unknown';
    }

    TextSpan get subtitle {
        String text = '';
        Color color = Colors.white;
        DateTime now = DateTime.now();
        if (downloaded) {
            text = sizeOnDisk?.lsBytes_BytesToString();
            color = monitored ? Color(Constants.ACCENT_COLOR) : Color(Constants.ACCENT_COLOR).withOpacity(0.30);
        } else if(isPhysicallyReleased) {
            text = '';
        } else if(isInCinemas) {
            if(physicalReleaseObject != null) {
                text = Functions.daysDifferenceReadable(now, physicalReleaseObject);
                color = monitored ? Colors.blue : Colors.blue.withOpacity(0.30);
            }
        } else if(isAnnounced) {
            if(inCinemasObject != null) {
                text = Functions.daysDifferenceReadable(now, inCinemasObject);
                color = monitored ? Colors.orange : Colors.orange.withOpacity(0.30);
            }
        } else if(isTBA) {
            text = 'TO BE ANNOUNCED';
            color = monitored ? Color(Constants.ACCENT_COLOR) : Color(Constants.ACCENT_COLOR).withOpacity(0.30); 
        }
        return TextSpan(
            text: text,
            style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
            ),
        );
    }

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