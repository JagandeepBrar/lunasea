import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/overseerr.dart';

class OverseerrRequestTile extends StatelessWidget {
  final OverseerrRequest request;

  const OverseerrRequestTile({
    Key? key,
    required this.request,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<OverseerrState,
        Tuple2<Future<OverseerrMovie?>, Future<OverseerrSeries?>>>(
      selector: (_, state) => Tuple2(
        state.getMovie(request.media!.tmdbId!),
        state.getSeries(request.media!.tmdbId!),
      ),
      builder: (context, data, _) => FutureBuilder(
        future: Future.wait([data.item1, data.item2]),
        builder: (context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            switch (request.type!) {
              case OverseerrMediaType.MOVIE:
                return _movieBlock(context, snapshot.data![0]);
              case OverseerrMediaType.TV:
                return _seriesBlock(context, snapshot.data![1]);
            }
          }
          return const LunaBlock(skeletonEnabled: true, skeletonSubtitles: 3);
        },
      ),
    );
  }

  Widget _movieBlock(BuildContext context, OverseerrMovie movie) {
    return LunaBlock(
      title: movie.lunaTitle(),
      body: [
        TextSpan(text: movie.lunaYear()),
        TextSpan(text: request.lunaRequestedBy()),
        TextSpan(
          text: request.lunaRequestStatus(),
          style: TextStyle(
            fontWeight: LunaUI.FONT_WEIGHT_BOLD,
            color: request.status.lunaColour(request.lunaMediaStatus()),
          ),
        ),
      ],
      posterHeaders: context.read<OverseerrState>().headers,
      posterUrl: TheMovieDB.getPosterURL(movie.posterPath),
      posterPlaceholderIcon: LunaIcons.VIDEO_CAM,
      backgroundHeaders: context.read<OverseerrState>().headers,
      backgroundUrl: TheMovieDB.getBackdropURL(movie.backdropPath),
    );
  }

  Widget _seriesBlock(BuildContext context, OverseerrSeries series) {
    return LunaBlock(
      title: series.lunaTitle(),
      body: [
        TextSpan(text: series.lunaYear()),
        TextSpan(text: request.lunaRequestedBy()),
        TextSpan(
          text: request.lunaRequestStatus(),
          style: TextStyle(
            fontWeight: LunaUI.FONT_WEIGHT_BOLD,
            color: request.status.lunaColour(request.lunaMediaStatus()),
          ),
        ),
      ],
      posterHeaders: context.read<OverseerrState>().headers,
      posterUrl: TheMovieDB.getPosterURL(series.posterPath),
      posterPlaceholderIcon: LunaIcons.VIDEO_CAM,
      backgroundHeaders: context.read<OverseerrState>().headers,
      backgroundUrl: TheMovieDB.getBackdropURL(series.backdropPath),
    );
  }
}
