import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/readarr.dart';

class ReadarrAuthorAddSearchResultTile extends StatefulWidget {
  static final double extent = LunaBlock.calculateItemExtent(
    1,
    hasBottom: true,
    bottomHeight: LunaBlock.SUBTITLE_HEIGHT * 2,
  );

  final ReadarrAuthor series;
  final bool onTapShowOverview;
  final bool exists;
  final bool isExcluded;

  const ReadarrAuthorAddSearchResultTile({
    Key? key,
    required this.series,
    required this.exists,
    required this.isExcluded,
    this.onTapShowOverview = false,
  }) : super(key: key);

  @override
  State<ReadarrAuthorAddSearchResultTile> createState() => _State();
}

class _State extends State<ReadarrAuthorAddSearchResultTile> {
  @override
  Widget build(BuildContext context) {
    return LunaBlock(
      backgroundUrl: widget.series.remotePoster,
      posterUrl: widget.series.remotePoster,
      posterHeaders: context.watch<ReadarrState>().headers,
      posterPlaceholderIcon: LunaIcons.BOOK,
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
      TextSpan(text: LunaUI.TEXT_BULLET.lunaPad()),
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
        widget.series.overview ?? 'readarr.NoSummaryAvailable'.tr(),
      );
    } else if (widget.exists) {
      ReadarrAuthorDetailsRouter().navigateTo(
        context,
        widget.series.id ?? -1,
      );
    } else {
      ReadarrAddSeriesDetailsRouter().navigateTo(context, widget.series);
    }
  }

  Future<void>? _onLongPress() async =>
      widget.series.foreignAuthorId?.lunaOpenGoodreadsAuthor();
}
