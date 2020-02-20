import 'package:flutter/material.dart';
import 'package:lunasea/core/database.dart';
import 'package:lunasea/system.dart';

class RadarrMissingEntry {
    final Map<String, dynamic> api = Database.getProfileObject().getRadarr();
    String title;
    String sortTitle;
    String studio;
    String physicalRelease;
    String inCinemas;
    String profile;
    String status;
    int movieID;
    int year;
    int runtime;


    RadarrMissingEntry(
        this.movieID,
        this.title,
        this.sortTitle,
        this.studio,
        this.physicalRelease,
        this.inCinemas,
        this.profile,
        this.year,
        this.runtime,
        this.status,
    );

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

    String get profileString {
        if(profile == null || profile == '') {
            return '';
        }
        return '\t•\t$profile';
    }

    String get runtimeString {
        return runtime.lsTime_runtimeString(dot: true);
    }

    List<TextSpan> get subtitle {
        DateTime now = DateTime.now();
        return [
            TextSpan(
                text: '$year$runtimeString$profileString',
            ),
            if(status == 'released') TextSpan(
                text: physicalReleaseObject != null ? 
                    now.difference(physicalReleaseObject).inDays == 0 ?
                        '\nReleasing Today' :
                        '\nReleased ${now.difference(physicalReleaseObject).inDays} Days Ago' :
                        '\nReleased',
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                )
            ),
            if(status == 'inCinemas') TextSpan(
                text: physicalReleaseObject != null ?
                    physicalReleaseObject.difference(now).inDays == 0 ?
                    '\nAvailable Today' :
                    '\nAvailable in ${physicalReleaseObject.difference(now).inDays} Days' :
                    '\nAvailability Unknown',
                style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                ),
            ),
            if(status == 'announced') TextSpan(
                text: inCinemasObject != null ? 
                    now.difference(inCinemasObject).inDays == 0 ?
                        '\nIn Cinemas Today' :
                        '\nIn Cinemas in ${inCinemasObject.difference(now).inDays} Days' :
                        '\nIn Cinemas Later',
                style: TextStyle(
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                )
            ),
        ];
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