import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrAddMovieDiscoveryResultTile extends StatefulWidget {
  final RadarrMovie movie;
  final bool onTapShowOverview;

  RadarrAddMovieDiscoveryResultTile({
    Key key,
    @required this.movie,
    this.onTapShowOverview = false,
  }) : super(key: key);

  @override
  State<RadarrAddMovieDiscoveryResultTile> createState() => _State();
}

class _State extends State<RadarrAddMovieDiscoveryResultTile> {
  @override
  Widget build(BuildContext context) {
    return LunaFourLineCardWithPoster(
      backgroundUrl: widget.movie.remotePoster,
      posterUrl: widget.movie.remotePoster,
      posterHeaders: context.watch<RadarrState>().headers,
      posterPlaceholder: 'assets/images/blanks/video.png',
      title: widget.movie.title,
      subtitle1: _subtitle1(),
      subtitle2: _subtitle2(),
      subtitle2MaxLines: 2,
      onTap: _onTap,
      onLongPress: _onLongPress,
    );
  }

  TextSpan _subtitle1() {
    return TextSpan(
      children: [
        TextSpan(text: widget.movie.lunaYear),
        TextSpan(text: LunaUI.TEXT_BULLET.lunaPad()),
        TextSpan(text: widget.movie.lunaRuntime),
        TextSpan(text: LunaUI.TEXT_BULLET.lunaPad()),
        TextSpan(text: widget.movie.lunaStudio),
      ],
    );
  }

  TextSpan _subtitle2() {
    String summary;
    if (widget.movie.overview == null || widget.movie.overview.isEmpty) {
      summary = 'radarr.NoSummaryIsAvailable'.tr();
    } else {
      summary = '${widget.movie.overview}\n';
    }
    return TextSpan(
      style: TextStyle(fontStyle: FontStyle.italic),
      text: summary,
    );
  }

  Future<void> _onTap() async {
    if (widget.onTapShowOverview) {
      LunaDialogs().textPreview(context, widget.movie.title,
          widget.movie.overview ?? 'radarr.NoSummaryIsAvailable'.tr());
    } else {
      RadarrAddMovieDetailsRouter()
          .navigateTo(context, movie: widget.movie, isDiscovery: true);
    }
  }

  Future<void> _onLongPress() async =>
      widget.movie?.tmdbId?.toString()?.lunaOpenTheMovieDBMovie();
}
