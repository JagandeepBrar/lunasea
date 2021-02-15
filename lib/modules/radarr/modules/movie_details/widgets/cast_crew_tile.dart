import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrMovieDetailsCastCrewTile extends StatelessWidget {
    final RadarrMovieCredits credits;

    RadarrMovieDetailsCastCrewTile({
        Key key,
        @required this.credits,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return LunaTwoLineCardWithPoster(
            title: credits.personName,
            posterPlaceholder: 'assets/images/lidarr/noartistposter.png',
            posterUrl: credits.images.length == 0 ? null : credits.images[0].url,
            posterHeaders: {},
            subtitle1: TextSpan(text: credits.character ?? credits.job ?? LunaUI.TEXT_EMDASH),
            subtitle2: TextSpan(
                text: credits.type.readable,
                style: TextStyle(
                    fontWeight: LunaUI.FONT_WEIGHT_BOLD,
                    color: credits.type == RadarrCreditType.CAST ? LunaColours.accent : LunaColours.orange,
                ),
            ),
            onTap: credits.personTmdbId?.toString()?.lunaOpenTheMovieDBCredits,
        );
    }
}
