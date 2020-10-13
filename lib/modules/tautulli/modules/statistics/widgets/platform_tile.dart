import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:tautulli/tautulli.dart';

class TautulliStatisticsPlatformTile extends StatelessWidget {
    final Map<String, dynamic> data;
    final double _imageDimension = 83.0;
    final double _padding = 8.0;

    TautulliStatisticsPlatformTile({
        Key key,
        @required this.data,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) => LSCard(
        child: Row(
            children: [
                _placeholder,
                _details(context),
            ],
        ),
    );

    Widget get _placeholder => Container(
        height: _imageDimension,
        width: _imageDimension/1.5,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Constants.UI_BORDER_RADIUS),
            image: DecorationImage(
                image: AssetImage('assets/images/tautulli/platform.png'),
                fit: BoxFit.cover,
            ),
        ),
    );

    Widget _details(BuildContext context) => Expanded(
        child: Padding(
            child: Container(
                child: Column(
                    children: [
                        _title,
                        _subtitle(context),
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                ),
                height: (_imageDimension-(_padding*2)),
            ),
            padding: EdgeInsets.all(_padding),
        ),
    );

    Widget get _title => LSTitle(
        text: data['platform'] ?? 'Unknown Platform',
        maxLines: 1,
    );

    Widget _subtitle(BuildContext context) => RichText(
        text: TextSpan(
            style: TextStyle(
                color: Colors.white70,
                fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
            ),
            children: <TextSpan>[
                TextSpan(
                    text: data['total_plays'].toString() + (data['total_plays'] == 1 ? ' Play' : ' Plays'),
                    style: TextStyle(
                        color: context.watch<TautulliState>().statisticsType == TautulliStatsType.PLAYS
                            ? LunaColours.accent
                            : null,
                        fontWeight: context.watch<TautulliState>().statisticsType == TautulliStatsType.PLAYS
                            ? FontWeight.w600
                            : null,
                    ),
                ),
                TextSpan(text: '\n'),
                data['total_duration'] != null
                    ? TextSpan(
                        text: Duration(seconds: data['total_duration']).lsDuration_fullTimestamp(),
                        style: TextStyle(
                            color: context.watch<TautulliState>().statisticsType == TautulliStatsType.DURATION
                                ? LunaColours.accent
                                : null,
                            fontWeight: context.watch<TautulliState>().statisticsType == TautulliStatsType.DURATION
                                ? FontWeight.w600
                                : null,
                        ),
                    )
                    : TextSpan(text: '${Constants.TEXT_EMDASH}'),
                TextSpan(text: '\n'),
                data['last_play'] != null
                    ? TextSpan(text:
                        'Last Used '
                        + DateTime.now().lsDateTime_ageString(DateTime.fromMillisecondsSinceEpoch(data['last_play']*1000)),
                    )
                    : TextSpan(text: Constants.TEXT_EMDASH)
            ],
        ),
        softWrap: false,
        maxLines: 3,
        overflow: TextOverflow.fade,
    );
}