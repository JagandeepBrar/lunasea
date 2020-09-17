import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:tautulli/tautulli.dart';

class TautulliLibrariesDetailsInformationGlobalStats extends StatelessWidget {
    final List<TautulliLibraryWatchTimeStats> watchtime;

    TautulliLibrariesDetailsInformationGlobalStats({
        Key key,
        @required this.watchtime,
    }) : super(key: key);
    
    @override
    Widget build(BuildContext context) => LSCard(
        child: Padding(
            child: Column(
                children: List.generate(
                    watchtime.length,
                    (index) => _content(
                        _globalStatsTitle(watchtime[index].queryDays),
                        _globalStatsContent(watchtime[index].totalPlays, watchtime[index].totalTime),
                    ),
                ),
            ),
            padding: EdgeInsets.symmetric(vertical: 8.0),
        ),
    );

    String _globalStatsTitle(int days) {
        if(days == 0) return 'All Time';
        if(days == 1) return '24 Hours';
        return '$days Days';
    }

    String _globalStatsContent(int plays, Duration duration) {
        String _plays = plays == 1 ? '1 Play': '$plays Plays';
        return '$_plays\n${duration.lsDuration_fullTimestamp()}';
    }

    Widget _content(String header, String body) => Padding(
        child: Row(
            children: [
                Expanded(
                    child: Text(
                        header.toUpperCase(),
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            color: Colors.white70,
                            fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                        ),
                    ),
                    flex: 2,
                ),
                Container(width: 16.0, height: 0.0),
                Expanded(
                    child: Text(
                        body,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                        ),
                    ),
                    flex: 5,
                ),
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
        ),
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
    );
}