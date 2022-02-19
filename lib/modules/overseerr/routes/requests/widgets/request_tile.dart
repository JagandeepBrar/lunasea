import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/overseerr.dart';

class OverseerrRequestTile extends StatefulWidget {
  final OverseerrRequest request;

  const OverseerrRequestTile({
    Key? key,
    required this.request,
  }) : super(key: key);

  @override
  State<OverseerrRequestTile> createState() => _State();
}

class _State extends State<OverseerrRequestTile> with LunaLoadCallbackMixin {
  bool _loaded = false;

  @override
  Future<void> loadCallback() async {
    int id = widget.request.media!.tmdbId!;
    switch (widget.request.type!) {
      case OverseerrMediaType.MOVIE:
        if (mounted) await context.read<OverseerrState>().fetchMovie(id);
        break;
      case OverseerrMediaType.TV:
        if (mounted) await context.read<OverseerrState>().fetchSeries(id);
        break;
    }
    if (mounted) setState(() => _loaded = true);
  }

  @override
  Widget build(BuildContext context) {
    if (!_loaded) return _loadingBlock();

    return Selector<OverseerrState,
        Tuple2<Future<OverseerrMovie?>, Future<OverseerrSeries?>>>(
      selector: (_, state) => Tuple2(
        state.getMovie(widget.request.media!.tmdbId!),
        state.getSeries(widget.request.media!.tmdbId!),
      ),
      builder: (context, data, _) => FutureBuilder(
        future: Future.wait([data.item1, data.item2]),
        builder: (context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            switch (widget.request.type!) {
              case OverseerrMediaType.MOVIE:
                if (snapshot.data?[0] != null)
                  return _movieBlock(context, snapshot.data![0]);
                break;
              case OverseerrMediaType.TV:
                if (snapshot.data?[1] != null)
                  return _seriesBlock(context, snapshot.data![1]);
                break;
            }
          }
          return _loadingBlock();
        },
      ),
    );
  }

  Widget _loadingBlock() {
    return const LunaBlock(skeletonEnabled: true, skeletonSubtitles: 3);
  }

  Widget _movieBlock(BuildContext context, OverseerrMovie movie) {
    return LunaBlock(
      title: movie.lunaTitle(),
      body: [
        TextSpan(text: movie.lunaYear()),
        TextSpan(text: widget.request.lunaRequestedBy()),
        TextSpan(
          text: widget.request.lunaRequestStatus(),
          style: TextStyle(
            fontWeight: LunaUI.FONT_WEIGHT_BOLD,
            color: widget.request.status
                .lunaColour(widget.request.lunaMediaStatus()),
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
        TextSpan(text: widget.request.lunaRequestedBy()),
        TextSpan(
          text: widget.request.lunaRequestStatus(),
          style: TextStyle(
            fontWeight: LunaUI.FONT_WEIGHT_BOLD,
            color: widget.request.status.lunaColour(
              widget.request.lunaMediaStatus(),
            ),
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
