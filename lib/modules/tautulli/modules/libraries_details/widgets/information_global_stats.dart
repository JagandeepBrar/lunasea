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
    Widget build(BuildContext context) => LSTableBlock(
        title: 'Global Stats',
        children: List.generate(
            watchtime.length,
            (index) => LSTableContent(
                title: _title(watchtime[index].queryDays),
                body: _body(watchtime[index].totalPlays, watchtime[index].totalTime),
            ),
        ),
    );

    String _title(int days) {
        if(days == 0) return 'All Time';
        if(days == 1) return '24 Hours';
        return '$days Days';
    }

    String _body(int plays, Duration duration) {
        String _plays = plays == 1 ? '1 Play': '$plays Plays';
        return '$_plays\n${duration.lunaTimestampWords}';
    }
}
