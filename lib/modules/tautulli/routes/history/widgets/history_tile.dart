import 'package:flutter/material.dart';
import 'package:tautulli/tautulli.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliHistoryTile extends StatelessWidget {
    final int userId;
    final TautulliHistoryRecord history;
    final double _imageDimension = 83.0;
    final double _padding = 8.0;

    TautulliHistoryTile({
        Key key,
        @required this.userId,
        @required this.history,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) => LSCard(
        child: InkWell(
            borderRadius: BorderRadius.circular(Constants.UI_BORDER_RADIUS),
            child: Row(
                children: [
                    _poster(context),
                    _details,
                ],
            ),
            onTap: () async => _onTap(context),
        ),
        decoration: LunaCardDecoration(
            uri: context.watch<TautulliState>().getImageURLFromRatingKey(
                history.grandparentRatingKey ?? history.parentRatingKey ?? history.ratingKey ?? '',
                width: MediaQuery.of(context).size.width.truncate(),
            ),
            headers: context.watch<TautulliState>().headers.cast<String, String>(),
        ),
    );

    Widget _poster(BuildContext context) => LSNetworkImage(
        url: context.watch<TautulliState>().getImageURLFromPath(history.thumb),
        headers: context.watch<TautulliState>().headers.cast<String, String>(),
        height: _imageDimension,
        width: _imageDimension/1.5,
        placeholder: 'assets/images/sonarr/noseriesposter.png',
    );

    Widget get _details => Expanded(
        child: Padding(
            child: Container(
                child: Column(
                    children: [
                        LSTitle(text: history.lsTitle, maxLines: 1),
                        _subtitle,
                        LSSubtitle(text: history.lsDate),
                        _userInfo,
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

    Widget get _subtitle => RichText(
        text: TextSpan(
            style: TextStyle(
                color: Colors.white70,
                fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
            ),
            children: <TextSpan>[
                // Television
                if(history.mediaType == TautulliMediaType.EPISODE) TextSpan(text: 'S${history.parentMediaIndex}\t•\tE${history.mediaIndex}'),
                if(history.mediaType == TautulliMediaType.EPISODE) TextSpan(text: '\t—\t${history.title}'),
                // Movie
                if(history.mediaType == TautulliMediaType.MOVIE) TextSpan(text: history.year.toString()),
                // Music
                if(history.mediaType == TautulliMediaType.TRACK) TextSpan(text: history.title),
                if(history.mediaType == TautulliMediaType.TRACK) TextSpan(text: '\t—\t${history.parentTitle}'),
                // Live
                if(history.mediaType == TautulliMediaType.LIVE) TextSpan(text: history.title),
            ],
        ),
        softWrap: false,
        maxLines: 1,
        overflow: TextOverflow.fade,
    );

    Widget get _userInfo => Row(
        children: [
            Padding(
                child: LSIcon(
                    icon: history.lsWatchStatusIcon,
                    size: Constants.UI_FONT_SIZE_SUBHEADER,
                ),
                padding: EdgeInsets.only(right: 6.0),
            ),
            Expanded(
                child: LSSubtitle(
                    text: history.friendlyName ?? 'Unknown User',
                    maxLines: 1,  
                ),
            )
        ],
    );

    Future<void> _onTap(BuildContext context) async => TautulliHistoryDetailsRouter.navigateTo(
        context,
        ratingKey: history.ratingKey,
        sessionKey: history.sessionKey,
        referenceId: history.referenceId,
    );
}
