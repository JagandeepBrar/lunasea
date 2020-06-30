import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';
import './abstract.dart';

class CalendarSonarrData extends CalendarData {
    final Map<String, dynamic> api = Database.currentProfileObject.getSonarr();
    String episodeTitle;
    int seasonNumber;
    int episodeNumber;
    int seriesID;
    String airTime;
    bool hasFile;
    String fileQualityProfile;

    CalendarSonarrData({
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

    TextSpan get subtitle => TextSpan(
        style: TextStyle(
            color: Colors.white70,
            fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
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
                    color: LSColors.accent,
                ),
            )
        ],
    );

    String get bannerURI {
        return api['enabled']
            ? '${api['host']}/api/mediacover/$seriesID/banner-70.jpg?apikey=${api['key']}'
            : '';
    }

    Future<void> enterContent(BuildContext context) async => Navigator.of(context).pushNamed(
        SonarrDetailsSeries.ROUTE_NAME,
        arguments: SonarrDetailsSeriesArguments(
            data: null,
            seriesID: seriesID,
        ),
    );

    Widget get trailing => IconButton(
        icon: Text(
            airTimeString,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 10.0,
            ),
        ),
        onPressed: null,
    );

    DateTime get airTimeObject {
        return DateTime.tryParse(airTime)?.toLocal();
    }

    String get airTimeString => airTimeObject != null
        ? DateFormat('KK:mm\na').format(airTimeObject)
        : 'N/A';
}