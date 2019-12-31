import 'package:flutter/material.dart';
import 'package:lunasea/configuration/values.dart';
import 'package:lunasea/system/functions.dart';

class RadarrMissingEntry {
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
        if(runtime == null || runtime == 0) {
            return '';
        }
        return Functions.runtimeReadable(runtime, withDot: true);
    }

    List<TextSpan> get subtitle {
        DateTime now = DateTime.now();
        return [
            TextSpan(
                text: '$year$runtimeString$profileString',
            ),
            status == 'inCinemas' ? (
                TextSpan(
                    text: physicalReleaseObject != null ?
                        physicalReleaseObject.difference(now).inDays == 0 ?
                        '\nAvailable Today' :
                        '\nAvailable in ${physicalReleaseObject.difference(now).inDays} Days' :
                        '\nAvailability Unknown',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                    ),
                )
            ) : (
                TextSpan(
                    text: physicalReleaseObject != null ? 
                        now.difference(physicalReleaseObject).inDays == 0 ?
                            '\nReleasing Today' :
                            '\nReleased ${now.difference(physicalReleaseObject).inDays} Days Ago' :
                            '\nReleased',
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                    )
                )
            ),
        ];
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