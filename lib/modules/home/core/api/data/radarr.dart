import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';
import './abstract.dart';

class CalendarRadarrData extends CalendarData {
    final Map<String, dynamic> api = Database.currentProfileObject.getRadarr();
    bool hasFile;
    String fileQualityProfile;
    int year;
    int runtime;

    CalendarRadarrData({
        @required int id,
        @required String title,
        @required this.hasFile,
        @required this.fileQualityProfile,
        @required this.year,
        @required this.runtime,
    }): super(id, title);

    String get runtimeString {
        return runtime.lsTime_runtimeString(dot: true);
    }

    TextSpan get subtitle => TextSpan(
        style: TextStyle(
            color: Colors.white70,
            fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
        ),
        children: <TextSpan>[
            TextSpan(
                text: '$year$runtimeString',
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
            ? (api['host'] as String).endsWith('/')
                ? '${api['host']}api/MediaCover/$id/fanart-360.jpg?apikey=${api['key']}'
                : '${api['host']}/api/MediaCover/$id/fanart-360.jpg?apikey=${api['key']}'
            : '';
    }

    Future<void> enterContent(BuildContext context) async => Navigator.of(context).pushNamed(
        RadarrDetailsMovie.ROUTE_NAME,
        arguments: RadarrDetailsMovieArguments(
            data: null,
            movieID: id,
        ),
    );

    Widget trailing(BuildContext context) => LSIconButton(
        icon: Icons.search,
        onPressed: () async => trailingOnPress(context),
        onLongPress: () async => trailingOnLongPress(context),
    );

    @override
    Future<void> trailingOnPress(BuildContext context) async {
        await RadarrAPI.from(Database.currentProfileObject).automaticSearchMovie(id)
        .then((_) => LSSnackBar(context: context, title: 'Searching...', message: title))
        .catchError((_) => LSSnackBar(context: context, title: 'Failed to Search', message: Constants.CHECK_LOGS_MESSAGE, type: SNACKBAR_TYPE.failure));
    }
    
    @override
    Future<void> trailingOnLongPress(BuildContext context) async => Navigator.of(context).pushNamed(
        RadarrSearchResults.ROUTE_NAME,
        arguments: RadarrSearchResultsArguments(
            movieID: id,
            title: title,
        ),
    );
}
