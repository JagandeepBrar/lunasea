import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class RadarrMissingData {
    final Map<String, dynamic> api = Database.currentProfileObject.getRadarr();
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


    RadarrMissingData({
        @required this.movieID,
        @required this.title,
        @required this.sortTitle,
        @required this.studio,
        @required this.physicalRelease,
        @required this.inCinemas,
        @required this.profile,
        @required this.year,
        @required this.runtime,
        @required this.status,
    });

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

    String get runtimeString => runtime.lunaRuntime().isEmpty ? '' : '\t${Constants.TEXT_BULLET}\t${runtime.lunaRuntime()}';

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
                        '\nReleased ${now.difference(physicalReleaseObject).inDays} ${now.difference(physicalReleaseObject).inDays == 1 ? "Day" : "Days"} Ago' :
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
                    '\nAvailable in ${physicalReleaseObject.difference(now).inDays} ${physicalReleaseObject.difference(now).inDays == 1 ? "Day" : "Days"}' :
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
                        '\nIn Cinemas in ${inCinemasObject.difference(now).inDays} ${inCinemasObject.difference(now).inDays == 1 ? "Day" : "Days"}' :
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
            String _base = (api['host'] as String).endsWith('/')
                ? '${api['host']}api/MediaCover'
                : '${api['host']}/api/MediaCover';
            return highRes
                ? '$_base/$movieID/poster.jpg?apikey=${api['key']}'
                : '$_base/$movieID/poster-500.jpg?apikey=${api['key']}';
        }
        return '';
    }

    String fanartURI({bool highRes = false}) {
        if(api['enabled']) {
            String _base = (api['host'] as String).endsWith('/')
                ? '${api['host']}api/MediaCover'
                : '${api['host']}/api/MediaCover';
            return highRes
                ? '$_base/$movieID/fanart.jpg?apikey=${api['key']}'
                : '$_base/$movieID/fanart-360.jpg?apikey=${api['key']}'; 
        }
        return '';
    }
}