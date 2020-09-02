import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:tautulli/tautulli.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliHistoryTile extends StatelessWidget {
    final TautulliHistoryRecord history;
    final double _imageDimension = 83.0;
    final double _padding = 8.0;

    TautulliHistoryTile({
        Key key,
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
        decoration: LSCardBackground(
            darken: true,
            uri: Provider.of<TautulliState>(context, listen: false).getImageURLFromRatingKey(
                history.grandparentRatingKey ?? history.parentRatingKey ?? history.ratingKey ?? '',
            ),
            headers: Provider.of<TautulliState>(context, listen: false).headers.cast<String, String>(),
        ),
    );

    Widget _poster(BuildContext context) => CachedNetworkImage(
        fadeInDuration: Duration(milliseconds: Constants.UI_NAVIGATION_SPEED),
        fadeOutDuration: Duration(milliseconds: Constants.UI_NAVIGATION_SPEED),
        imageUrl: Provider.of<TautulliState>(context, listen: false).getImageURLFromPath(history.thumb),
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
                image: AssetImage('assets/images/sonarr/noseriesposter.png'),
                fit: BoxFit.cover,
            ),
        ),
    );

    Widget get _details => Expanded(
        child: Padding(
            child: Container(
                child: Column(
                    children: [
                        _title,
                        _subtitle,
                        _date,
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

    Widget get _title => LSTitle(
        text: history.header,
        maxLines: 1,
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

    Widget get _userInfo {
        IconData _icon;
        switch(history.watchedStatus) {
            case TautulliWatchedStatus.UNWATCHED: _icon = Icons.radio_button_unchecked; break;
            case TautulliWatchedStatus.PARTIALLY_WATCHED: _icon = Icons.radio_button_checked; break;
            case TautulliWatchedStatus.WATCHED: _icon = Icons.check_circle; break;
        }
        return Row(
            children: [
                Padding(
                    child: LSIcon(
                        icon: _icon,
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
    }

    Widget get _date => LSSubtitle(text: DateTime.now().lsDateTime_ageString(history.date));

    Future<void> _onTap(BuildContext context) async => Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => ChangeNotifierProvider.value(
            value: Provider.of<TautulliLocalState>(context, listen: false),
            child: TautulliHistoryDetailsRoute(history: history),
        )),
    );
}
