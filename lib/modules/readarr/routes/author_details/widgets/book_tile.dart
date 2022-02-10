import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/readarr.dart';

class ReadarrAuthorDetailsBookTile extends StatefulWidget {
  final ReadarrBook book;
  final int? authorId;

  const ReadarrAuthorDetailsBookTile({
    Key? key,
    required this.book,
    required this.authorId,
  }) : super(key: key);

  @override
  State<ReadarrAuthorDetailsBookTile> createState() => _State();
}

class _State extends State<ReadarrAuthorDetailsBookTile> {
  LunaLoadingState _loadingState = LunaLoadingState.INACTIVE;

  @override
  Widget build(BuildContext context) {
    return LunaBlock(
      posterPlaceholderIcon: LunaIcons.BOOK,
      posterUrl: context.read<ReadarrState>().getBookCoverURL(widget.book.id),
      posterHeaders: context.read<ReadarrState>().headers,
      //title: widget.book.lunaTitle,
      title: widget.book.title,
      disabled: !widget.book.monitored!,
      body: [
        _subtitle1(),
        _subtitle2(),
        _subtitle3(),
      ],
      trailing: _trailing(),
      onTap: _onTap,
      //onLongPress: _onLongPress,
    );
  }

  Future<void> _onTap() async =>
      ReadarrBookDetailsRouter().navigateTo(context, widget.book.id ?? -1);

/*
  Future<void> _onLongPress() async {
    Tuple2<bool, ReadarrSeasonSettingsType?> result = await ReadarrDialogs()
        .seasonSettings(context, widget.book.seasonNumber);
    if (result.item1)
      result.item2!.execute(
        context,
        widget.authorId,
        widget.book.seasonNumber,
      );
  }*/

  TextSpan _subtitle1() {
    return TextSpan(
      text: widget.book.releaseDate?.lunaDateReadable(shortMonth: false) ??
          LunaUI.TEXT_EMDASH,
      style: const TextStyle(
        color: LunaColours.accent,
        fontWeight: LunaUI.FONT_WEIGHT_BOLD,
      ),
    );
  }

  TextSpan _subtitle2() {
    return TextSpan(
        text: [
      (widget.book.pageCount ?? 0) > 0
          ? widget.book.pageCount
          : LunaUI.TEXT_EMDASH,
      'readarr.Pages'.tr()
    ].join(' '));
  }

  TextSpan _subtitle3() {
    return TextSpan(
      text:
          widget.book.statistics?.sizeOnDisk?.lunaBytesToString(decimals: 1) ??
              LunaUI.TEXT_EMDASH,
    );
  }

  Widget _trailing() {
    Future<void> setLoadingState(LunaLoadingState state) async {
      if (this.mounted) setState(() => _loadingState = state);
    }

    return LunaIconButton(
      icon: widget.book.monitored!
          ? Icons.turned_in_rounded
          : Icons.turned_in_not_rounded,
      color: LunaColours.white,
      loadingState: _loadingState,
      onPressed: () async {
        setLoadingState(LunaLoadingState.ACTIVE);
        await ReadarrAPIController()
            .toggleBookMonitored(
              context: context,
              book: widget.book,
            )
            .whenComplete(() => setLoadingState(LunaLoadingState.INACTIVE));
      },
    );
  }
}
