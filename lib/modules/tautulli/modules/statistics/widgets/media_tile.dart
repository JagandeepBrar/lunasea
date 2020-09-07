import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:tautulli/tautulli.dart';

class TautulliStatisticsMediaTile extends StatelessWidget {
    final Map<String, dynamic> data;
    final double _imageDimension = 83.0;
    final double _padding = 8.0;

    TautulliStatisticsMediaTile({
        Key key,
        @required this.data,
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
                uri: Provider.of<TautulliState>(context, listen: false).getImageURLFromPath(data['art']),
                headers: Provider.of<TautulliState>(context, listen: false).headers.cast<String, String>(),
            )
            : null,
    );

    Widget _poster(BuildContext context) => CachedNetworkImage(
        fadeInDuration: Duration(milliseconds: Constants.UI_NAVIGATION_SPEED),
        fadeOutDuration: Duration(milliseconds: Constants.UI_NAVIGATION_SPEED),
        imageUrl: Provider.of<TautulliState>(context, listen: false).getImageURLFromPath(data['thumb']),
        httpHeaders: Provider.of<TautulliState>(context, listen: false).headers.cast<String, String>(),
        memCacheHeight: _imageDimension.truncate(),
        memCacheWidth: (_imageDimension/1.5).truncate(),
        imageBuilder: (context, imageProvider) => Container(
            height: _imageDimension,
            width: _imageDimension/1.5,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Constants.UI_BORDER_RADIUS),
                image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                ),
            ),
        ),
        placeholder: (context, url) => _placeholder,
        errorWidget: (context, url, error) => _placeholder,
    );

    Widget get _placeholder => Container(
        height: _imageDimension,
        width: _imageDimension/1.5,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Constants.UI_BORDER_RADIUS),
            image: DecorationImage(
                image: AssetImage('assets/images/sonarr/noseriesposter.png'),
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
                            ? LSColors.accent
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
                                ? LSColors.accent
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

    Future<void> _onTap(BuildContext context) async => LSSnackBar(
        context: context,
        title: 'Coming Soon!',
        message: 'This feature has not yet been implemented',
        type: SNACKBAR_TYPE.info,
    );
}