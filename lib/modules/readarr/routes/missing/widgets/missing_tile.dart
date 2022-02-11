import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/readarr.dart';

class ReadarrMissingTile extends StatefulWidget {
  static final itemExtent = LunaBlock.calculateItemExtent(3);

  final ReadarrBook record;
  final ReadarrAuthor? series;

  const ReadarrMissingTile({
    Key? key,
    required this.record,
    this.series,
  }) : super(key: key);

  @override
  State<ReadarrMissingTile> createState() => _State();
}

class _State extends State<ReadarrMissingTile> {
  @override
  Widget build(BuildContext context) {
    return LunaBlock(
      posterUrl: context
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

  Widget _trailing() {
    return LunaIconButton(
      icon: Icons.search_rounded,
      onPressed: _trailingOnTap,
      onLongPress: _trailingOnLongPress,
    );
  }

  TextSpan _subtitle1() {
    return TextSpan(
      style: const TextStyle(
        fontStyle: FontStyle.italic,
      ),
      text: widget.record.title ?? 'lunasea.Unknown'.tr(),
    );
  }

  TextSpan _subtitle2() {
    return TextSpan(
      style: const TextStyle(
        fontSize: LunaUI.FONT_SIZE_H3,
        color: LunaColours.red,
        fontWeight: LunaUI.FONT_WEIGHT_BOLD,
      ),
      children: [
        TextSpan(
            text: widget.record.releaseDate == null
                ? 'Released'
                : 'Released ${widget.record.releaseDate!.toLocal().lunaAge}'),
      ],
    );
  }

  Future<void> _onTap() async => ReadarrBookDetailsRouter().navigateTo(
        context,
        widget.record.id ?? -1,
      );

  Future<void> _onLongPress() async => ReadarrAuthorDetailsRouter().navigateTo(
        context,
        widget.record.authorId!,
      );

  Future<void> _trailingOnTap() async {
    Provider.of<ReadarrState>(context, listen: false)
        .api!
        .command
        .bookSearch(bookIds: [widget.record.id!])
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
      ReadarrReleasesRouter().navigateTo(
        context,
        bookId: widget.record.id,
      );
}
