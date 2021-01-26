import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrMovieDetailsCastCrewTile extends StatelessWidget {
    final RadarrMovieCredits credits;
    final _dimensions = 67.0;
    final _padding = 8.0;

    RadarrMovieDetailsCastCrewTile({
        Key key,
        @required this.credits,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) => LSCard(
        child: InkWell(
            child: Row(
                children: [
                    _poster,
                    Expanded(child: _information),
                ],
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
            ),
            onTap: () async => credits.personTmdbId?.toString()?.lunaOpenTheMovieDBCredits(),
            borderRadius: BorderRadius.circular(Constants.UI_BORDER_RADIUS),
        ),
    );

    Widget get _poster => LSNetworkImage(
        url: credits.images.length == 0 ? null : credits.images[0].url,
        placeholder: 'assets/images/lidarr/noartistposter.png',
        height: _dimensions,
        width: _dimensions,
    );

    Widget get _information => Padding(
        child: Container(
            child: Column(
                children: [
                    LSTitle(text: credits.personName, maxLines: 1),
                    RichText(
                        text: TextSpan(
                            style: TextStyle(
                                fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                                color: Colors.white70,
                            ),
                            children: [
                                TextSpan(text: credits.character ?? credits.job ?? Constants.TEXT_EMDASH),
                                TextSpan(text: '\n'),
                                TextSpan(
                                    text: credits.type.readable,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: LunaColours.accent,
                                    ),
                                ),
                            ],
                        ),
                        overflow: TextOverflow.fade,
                        softWrap: false,
                        maxLines: 2,
                    ),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
            ),
            height: (_dimensions-(_padding*2)),
        ),
        padding: EdgeInsets.all(_padding),
    );
}
