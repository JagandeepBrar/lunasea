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
    Widget build(BuildContext context) => LSContainerRow(
        children: [
            if(movie.imdbId != null && movie.imdbId.isNotEmpty) Expanded(
                child: LSCard(
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
                    reducedMargin: true,
                ),
            ),
            if(movie.tmdbId != null && movie.tmdbId != 0) Expanded(
                child: LSCard(
                    child: InkWell(
                        child: Padding(
                            child: Image.asset(
                                'assets/images/services/themoviedb.png',
                                height: 19.0,
                            ),
                            padding: EdgeInsets.all(19.0),
                        ),
                        borderRadius: BorderRadius.circular(Constants.UI_BORDER_RADIUS),
                        onTap: () async => await movie?.tmdbId?.toString()?.lunaOpenTheMovieDB(),
                    ),
                    reducedMargin: true,
                ),
            ),
            if(movie.youTubeTrailerId != null && movie.youTubeTrailerId.isNotEmpty) Expanded(
                child: LSCard(
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
                    reducedMargin: true,
                ),
            ),
        ],
    );
}