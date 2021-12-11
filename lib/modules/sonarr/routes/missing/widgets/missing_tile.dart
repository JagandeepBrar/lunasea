import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrMissingTile extends StatefulWidget {
  static final itemExtent = LunaFourLineCardWithPoster.itemExtent;

  final SonarrMissingRecord record;
  final SonarrSeries series;

  const SonarrMissingTile({
    Key key,
    @required this.record,
    this.series,
  }) : super(key: key);

  @override
  State<SonarrMissingTile> createState() => _State();
}

class _State extends State<SonarrMissingTile> {
  @override
  Widget build(BuildContext context) {
    return LunaFourLineCardWithPoster(
      backgroundUrl:
          context.read<SonarrState>().getBannerURL(widget.record.seriesId),
      posterUrl:
          context.read<SonarrState>().getPosterURL(widget.record.seriesId),
      posterHeaders: context.read<SonarrState>().headers,
      posterPlaceholder: LunaAssets.blankVideo,
      title: widget.record?.series?.title ??
          widget.series?.title ??
          LunaUI.TEXT_EMDASH,
      subtitle1: _subtitle1(),
      subtitle2: _subtitle2(),
      subtitle3: _subtitle3(),
      darken: !widget.record.monitored,
      onTap: _onTap,
      onLongPress: _onLongPress,
      trailing: _trailing(),
    );
  }

  Widget _trailing() {
    return LunaIconButton(
      icon: Icons.search_rounded,
      onPressed: _trailingOnTap,
      onLongPress: _trailingOnLongPress,
    );
  }

  TextSpan _subtitle1() {
    return TextSpan(
      style: TextStyle(
        fontSize: LunaUI.FONT_SIZE_H3,
        color: widget.record.monitored ? Colors.white70 : Colors.white30,
      ),
      children: [
        TextSpan(
            text: widget.record.seasonNumber == 0
                ? 'Specials'
                : 'Season ${widget.record.seasonNumber}'),
        TextSpan(text: LunaUI.TEXT_BULLET.lunaPad()),
        TextSpan(text: 'Episode ${widget.record.episodeNumber}'),
      ],
    );
  }

  TextSpan _subtitle2() {
    return TextSpan(
      style: TextStyle(
        fontSize: LunaUI.FONT_SIZE_H3,
        color: widget.record.monitored ? Colors.white70 : Colors.white30,
      ),
      children: [
        TextSpan(
          style: const TextStyle(
            fontStyle: FontStyle.italic,
          ),
          text: widget.record.title ?? 'lunasea.Unknown'.tr(),
        ),
      ],
    );
  }

  TextSpan _subtitle3() {
    return TextSpan(
      style: const TextStyle(
        fontSize: LunaUI.FONT_SIZE_H3,
        color: LunaColours.red,
        fontWeight: LunaUI.FONT_WEIGHT_BOLD,
      ),
      children: [
        TextSpan(
            text: widget.record.airDateUtc == null
                ? 'Aired'
                : 'Aired ${widget.record.airDateUtc?.toLocal()?.lunaAge}'),
      ],
    );
  }

  Future<void> _onTap() async => SonarrSeasonDetailsRouter().navigateTo(
        context,
        seriesId: widget.record.seriesId,
        seasonNumber: widget.record.seasonNumber,
      );

  Future<void> _onLongPress() async => SonarrSeriesDetailsRouter().navigateTo(
        context,
        seriesId: widget.record.seriesId,
      );

  Future<void> _trailingOnTap() async {
    Provider.of<SonarrState>(context, listen: false)
        .api
        .command
        .episodeSearch(episodeIds: [widget.record.id])
        .then((_) => showLunaSuccessSnackBar(
              title: 'Searching for Episode...',
              message: widget.record.title,
            ))
        .catchError((error, stack) {
          LunaLogger().error(
              'Failed to search for episode: ${widget.record.id}',
              error,
              stack);
          showLunaErrorSnackBar(
            title: 'Failed to Search',
            error: error,
          );
        });
  }

  Future<void> _trailingOnLongPress() async =>
      SonarrReleasesRouter().navigateTo(
        context,
        episodeId: widget.record.id,
      );
}
