import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:tautulli/tautulli.dart';

class TautulliStatisticsMediaTile extends StatelessWidget {
    final Map<String, dynamic> data;
    final TautulliMediaType mediaType;
    final double _imageDimension = 83.0;
    final double _padding = 8.0;

    TautulliStatisticsMediaTile({
        Key key,
        @required this.data,
        @required this.mediaType,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) => LSCard(
        child: InkWell(
            borderRadius: BorderRadius.circular(Constants.UI_BORDER_RADIUS),
            child: Row(
                children: [
                    _poster(context),
                    _details(context),
                ],
            ),
            onTap: () async => _onTap(context),
        ),
        decoration: data['art'] != null && (data['art'] as String).isNotEmpty
            ? LSCardBackground(
                darken: true,
                uri: Provider.of<TautulliState>(context, listen: false).getImageURLFromPath(
                    data['art'],
                    width: MediaQuery.of(context).size.width.truncate(),
                ),
                headers: Provider.of<TautulliState>(context, listen: false).headers.cast<String, String>(),
            )
            : null,
    );

    Widget _poster(BuildContext context) => LSNetworkImage(
        url: Provider.of<TautulliState>(context, listen: false).getImageURLFromPath(data['thumb']),
        headers: Provider.of<TautulliState>(context, listen: false).headers.cast<String, String>(),
        placeholder: 'assets/images/sonarr/noseriesposter.png',
        height: _imageDimension,
        width: _imageDimension/1.5,
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
        text: data['title'],
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
                        color: Provider.of<TautulliState>(context, listen: false).statisticsType == TautulliStatsType.PLAYS
                            ? LunaColours.accent
                            : null,
                        fontWeight: Provider.of<TautulliState>(context, listen: false).statisticsType == TautulliStatsType.PLAYS
                            ? FontWeight.w600
                            : null,
                    ),
                ),
                TextSpan(text: '\n'),
                data['total_duration'] != null
                    ? TextSpan(
                        text: Duration(seconds: data['total_duration']).lsDuration_fullTimestamp(),
                        style: TextStyle(
                            color: Provider.of<TautulliState>(context, listen: false).statisticsType == TautulliStatsType.DURATION
                                ? LunaColours.accent
                                : null,
                            fontWeight: Provider.of<TautulliState>(context, listen: false).statisticsType == TautulliStatsType.DURATION
                                ? FontWeight.w600
                                : null,
                        ),
                    )
                    : TextSpan(text: '${Constants.TEXT_EMDASH}'),
                TextSpan(text: '\n'),
                data['last_play'] != null
                    ? TextSpan(text:
                        'Last Played '
                        + DateTime.now().lsDateTime_ageString(DateTime.fromMillisecondsSinceEpoch(data['last_play']*1000)),
                    )
                    : TextSpan(text: Constants.TEXT_EMDASH)
            ],
        ),
        softWrap: false,
        maxLines: 3,
        overflow: TextOverflow.fade,
    );

    Future<void> _onTap(BuildContext context) async => TautulliMediaDetailsRouter.navigateTo(context, ratingKey: data['rating_key'], mediaType: mediaType);
}