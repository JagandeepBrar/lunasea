import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrMissingTile extends StatefulWidget {
  final SonarrMissingRecord record;

  SonarrMissingTile({
    Key key,
    @required this.record,
  }) : super(key: key);

  @override
  State<SonarrMissingTile> createState() => _State();
}

class _State extends State<SonarrMissingTile> {
  final double _height = 90.0;
  final double _width = 60.0;
  final double _padding = 8.0;

  @override
  Widget build(BuildContext context) =>
      Selector<SonarrState, Future<SonarrMissing>>(
        selector: (_, state) => state.missing,
        builder: (context, series, _) => LunaCard(
          context: context,
          child: InkWell(
            child: Row(
              children: [
                _poster,
                Expanded(child: _information),
                _trailing,
              ],
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
            borderRadius: BorderRadius.circular(LunaUI.BORDER_RADIUS),
            onTap: _tileOnTap,
            onLongPress: _tileOnLongPress,
          ),
          decoration: LunaCardDecoration(
            uri: Provider.of<SonarrState>(context, listen: false)
                .getBannerURL(widget.record.seriesId),
            headers: Provider.of<SonarrState>(context, listen: false).headers,
          ),
        ),
      );

  Widget get _poster => LunaNetworkImage(
        url: Provider.of<SonarrState>(context, listen: false)
            .getPosterURL(widget.record.seriesId),
        placeholderAsset: LunaAssets.blankVideo,
        height: _height,
        width: _width,
        headers: Provider.of<SonarrState>(context, listen: false)
            .headers
            .cast<String, String>(),
      );

  Widget get _information => Padding(
        child: Container(
          child: Column(
            children: [
              LunaText.title(
                  text: widget.record.series?.title ?? LunaUI.TEXT_EMDASH,
                  darken: !widget.record.monitored,
                  maxLines: 1),
              _subtitleOne,
              _subtitleTwo,
              _subtitleThree,
            ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
          ),
          height: (_height - (_padding * 2)),
        ),
        padding: EdgeInsets.all(_padding),
      );

  Widget get _trailing => Container(
        child: Padding(
          child: LunaIconButton(
            icon: Icons.search,
            onPressed: _trailingOnPressed,
            onLongPress: _trailingOnLongPress,
          ),
          padding: EdgeInsets.only(right: 12.0),
        ),
        height: _height,
      );

  Widget get _subtitleOne => RichText(
        text: TextSpan(
          style: TextStyle(
            fontSize: LunaUI.FONT_SIZE_SUBTITLE,
            color: widget.record.monitored ? Colors.white70 : Colors.white30,
          ),
          children: [
            TextSpan(
                text: widget.record.seasonNumber == 0
                    ? 'Specials '
                    : 'Season ${widget.record.seasonNumber} '),
            TextSpan(text: LunaUI.TEXT_EMDASH),
            TextSpan(text: ' Episode ${widget.record.episodeNumber}'),
          ],
        ),
        overflow: TextOverflow.fade,
        softWrap: false,
        maxLines: 1,
      );

  Widget get _subtitleTwo => RichText(
        text: TextSpan(
          style: TextStyle(
            fontSize: LunaUI.FONT_SIZE_SUBTITLE,
            color: widget.record.monitored ? Colors.white70 : Colors.white30,
          ),
          children: [
            TextSpan(
              style: TextStyle(
                fontStyle: FontStyle.italic,
              ),
              text: widget.record.title ?? 'Unknown Title',
            ),
          ],
        ),
        overflow: TextOverflow.fade,
        softWrap: false,
        maxLines: 1,
      );

  Widget get _subtitleThree => RichText(
        text: TextSpan(
          style: TextStyle(
            fontSize: LunaUI.FONT_SIZE_SUBTITLE,
            color: LunaColours.red,
            fontWeight: LunaUI.FONT_WEIGHT_BOLD,
          ),
          children: [
            TextSpan(
                text: widget.record.airDateUtc == null
                    ? 'Aired'
                    : 'Aired ${widget.record.airDateUtc?.toLocal()?.lunaAge}'),
          ],
        ),
        overflow: TextOverflow.fade,
        softWrap: false,
        maxLines: 1,
      );

  Future<void> _tileOnTap() async => SonarrSeasonDetailsRouter().navigateTo(
        context,
        seriesId: widget.record.seriesId,
        seasonNumber: widget.record.seasonNumber,
      );

  Future<void> _tileOnLongPress() async =>
      SonarrSeriesDetailsRouter().navigateTo(
        context,
        seriesId: widget.record.seriesId,
      );

  Future<void> _trailingOnPressed() async {
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
