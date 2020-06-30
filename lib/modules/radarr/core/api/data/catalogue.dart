import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:intl/intl.dart';
import 'package:lunasea/modules/radarr/core.dart';

class RadarrCatalogueData {
    final Map<String, dynamic> api = Database.currentProfileObject.getRadarr();
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

    RadarrCatalogueData({
        @required this.title,
        @required this.sortTitle,
        @required this.studio,
        @required this.physicalRelease,
        @required this.inCinemas,
        @required this.status,
        @required this.year,
        @required this.movieID,
        @required this.monitored,
        @required this.downloaded,
        @required this.sizeOnDisk,
        @required this.runtime,
        @required this.profile,
        @required this.movieFile,
        @required this.overview,
        @required this.path,
        @required this.qualityProfile,
        @required this.minimumAvailability,
        @required this.youtubeId,
        @required this.imdbId,
        @required this.tmdbId,
        @required this.staticPath,
    });

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
        return profile;
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

    String get yearString {
        if(year == null || year == 0) {
            return 'Unknown Year';
        }
        return '$year';
    }

    String subtitle(RadarrCatalogueSorting sorting) {
        String _base = '$yearString${runtime.lsTime_runtimeString(dot: true)}';
        return '$_base\t•\t${_sortSubtitle(sorting)}';
    }

    String _sortSubtitle(RadarrCatalogueSorting sorting) {
        switch(sorting) {
            case RadarrCatalogueSorting.studio: return studio;
            case RadarrCatalogueSorting.year:
            case RadarrCatalogueSorting.runtime:
            case RadarrCatalogueSorting.alphabetical:
            case RadarrCatalogueSorting.quality:
            case RadarrCatalogueSorting.size: return profileString;
        }
        throw Exception('Unknown sorting value');
    }

    TextSpan get releaseSubtitle {
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
                text = now.lsDateTime_upcomingString(physicalReleaseObject)?.toUpperCase();
                color = monitored ? Colors.blue : Colors.blue.withOpacity(0.30);
            }
        } else if(isAnnounced) {
            if(inCinemasObject != null) {
                text = now.lsDateTime_upcomingString(inCinemasObject)?.toUpperCase();
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
                fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
            ),
        );
    }

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
