import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/extensions/datetime.dart';
import 'package:lunasea/extensions/string/string.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:lunasea/router/routes/tautulli.dart';

class TautulliRecentlyAddedContentTile extends StatefulWidget {
  final TautulliRecentlyAdded recentlyAdded;

  const TautulliRecentlyAddedContentTile({
    Key? key,
    required this.recentlyAdded,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<TautulliRecentlyAddedContentTile> {
  @override
  Widget build(BuildContext context) {
    return LunaBlock(
      title: _title,
      body: _body,
      posterHeaders: context.watch<TautulliState>().headers,
      posterUrl:
          context.watch<TautulliState>().getImageURLFromPath(_posterLink),
      backgroundHeaders: context.watch<TautulliState>().headers,
      backgroundUrl: context
          .watch<TautulliState>()
          .getImageURLFromPath(widget.recentlyAdded.art),
      posterPlaceholderIcon: LunaIcons.VIDEO_CAM,
      onTap: _onTap,
    );
  }

  String? get _posterLink {
    switch (widget.recentlyAdded.mediaType) {
      case TautulliMediaType.MOVIE:
      case TautulliMediaType.SHOW:
      case TautulliMediaType.SEASON:
      case TautulliMediaType.ARTIST:
      case TautulliMediaType.ALBUM:
      case TautulliMediaType.LIVE:
      case TautulliMediaType.COLLECTION:
        return widget.recentlyAdded.thumb;
      case TautulliMediaType.EPISODE:
      case TautulliMediaType.TRACK:
        return widget.recentlyAdded.grandparentThumb;
      case TautulliMediaType.NULL:
      default:
        return '';
    }
  }

  String? get _title {
    String? title = 'lunasea.Unknown'.tr();
    if (widget.recentlyAdded.title != null &&
        widget.recentlyAdded.title!.isNotEmpty)
      title = widget.recentlyAdded.title;
    if (widget.recentlyAdded.parentTitle != null &&
        widget.recentlyAdded.parentTitle!.isNotEmpty)
      title = widget.recentlyAdded.parentTitle;
    if (widget.recentlyAdded.grandparentTitle != null &&
        widget.recentlyAdded.grandparentTitle!.isNotEmpty)
      title = widget.recentlyAdded.grandparentTitle;
    return title;
  }

  List<TextSpan> get _body {
    return [
      // Television
      if (widget.recentlyAdded.mediaType == TautulliMediaType.EPISODE)
        TextSpan(
          children: [
            TextSpan(text: 'S${widget.recentlyAdded.parentMediaIndex}'),
            TextSpan(text: LunaUI.TEXT_BULLET.pad()),
            TextSpan(text: 'E${widget.recentlyAdded.mediaIndex}: '),
            TextSpan(
              text: widget.recentlyAdded.title,
              style: const TextStyle(
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      if (widget.recentlyAdded.mediaType == TautulliMediaType.SHOW)
        TextSpan(text: widget.recentlyAdded.year.toString()),
      if (widget.recentlyAdded.mediaType == TautulliMediaType.SEASON)
        TextSpan(text: widget.recentlyAdded.fullTitle),
      // Movie
      if (widget.recentlyAdded.mediaType == TautulliMediaType.MOVIE)
        TextSpan(text: widget.recentlyAdded.year.toString()),
      // Music
      if (widget.recentlyAdded.mediaType == TautulliMediaType.ARTIST)
        const TextSpan(text: LunaUI.TEXT_EMDASH),
      if (widget.recentlyAdded.mediaType == TautulliMediaType.ALBUM)
        TextSpan(text: widget.recentlyAdded.title),
      if (widget.recentlyAdded.mediaType == TautulliMediaType.TRACK)
        TextSpan(
          children: [
            TextSpan(text: widget.recentlyAdded.title),
            TextSpan(text: LunaUI.TEXT_BULLET.pad()),
            TextSpan(text: widget.recentlyAdded.parentTitle),
          ],
        ),
      // Other
      if (widget.recentlyAdded.mediaType == TautulliMediaType.LIVE)
        const TextSpan(text: LunaUI.TEXT_EMDASH),
      if (widget.recentlyAdded.mediaType == TautulliMediaType.COLLECTION)
        const TextSpan(text: LunaUI.TEXT_EMDASH),
      TextSpan(text: widget.recentlyAdded.libraryName),
      TextSpan(
        text: widget.recentlyAdded.addedAt?.asAge() ?? 'lunasea.Unknown'.tr(),
      ),
    ];
  }

  void _onTap() {
    TautulliRoutes.MEDIA_DETAILS.go(params: {
      'rating_key': widget.recentlyAdded.ratingKey.toString(),
      'media_type': widget.recentlyAdded.mediaType!.value,
    });
  }
}
