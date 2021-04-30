import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrMovieDetailsOverviewLinksSection extends StatelessWidget {
  final RadarrMovie movie;

  RadarrMovieDetailsOverviewLinksSection({
    Key key,
    @required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaButtonContainer(
      children: [
        if (movie.imdbId != null && movie.imdbId.isNotEmpty)
          LunaCard(
            context: context,
            child: InkWell(
              child: Padding(
                child: Image.asset(LunaAssets.imdb),
                padding: EdgeInsets.all(12.0),
              ),
              borderRadius: BorderRadius.circular(LunaUI.BORDER_RADIUS),
              onTap: () async => await movie?.imdbId?.lunaOpenIMDB(),
            ),
            height: 50.0,
            margin: EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
          ),
        if (movie.tmdbId != null && movie.tmdbId != 0)
          LunaCard(
            context: context,
            child: InkWell(
              child: Padding(
                child: Image.asset(LunaAssets.themoviedb),
                padding: EdgeInsets.all(12.0),
              ),
              borderRadius: BorderRadius.circular(LunaUI.BORDER_RADIUS),
              onTap: () async =>
                  await movie?.tmdbId?.toString()?.lunaOpenTheMovieDBMovie(),
            ),
            height: 50.0,
            margin: EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
          ),
        if (movie.tmdbId != null && movie.tmdbId != 0)
          LunaCard(
            context: context,
            child: InkWell(
              child: Padding(
                child: Image.asset(LunaAssets.trakt),
                padding: EdgeInsets.all(12.0),
              ),
              borderRadius: BorderRadius.circular(LunaUI.BORDER_RADIUS),
              onTap: () async =>
                  await movie?.tmdbId?.toString()?.lunaOpenTraktMovie(),
            ),
            height: 50.0,
            margin: EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
          ),
        if (movie.youTubeTrailerId != null && movie.youTubeTrailerId.isNotEmpty)
          LunaCard(
            context: context,
            child: InkWell(
              child: Padding(
                child: Image.asset(LunaAssets.youtube),
                padding: EdgeInsets.all(12.0),
              ),
              borderRadius: BorderRadius.circular(LunaUI.BORDER_RADIUS),
              onTap: () async =>
                  await movie?.youTubeTrailerId?.lunaOpenYouTube(),
            ),
            height: 50.0,
            margin: EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
          ),
      ],
    );
  }
}
