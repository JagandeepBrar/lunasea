import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrAddMovieSearchResultTile extends StatefulWidget {
  final RadarrMovie movie;
  final bool onTapShowOverview;
  final bool exists;
  final bool isExcluded;

  const RadarrAddMovieSearchResultTile({
    Key key,
    @required this.movie,
    @required this.exists,
    @required this.isExcluded,
    this.onTapShowOverview = false,
  }) : super(key: key);

  @override
  State<RadarrAddMovieSearchResultTile> createState() => _State();
}

class _State extends State<RadarrAddMovieSearchResultTile> {
  @override
  Widget build(BuildContext context) {
    return LunaThreeLineCardWithPoster(
      backgroundUrl: widget.movie.remotePoster,
      posterUrl: widget.movie.remotePoster,
      posterHeaders: context.watch<RadarrState>().headers,
      posterPlaceholder: LunaAssets.blankVideo,
      title: widget.movie.title,
      darken: widget.exists,
      titleColor: widget.isExcluded ? LunaColours.red : Colors.white,
      subtitle1: _subtitle1(),
      subtitle2: _subtitle2(),
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
      summary = '${"radarr.NoSummaryIsAvailable".tr()}\n';
    } else {
      summary = '${widget.movie.overview}\n';
    }
    return TextSpan(
      style: const TextStyle(fontStyle: FontStyle.italic),
      text: summary,
    );
  }

  Future<void> _onTap() async {
    if (widget.onTapShowOverview) {
      LunaDialogs().textPreview(context, widget.movie.title,
          widget.movie.overview ?? 'radarr.NoSummaryIsAvailable'.tr());
    } else if (widget.exists) {
      RadarrMoviesDetailsRouter()
          .navigateTo(context, movieId: widget.movie.id ?? -1);
    } else {
      RadarrAddMovieDetailsRouter()
          .navigateTo(context, movie: widget.movie, isDiscovery: false);
    }
  }

  Future<void> _onLongPress() async =>
      widget.movie?.tmdbId?.toString()?.lunaOpenTheMovieDBMovie();
}
