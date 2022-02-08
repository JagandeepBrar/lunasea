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
  State<StatefulWidget> createState() => _State();
}

class _State extends State<OverseerrRequestTile> with LunaLoadCallbackMixin {
  OverseerrMovie? _movie;
  OverseerrSeries? _series;

  @override
  Future<void> loadCallback() async {
    // Temporary, for testing purposes
    if (widget.request.type == OverseerrMediaType.MOVIE) {
      OverseerrMovie movie = await context
          .read<OverseerrState>()
          .api!
          .getMovie(id: widget.request.media!.tmdbId!);
      if (mounted) setState(() => _movie = movie);
    }

    if (widget.request.type == OverseerrMediaType.TV) {
      OverseerrSeries series = await context
          .read<OverseerrState>()
          .api!
          .getSeries(id: widget.request.media!.tmdbId!);
      if (mounted) setState(() => _series = series);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Temporary, for testing purposes
    if (_movie != null) {
      return LunaBlock(
        title: _movie!.title ?? 'lunasea.Unknown'.tr(),
        body: [
          const TextSpan(text: 'Placeholder 1'),
          TextSpan(
              text: 'Requested by ${widget.request.requestedBy?.displayName}',
              style: const TextStyle(
                fontWeight: LunaUI.FONT_WEIGHT_BOLD,
                color: LunaColours.accent,
              )),
        ],
        posterHeaders: context.read<OverseerrState>().headers,
        posterUrl: TheMovieDB.getImageURL(_movie!.posterPath),
        posterPlaceholderIcon: LunaIcons.VIDEO_CAM,
      );
    } else if (_series != null) {
      return LunaBlock(
        title: _series!.name ?? 'lunasea.Unknown'.tr(),
        body: [
          const TextSpan(text: 'Placeholder 1'),
          TextSpan(
              text: 'Requested by ${widget.request.requestedBy?.displayName}',
              style: const TextStyle(
                fontWeight: LunaUI.FONT_WEIGHT_BOLD,
                color: LunaColours.accent,
              )),
        ],
        posterHeaders: context.read<OverseerrState>().headers,
        posterUrl: TheMovieDB.getImageURL(_series!.posterPath),
        posterPlaceholderIcon: LunaIcons.VIDEO_CAM,
      );
    } else {
      return LunaBlock(
        title: widget.request.requestedBy!.displayName ??
            'overseerr.UnknownUser'.tr(),
        body: const [
          TextSpan(text: 'Placeholder 1'),
          TextSpan(text: 'Placeholder 2'),
        ],
        posterPlaceholderIcon: LunaIcons.USER,
        posterHeaders: context.read<OverseerrState>().headers,
        posterUrl: widget.request.requestedBy!.avatar,
      );
    }
  }
}
