import 'dart:math';
import 'package:flutter/material.dart';
import 'package:tautulli/tautulli.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliActivityTile extends StatelessWidget {
    final TautulliSession session;
    final bool disableOnTap;
    final double _height = 105.0;
    final double _width = 70.0;
    final double _padding = 8.0;

    TautulliActivityTile({
        Key key,
        @required this.session,
        this.disableOnTap = false,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) => LSCard(
        child: disableOnTap
        ? _body(context)
        : InkWell(
            child: _body(context),
            borderRadius: BorderRadius.circular(Constants.UI_BORDER_RADIUS),
            onTap: () async => _enterDetails(context),
        ),
        decoration: session.art != null && session.art.isNotEmpty
            ? LSCardBackground(
                uri: Provider.of<TautulliState>(context, listen: false).getImageURLFromPath(session.art),
                headers: Provider.of<TautulliState>(context, listen: false).headers,
                darken: true,
            )
            : null,
    );

    Widget _body(BuildContext context) => Row(
        children: [
            _poster(context),
            Expanded(child: _mediaInfo),
        ],
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
    );

    String _artworkPath(BuildContext context) {
        TautulliState _state = Provider.of<TautulliState>(context, listen: false);
        switch(session.mediaType) {
            case TautulliMediaType.EPISODE: return _state.getImageURLFromRatingKey(session.grandparentRatingKey);
            case TautulliMediaType.TRACK: return _state.getImageURLFromRatingKey(session.parentRatingKey);
            case TautulliMediaType.MOVIE:
            case TautulliMediaType.LIVE: 
            default: return _state.getImageURLFromRatingKey(session.ratingKey);
        }
    }

    Widget get _mediaInfo => Padding(
        child: Container(
            child: Column(
                children: [
                    _title,
                    _subtitle,
                    _transcodeDecision,
                    _user,
                    _progressBar,
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
            ),
            height: (_height-(_padding*2)),
        ),
        padding: EdgeInsets.all(_padding),
    );

    Widget get _title => LSTitle(
        text: session.grandparentTitle == null || session.grandparentTitle.isEmpty
            ? session.parentTitle == null || session.parentTitle.isEmpty
            ? session.title == null || session.title.isEmpty
            ? 'Unknown Title'
            : session.title
            : session.parentTitle
            : session.grandparentTitle,
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
                if(session.mediaType == TautulliMediaType.EPISODE) TextSpan(text: 'S${session.parentMediaIndex}\t•\tE${session.mediaIndex}'),
                if(session.mediaType == TautulliMediaType.EPISODE) TextSpan(text: '\t—\t${session.title}'),
                // Movie
                if(session.mediaType == TautulliMediaType.MOVIE) TextSpan(text: session.year.toString()),
                // Music
                if(session.mediaType == TautulliMediaType.TRACK) TextSpan(text: session.title),
                if(session.mediaType == TautulliMediaType.TRACK) TextSpan(text: '\t—\t${session.parentTitle}'),
                // Live
                if(session.mediaType == TautulliMediaType.LIVE) TextSpan(text: session.title),
            ],
        ),
        softWrap: false,
        maxLines: 1,
        overflow: TextOverflow.fade,
    );

    Widget get _transcodeDecision {
        String _value = '';
        switch(session.transcodeDecision) {
            case TautulliTranscodeDecision.TRANSCODE:
                String _transcodeStatus = session.transcodeThrottled ? 'Throttled' : '${session.transcodeSpeed ?? 0.0}x';
                _value = 'Transcoding ($_transcodeStatus)';
                break;
            case TautulliTranscodeDecision.DIRECT_PLAY:
            case TautulliTranscodeDecision.COPY:
            case TautulliTranscodeDecision.NULL: _value = session.transcodeDecision.name ?? 'Unknown'; break;
        }
        return LSSubtitle(text: _value, maxLines: 1);
    }

    Widget _poster(BuildContext context) => CachedNetworkImage(
        fadeInDuration: Duration(milliseconds: Constants.UI_NAVIGATION_SPEED),
        fadeOutDuration: Duration(milliseconds: Constants.UI_NAVIGATION_SPEED),
        imageUrl: _artworkPath(context),
        httpHeaders: Provider.of<TautulliState>(context, listen: false).headers.cast<String, String>(),
        imageBuilder: (context, imageProvider) => Container(
            height: _height,
            width: _width,
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
        height: _height,
        width: _width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Constants.UI_BORDER_RADIUS),
            image: DecorationImage(
                image: AssetImage('assets/images/radarr/nomovieposter.png'),
                fit: BoxFit.cover,
            ),
        ),
    );

    Widget get _user {
        IconData _icon;
        switch(session.state) {
            case TautulliSessionState.PAUSED: _icon = Icons.pause; break;
            case TautulliSessionState.PLAYING: _icon = Icons.play_arrow; break;
            case TautulliSessionState.BUFFERING:
            default: _icon = Icons.compare_arrows; break;
        }
        return Row(
            children: [
                LSIcon(
                    icon: _icon,
                    size: Constants.UI_FONT_SIZE_SUBTITLE,
                    color: Colors.white70,
                ),
                LSSubtitle(text: '\t${session.friendlyName}'),
            ],
        );
    }

    Widget get _progressBar => Padding(
        child: Stack(
            children: [
                LinearPercentIndicator(
                    percent: min(1.0, max(0, session.transcodeProgress/100)),
                    padding: EdgeInsets.symmetric(horizontal: 2.0),
                    progressColor: LSColors.splash.withOpacity(0.30),
                    backgroundColor: Colors.transparent,
                    lineHeight: 4.0,
                ),
                LinearPercentIndicator(
                    percent: min(1.0, max(0, session.progressPercent/100)),
                    padding: EdgeInsets.symmetric(horizontal: 2.0),
                    progressColor: LSColors.accent,
                    backgroundColor: LSColors.accent.withOpacity(0.15),
                    lineHeight: 4.0,
                ),
            ],
        ),
        padding: EdgeInsets.only(top: _padding),
    );

    Future<void> _enterDetails(BuildContext context) async => TautulliRouter.router.navigateTo(
        context,
        TautulliActivityDetailsRoute.enterRoute(sessionId: session.sessionId),
    );
}
