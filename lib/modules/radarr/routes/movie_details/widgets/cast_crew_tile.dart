import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrMovieDetailsCastCrewTile extends StatelessWidget {
  final RadarrMovieCredits credits;

  const RadarrMovieDetailsCastCrewTile({
    Key key,
    @required this.credits,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String position;
    switch (credits.type) {
      case RadarrCreditType.CREW:
        position = credits.job.isEmpty ? LunaUI.TEXT_EMDASH : credits.job;
        break;
      case RadarrCreditType.CAST:
        position =
            credits.character.isEmpty ? LunaUI.TEXT_EMDASH : credits.character;
        break;
      default:
        position = LunaUI.TEXT_EMDASH;
        break;
    }
    return LunaBlock(
      title: credits.personName,
      posterPlaceholder: LunaAssets.blankUser,
      posterUrl: credits.images.isEmpty ? null : credits.images[0].url,
      body: [
        TextSpan(text: position),
        TextSpan(
          text: credits.type.readable,
          style: TextStyle(
            fontWeight: LunaUI.FONT_WEIGHT_BOLD,
            color: credits.type == RadarrCreditType.CAST
                ? LunaColours.accent
                : LunaColours.orange,
          ),
        ),
      ],
      onTap: credits.personTmdbId?.toString()?.lunaOpenTheMovieDBCredits,
    );
  }
}
