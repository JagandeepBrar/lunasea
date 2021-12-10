import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrMissingTile extends StatefulWidget {
  static final itemExtent = LunaFourLineCardWithPoster.itemExtent;

  final RadarrMovie movie;
  final RadarrQualityProfile profile;

  const RadarrMissingTile({
    Key key,
    @required this.movie,
    @required this.profile,
  }) : super(key: key);

  @override
  State<RadarrMissingTile> createState() => _State();
}

class _State extends State<RadarrMissingTile> {
  @override
  Widget build(BuildContext context) {
    return Selector<RadarrState, Future<List<RadarrMovie>>>(
      selector: (_, state) => state.missing,
      builder: (context, missing, _) => LunaBlock(
        backgroundUrl:
            context.read<RadarrState>().getPosterURL(widget.movie.id),
        posterUrl: context.read<RadarrState>().getPosterURL(widget.movie.id),
        posterHeaders: context.read<RadarrState>().headers,
        posterPlaceholder: LunaAssets.blankVideo,
        disabled: !widget.movie.monitored,
        title: widget.movie.title,
        body: [
          _subtitle1(),
          _subtitle2(),
          _subtitle3(),
        ],
        trailing: _trailing(),
        onTap: _onTap,
      ),
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
    return TextSpan(
      children: [
        TextSpan(text: widget.profile.lunaName),
        TextSpan(text: LunaUI.TEXT_BULLET.lunaPad()),
        TextSpan(text: widget.movie.lunaMinimumAvailability),
        TextSpan(text: LunaUI.TEXT_BULLET.lunaPad()),
        TextSpan(text: widget.movie.lunaReleaseDate),
      ],
    );
  }

  TextSpan _subtitle3() {
    String _days = widget.movie.lunaEarlierReleaseDate.lunaDaysDifference;
    return TextSpan(
        style: const TextStyle(
          fontWeight: LunaUI.FONT_WEIGHT_BOLD,
          color: LunaColours.red,
        ),
        text: _days == null
            ? 'radarr.Released'.tr()
            : _days == 'Today'
                ? 'radarr.ReleasedToday'.tr()
                : 'Released $_days Ago');
  }

  LunaIconButton _trailing() {
    return LunaIconButton(
      icon: Icons.search_rounded,
      onPressed: () async => RadarrAPIHelper().automaticSearch(
          context: context,
          movieId: widget.movie.id,
          title: widget.movie.title),
      onLongPress: () async =>
          RadarrReleasesRouter().navigateTo(context, movieId: widget.movie.id),
    );
  }

  Future<void> _onTap() async =>
      RadarrMoviesDetailsRouter().navigateTo(context, movieId: widget.movie.id);
}
