import 'package:flutter/material.dart';
import 'package:lunasea/system.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/logic/abstracts.dart';
import 'package:lunasea/widgets/ui.dart';

class CalendarLidarrEntry extends CalendarEntry {
    String albumTitle;
    int artistId;
    bool hasAllFiles;

    CalendarLidarrEntry({
        @required int id,
        @required String title,
        @required this.albumTitle,
        @required this.artistId,
        @required this.hasAllFiles,
    }) : super(id, title);

    @override
    String get bannerURI {
        List<dynamic> values = Values.lidarrValues;
        return '${values[1]}/api/v1/MediaCover/Artist/$artistId/banner.jpg?apikey=${values[2]}';
    }

    @override
    TextSpan get subtitle => TextSpan(
        style: TextStyle(
            color: Colors.white70,
            fontSize: 14.0,
        ),
        children: <TextSpan>[
            TextSpan(
                text: albumTitle,
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                ),
            ),
            if(!hasAllFiles) TextSpan(
                text: '\nNot Downloaded',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                ),
            ),
            if(hasAllFiles) TextSpan(
                text: '\nDownloaded',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(Constants.ACCENT_COLOR),
                ),
            )
        ],
    );

    @override
    Future<void> enterContent(BuildContext context) async {
    }

    @override
    IconButton get trailing => IconButton(
        icon: Elements.getIcon(Icons.arrow_forward_ios),
        onPressed: null,
    );
}