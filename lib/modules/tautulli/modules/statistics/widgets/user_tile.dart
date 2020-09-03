import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:tautulli/tautulli.dart';

class TautulliStatisticsUserTile extends StatelessWidget {
    final Map<String, dynamic> data;
    final double _imageDimension = 83.0;
    final double _padding = 8.0;

    TautulliStatisticsUserTile({
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
    );

    Widget _poster(BuildContext context) => CachedNetworkImage(
        fadeInDuration: Duration(milliseconds: Constants.UI_NAVIGATION_SPEED),
        fadeOutDuration: Duration(milliseconds: Constants.UI_NAVIGATION_SPEED),
        imageUrl: Provider.of<TautulliState>(context, listen: false).getImageURLFromPath(data['user_thumb']),
        httpHeaders: Provider.of<TautulliState>(context, listen: false).headers.cast<String, String>(),
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
                image: AssetImage('assets/images/tautulli/nouserthumb.png'),
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
        text: data['friendly_name'] ?? 'Unknown User',
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

    Future<void> _onTap(BuildContext context) async {
        TautulliTableUser _user = await Provider.of<TautulliState>(context, listen: false).users.then(
            (users) => users.users.firstWhere(
                (user) => user.userId == data['user_id'] ?? -1,
                orElse: null,
            ),
        );
        if(_user == null) {
            LSSnackBar(
                context: context,
                title: 'User Not Found',
                message: 'Unable to find the Tautulli user',
                type: SNACKBAR_TYPE.failure,
            );
        } else {
            TautulliRouter.router.navigateTo(
                context,
                TautulliUserDetailsRoute.enterRoute(userId: _user.userId),
            );
        }
    }
}