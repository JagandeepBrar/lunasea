import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:tautulli/tautulli.dart';

class TautulliLibrariesDetailsUserStatsTile extends StatelessWidget {
    final TautulliLibraryUserStats user;
    final double _imageDimension = 70.0;
    final double _padding = 8.0;

    TautulliLibrariesDetailsUserStatsTile({
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
            ),
            onTap: () async => _onPressed(context),
        ),
    );

    Widget _userThumb(BuildContext context) => LSNetworkImage(
        url: Provider.of<TautulliState>(context, listen: false).getImageURLFromPath(user.userThumb),
        headers: Provider.of<TautulliState>(context, listen: false).headers.cast<String, String>(),
        placeholder: 'assets/images/tautulli/nouserthumb.png',
        height: _imageDimension,
        width: _imageDimension,
    );

    Widget get _details => Expanded(
        child: Padding(
            child: Container(
                child: Column(
                    children: [
                        _title,
                        _userId,
                        _totalPlays,
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

    Widget get _totalPlays => Row(
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
                    text: user.totalPlays == 1 ? '1 Play' : '${user.totalPlays} Plays',
                    maxLines: 1,
                ),
            ),
        ],
    );

    Widget get _userId => Row(
        children: [
            Padding(
                child: LSIcon(
                    icon: Icons.person,
                    size: Constants.UI_FONT_SIZE_SUBTITLE,
                ),
                padding: EdgeInsets.only(right: 6.0),
            ),
            Expanded(
                child: LSSubtitle(
                    text: user.userId.toString(),
                    maxLines: 1,
                ),
            ),
        ],
    );

    Future<void> _onPressed(BuildContext context) => TautulliUserDetailsRouter.navigateTo(
        context,
        userId: user.userId,
    );
}
