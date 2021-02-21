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
                if(movie.imdbId != null && movie.imdbId.isNotEmpty) LunaCard(
                    context: context,
                    child: InkWell(
                        child: Padding(
                            child: Image.asset(
                                'assets/images/services/imdb.png',
                                height: 21.0,
                            ),
                            padding: EdgeInsets.all(18.0),
                        ),
                        borderRadius: BorderRadius.circular(Constants.UI_BORDER_RADIUS),
                        onTap: () async => await movie?.imdbId?.lunaOpenIMDB(),
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
                ),
                if(movie.tmdbId != null && movie.tmdbId != 0) LunaCard(
                    context: context,
                    child: InkWell(
                        child: Padding(
                            child: Image.asset(
                                'assets/images/services/themoviedb.png',
                                height: 22.0,
                            ),
                            padding: EdgeInsets.all(17.0),
                        ),
                        borderRadius: BorderRadius.circular(Constants.UI_BORDER_RADIUS),
                        onTap: () async => await movie?.tmdbId?.toString()?.lunaOpenTheMovieDBMovie(),
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
                ),
                if(movie.youTubeTrailerId != null && movie.youTubeTrailerId.isNotEmpty) LunaCard(
                    context: context,
                    child: InkWell(
                        child: Padding(
                            child: Image.asset(
                                'assets/images/services/youtube.png',
                                height: 17.0,
                            ),
                            padding: EdgeInsets.all(20.0),
                        ),
                        borderRadius: BorderRadius.circular(Constants.UI_BORDER_RADIUS),
                        onTap: () async => await movie?.youTubeTrailerId?.lunaOpenYouTube(),
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
                ),
            ],
        );
    }
}