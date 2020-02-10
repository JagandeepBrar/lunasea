import 'package:flutter/material.dart';
import 'package:lunasea/system.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/logic/abstracts.dart';

class CalendarSonarrEntry extends CalendarEntry {
    String episodeTitle;
    int seasonNumber;
    int episodeNumber;
    int seriesID;
    String airTime;
    bool hasFile;
    String fileQualityProfile;

    CalendarSonarrEntry({
        @required int id,
        @required String title,
        @required this.episodeTitle,
        @required this.seasonNumber,
        @required this.episodeNumber,
        @required this.seriesID,
        @required this.airTime,
        @required this.hasFile,
        @required this.fileQualityProfile,
    }) : super(id, title);

    @override
    TextSpan get subtitle {
        return TextSpan(
            style: TextStyle(
                color: Colors.white70,
                fontSize: 14.0,
            ),
            children: <TextSpan>[
                TextSpan(
                    text: 'Season $seasonNumber Episode $episodeNumber: ',
                ),
                TextSpan(
                    text: episodeTitle,
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                    ),
                ),
                if(!hasFile) TextSpan(
                    text: '\nNot Downloaded',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                    ),
                ),
                if(hasFile) TextSpan(
                    text: '\nDownloaded ($fileQualityProfile)',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(Constants.ACCENT_COLOR),
                    ),
                )
            ],
        );
    }

    @override
    String bannerURI({bool highRes = false}) {
        List<dynamic> values = Values.sonarrValues;
        if(highRes) {
            return '${values[1]}/api/mediacover/$seriesID/banner.jpg?apikey=${values[2]}';
        }
        return '${values[1]}/api/mediacover/$seriesID/banner-70.jpg?apikey=${values[2]}';
    }
}