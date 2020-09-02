import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:tautulli/tautulli.dart';

class TautulliUserTile extends StatelessWidget {
    final TautulliTableUser user;
    final double _imageDimension = 70.0;
    final double _padding = 8.0;

    TautulliUserTile({
        Key key,
        @required this.user,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) => LSCard(
        child: InkWell(
            borderRadius: BorderRadius.circular(Constants.UI_BORDER_RADIUS),
            child: Row(
                children: [
                    _userThumb(context),
                    _details,
                ],
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
            ),
            onTap: () async => _enterDetails(context),
        ),
        decoration: user.thumb != null && user.thumb.isNotEmpty
            ? LSCardBackground(
                darken: true,
                uri: Provider.of<TautulliState>(context, listen: false).getImageURLFromPath(user.thumb),
                headers: Provider.of<TautulliState>(context, listen: false).headers.cast<String, String>(),
            )
            : null,
    );

    Widget _userThumb(BuildContext context) => CachedNetworkImage(
        fadeInDuration: Duration(milliseconds: Constants.UI_NAVIGATION_SPEED),
        fadeOutDuration: Duration(milliseconds: Constants.UI_NAVIGATION_SPEED),
        imageUrl: Provider.of<TautulliState>(context, listen: false).getImageURLFromPath(user.userThumb),
        httpHeaders: Provider.of<TautulliState>(context, listen: false).headers.cast<String, String>(),
        imageBuilder: (context, imageProvider) => Container(
            height: _imageDimension,
            width: _imageDimension,
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
        width: _imageDimension,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Constants.UI_BORDER_RADIUS),
            image: DecorationImage(
                image: AssetImage('assets/images/tautulli/nouserthumb.png'),
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
                        _lastPlayedTime,
                        _lastPlayedContent,
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

    Widget get _title => LSTitle(text: user.friendlyName);

    Widget get _lastPlayedTime => Row(
        children: [
            Padding(
                child: LSIcon(
                    icon: Icons.visibility,
                    size: Constants.UI_FONT_SIZE_SUBTITLE,
                ),
                padding: EdgeInsets.only(right: 6.0),
            ),
            Expanded(
                child: LSSubtitle(
                    text: user.lastSeen != null ? DateTime.now().lsDateTime_ageString(user.lastSeen) : 'Never',
                    maxLines: 1,
                ),
            ),
        ],
    );

    Widget get _lastPlayedContent => Row(
        children: [
            Padding(
                child: LSIcon(
                    icon: Icons.play_arrow,
                    size: Constants.UI_FONT_SIZE_SUBTITLE,
                ),
                padding: EdgeInsets.only(right: 6.0),
            ),
            Expanded(
                child: LSSubtitle(
                    text: user.lastPlayed ?? 'Never',
                    maxLines: 1,
                ),
            ),
        ],
    );

    Future<void> _enterDetails(BuildContext context) async => Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => ChangeNotifierProvider.value(
            value: Provider.of<TautulliLocalState>(context, listen: false),
            child: TautulliUserDetailsRoute(user: user),
        )),
    );
}
