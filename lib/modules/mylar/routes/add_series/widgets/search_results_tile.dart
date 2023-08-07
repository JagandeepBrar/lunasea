import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/extensions/string/string.dart';
import 'package:lunasea/extensions/string/links.dart';
import 'package:lunasea/modules/Mylar.dart';
import 'package:lunasea/router/routes/Mylar.dart';

class MylarSeriesAddSearchResultTile extends StatefulWidget {
  static final double extent = LunaBlock.calculateItemExtent(
    1,
    hasBottom: true,
    bottomHeight: LunaBlock.SUBTITLE_HEIGHT * 2,
  );

  final MylarSeries series;
  final bool onTapShowOverview;
  final bool exists;
  final bool isExcluded;

  const MylarSeriesAddSearchResultTile({
    Key? key,
    required this.series,
    required this.exists,
    required this.isExcluded,
    this.onTapShowOverview = false,
  }) : super(key: key);

  @override
  State<MylarSeriesAddSearchResultTile> createState() => _State();
}

class _State extends State<MylarSeriesAddSearchResultTile> {
  @override
  Widget build(BuildContext context) {
    return LunaBlock(
      backgroundUrl: widget.series.remotePoster,
      posterUrl: widget.series.remotePoster,
      posterHeaders: context.watch<MylarState>().headers,
      posterPlaceholderIcon: LunaIcons.VIDEO_CAM,
      title: widget.series.title,
      titleColor: widget.isExcluded ? LunaColours.red : Colors.white,
      disabled: widget.exists,
      body: [_subtitle1()],
      bottom: _subtitle2(),
      bottomHeight: LunaBlock.SUBTITLE_HEIGHT * 2,
      onTap: _onTap,
      onLongPress: _onLongPress,
    );
  }

  TextSpan _subtitle1() {
    return TextSpan(children: [
      TextSpan(text: widget.series.lunaSeasonCount),
      TextSpan(text: LunaUI.TEXT_BULLET.pad()),
      TextSpan(text: widget.series.lunaYear),
      TextSpan(text: LunaUI.TEXT_BULLET.pad()),
      TextSpan(text: widget.series.lunaNetwork),
    ]);
  }

  Widget _subtitle2() {
    return SizedBox(
      height: LunaBlock.SUBTITLE_HEIGHT * 2,
      child: RichText(
        text: TextSpan(
          style: const TextStyle(
            fontStyle: FontStyle.italic,
            fontSize: LunaUI.FONT_SIZE_H3,
            color: LunaColours.grey,
          ),
          children: [
            LunaTextSpan.extended(text: widget.series.lunaOverview),
          ],
        ),
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
      ),
    );
  }

  Future<void> _onTap() async {
    if (widget.onTapShowOverview) {
      LunaDialogs().textPreview(
        context,
        widget.series.title,
        widget.series.overview ?? 'Mylar.NoSummaryAvailable'.tr(),
      );
    } else if (widget.exists) {
      MylarRoutes.SERIES.go(params: {'series': widget.series.id!.toString()});
    } else {
      MylarRoutes.ADD_SERIES_DETAILS.go(extra: widget.series);
    }
  }

  Future<void>? _onLongPress() async =>
      widget.series.tvdbId?.toString().openTvdbSeries();
}
