import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/readarr.dart';

class ReadarrUpcomingTile extends StatefulWidget {
  final ReadarrBook record;
  final ReadarrAuthor? series;

  const ReadarrUpcomingTile({
    Key? key,
    required this.record,
    this.series,
  }) : super(key: key);

  @override
  State<ReadarrUpcomingTile> createState() => _State();
}

class _State extends State<ReadarrUpcomingTile> {
  @override
  Widget build(BuildContext context) {
    return LunaBlock(
      posterUrl: context.read<ReadarrState>().getBookCoverURL(widget.record.id),
      backgroundUrl: context
          .read<ReadarrState>()
          .getAuthorPosterURL(widget.record.authorId),
      posterHeaders: context.read<ReadarrState>().headers,
      posterPlaceholderIcon: LunaIcons.BOOK,
      title: widget.record.series?.title ??
          widget.series?.title ??
          LunaUI.TEXT_EMDASH,
      body: [
        _subtitle1(),
        _subtitle2(),
      ],
      disabled: !widget.record.monitored!,
      onTap: _onTap,
      onLongPress: _onLongPress,
      trailing: _trailing(),
    );
  }

  Widget _trailing() => LunaIconButton(
        icon: Icons.search_rounded,
        onPressed: _trailingOnPressed,
        onLongPress: _trailingOnLongPress,
      );

  TextSpan _subtitle1() {
    return TextSpan(
      style: const TextStyle(fontStyle: FontStyle.italic),
      children: [
        TextSpan(text: widget.record.title ?? 'Unknown Title'),
      ],
    );
  }

  TextSpan _subtitle2() {
    return TextSpan(
        text: [
      (widget.record.pageCount ?? 0) > 0
          ? widget.record.pageCount
          : LunaUI.TEXT_EMDASH,
      'readarr.Pages'.tr()
    ].join(' '));
  }

/*
TO FIX - need to fetch book files
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
          TextSpan(text: widget.record.lunaHasAired ? 'Missing' : 'Unreleased'),
        if (widget.record.hasFile!)
          TextSpan(
            text:
                'Downloaded (${widget.record.episodeFile?.quality?.quality?.name ?? 'Unknown'})',
          ),
      ],
    );
  }*/

  Future<void> _onTap() async => ReadarrBookDetailsRouter().navigateTo(
        context,
        widget.record.id ?? -1,
      );

  Future<void> _onLongPress() async => ReadarrAuthorDetailsRouter().navigateTo(
        context,
        widget.record.authorId!,
      );

  Future<void> _trailingOnPressed() async {
    Provider.of<ReadarrState>(context, listen: false)
        .api!
        .command
        .bookSearch(bookIds: [widget.record.id!])
        .then((_) => showLunaSuccessSnackBar(
              title: 'Searching for Book...',
              message: widget.record.title,
            ))
        .catchError((error, stack) {
          LunaLogger().error(
              'Failed to search for book: ${widget.record.id}', error, stack);
          showLunaErrorSnackBar(
            title: 'Failed to Search',
            error: error,
          );
        });
  }

  Future<void> _trailingOnLongPress() async =>
      ReadarrReleasesRouter().navigateTo(
        context,
        bookId: widget.record.id,
      );
}
