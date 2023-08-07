import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/extensions/string/string.dart';
import 'package:lunasea/modules/mylar.dart';
import 'package:lunasea/router/routes/mylar.dart';

class MylarUpcomingTile extends StatefulWidget {
  final MylarCalendar record;
  final MylarSeries? series;

  const MylarUpcomingTile({
    Key? key,
    required this.record,
    this.series,
  }) : super(key: key);

  @override
  State<MylarUpcomingTile> createState() => _State();
}

class _State extends State<MylarUpcomingTile> {
  @override
  Widget build(BuildContext context) {
    return LunaBlock(
      backgroundUrl:
          context.read<MylarState>().getFanartURL(widget.record.seriesId),
      posterUrl:
          context.read<MylarState>().getPosterURL(widget.record.seriesId),
      posterHeaders: context.read<MylarState>().headers,
      posterPlaceholderIcon: LunaIcons.VIDEO_CAM,
      title: widget.record.series?.title ??
          widget.series?.title ??
          LunaUI.TEXT_EMDASH,
      body: [
        _subtitle1(),
        _subtitle2(),
        _subtitle3(),
      ],
      disabled: !widget.record.monitored!,
      onTap: _onTap,
      onLongPress: _onLongPress,
      trailing: _trailing(),
    );
  }

  Widget _trailing() => LunaIconButton(
        text: widget.record.lunaAirTime,
        onPressed: _trailingOnPressed,
        onLongPress: _trailingOnLongPress,
      );

  TextSpan _subtitle1() {
    return TextSpan(
      children: [
        TextSpan(
            text: widget.record.seasonNumber == 0
                ? 'Specials'
                : 'Season ${widget.record.seasonNumber}'),
        TextSpan(text: LunaUI.TEXT_BULLET.pad()),
        TextSpan(text: 'Episode ${widget.record.episodeNumber}'),
      ],
    );
  }

  TextSpan _subtitle2() {
    return TextSpan(
      style: const TextStyle(fontStyle: FontStyle.italic),
      children: [
        TextSpan(text: widget.record.title ?? 'Unknown Title'),
      ],
    );
  }

  TextSpan _subtitle3() {
    Color color = widget.record.hasFile!
        ? LunaColours.accent
        : widget.record.lunaHasAired
            ? LunaColours.red
            : LunaColours.blue;
    return TextSpan(
      style: TextStyle(
        fontWeight: LunaUI.FONT_WEIGHT_BOLD,
        color: color,
      ),
      children: [
        if (!widget.record.hasFile!)
          TextSpan(text: widget.record.lunaHasAired ? 'Missing' : 'Unaired'),
        if (widget.record.hasFile!)
          TextSpan(
            text:
                'Downloaded (${widget.record.episodeFile?.quality?.quality?.name ?? 'Unknown'})',
          ),
      ],
    );
  }

  Future<void> _onTap() async {
    MylarRoutes.SERIES_SEASON.go(params: {
      'series': (widget.record.seriesId ?? -1).toString(),
      'season': (widget.record.seasonNumber ?? -1).toString(),
    });
  }

  Future<void> _onLongPress() async {
    MylarRoutes.SERIES.go(params: {
      'series': widget.record.seriesId!.toString(),
    });
  }

  Future<void> _trailingOnPressed() async {
    Provider.of<MylarState>(context, listen: false)
        .api!
        .command
        .episodeSearch(episodeIds: [widget.record.id!])
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

  Future<void> _trailingOnLongPress() async {
    MylarRoutes.RELEASES.go(queryParams: {
      'episode': widget.record.id.toString(),
    });
  }
}
