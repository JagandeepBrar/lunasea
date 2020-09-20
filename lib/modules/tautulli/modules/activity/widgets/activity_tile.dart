import 'package:flutter/material.dart';
import 'package:tautulli/tautulli.dart';
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
                uri: Provider.of<TautulliState>(context, listen: false).getImageURLFromPath(
                    session.art,
                    width: MediaQuery.of(context).size.width.truncate(),
                ),
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

    Widget get _mediaInfo => Padding(
        child: Container(
            child: Column(
                children: [
                    LSTitle(text: session.lsTitle, maxLines: 1),
                    _subtitle,
                    LSSubtitle(text: session.lsTranscodeDecision, maxLines: 1),
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

    Widget _poster(BuildContext context) => LSNetworkImage(
        url: session.lsArtworkPath(context),
        placeholder: 'assets/images/sonarr/noseriesposter.png',
        height: _height,
        width: _width,
        headers: Provider.of<TautulliState>(context, listen: false).headers.cast<String, String>(),
    );

    Widget get _user => Row(
        children: [
            LSIcon(
                icon: session.lsStateIcon,
                size: Constants.UI_FONT_SIZE_SUBTITLE,
                color: Colors.white70,
            ),
            LSSubtitle(text: '\t${session.friendlyName}'),
        ],
    );

    Widget get _progressBar => Padding(
        child: Stack(
            children: [
                LinearPercentIndicator(
                    percent: session.lsTranscodeProgress,
                    padding: EdgeInsets.symmetric(horizontal: 2.0),
                    progressColor: LSColors.splash.withOpacity(0.30),
                    backgroundColor: Colors.transparent,
                    lineHeight: 4.0,
                ),
                LinearPercentIndicator(
                    percent: session.lsProgressPercent,
                    padding: EdgeInsets.symmetric(horizontal: 2.0),
                    progressColor: LSColors.accent,
                    backgroundColor: LSColors.accent.withOpacity(0.15),
                    lineHeight: 4.0,
                ),
            ],
        ),
        padding: EdgeInsets.only(top: _padding),
    );

    Future<void> _enterDetails(BuildContext context) async => TautulliActivityDetailsRouter.navigateTo(context, sessionId: session.sessionId);
}
