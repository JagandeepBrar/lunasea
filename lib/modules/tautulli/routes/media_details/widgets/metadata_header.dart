import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliMediaDetailsMetadataHeaderTile extends StatelessWidget {
  final TautulliMetadata? metadata;

  const TautulliMediaDetailsMetadataHeaderTile({
    Key? key,
    required this.metadata,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaBlock(
      title: _title,
      body: _body,
      backgroundHeaders: context.watch<TautulliState>().headers,
      backgroundUrl: context.watch<TautulliState>().getImageURLFromPath(
            metadata!.art,
            width: MediaQuery.of(context).size.width.truncate(),
          ),
      bottom: const SizedBox(),
      bottomHeight: _bottomHeight,
      posterUrl:
          context.watch<TautulliState>().getImageURLFromPath(_posterLink),
      posterHeaders: context.watch<TautulliState>().headers,
      posterPlaceholderIcon: LunaIcons.VIDEO_CAM,
    );
  }

  String? get _title =>
      metadata!.grandparentTitle == null || metadata!.grandparentTitle!.isEmpty
          ? metadata!.parentTitle == null || metadata!.parentTitle!.isEmpty
              ? metadata!.title == null || metadata!.title!.isEmpty
                  ? 'Unknown Title'
                  : metadata!.title
              : metadata!.parentTitle
          : metadata!.grandparentTitle;

  String? get _posterLink {
    switch (metadata!.mediaType) {
      case TautulliMediaType.MOVIE:
      case TautulliMediaType.SHOW:
      case TautulliMediaType.SEASON:
      case TautulliMediaType.ARTIST:
      case TautulliMediaType.ALBUM:
      case TautulliMediaType.LIVE:
      case TautulliMediaType.COLLECTION:
        return metadata!.thumb;
      case TautulliMediaType.EPISODE:
        return metadata!.grandparentThumb;
      case TautulliMediaType.TRACK:
        return metadata!.parentThumb;
      case TautulliMediaType.NULL:
      default:
        return '';
    }
  }

  List<TextSpan> get _body {
    switch (metadata!.mediaType) {
      case TautulliMediaType.MOVIE:
      case TautulliMediaType.SHOW:
      case TautulliMediaType.ALBUM:
      case TautulliMediaType.SEASON:
        return [_subtitle1];
      case TautulliMediaType.EPISODE:
      case TautulliMediaType.TRACK:
        return [_subtitle1, _subtitle2];
      case TautulliMediaType.ARTIST:
      case TautulliMediaType.COLLECTION:
      case TautulliMediaType.LIVE:
      case TautulliMediaType.NULL:
      default:
        return [];
    }
  }

  double get _bottomHeight {
    switch (metadata!.mediaType) {
      case TautulliMediaType.MOVIE:
      case TautulliMediaType.SHOW:
      case TautulliMediaType.ALBUM:
      case TautulliMediaType.SEASON:
        return LunaBlock.SUBTITLE_HEIGHT * 2;
      case TautulliMediaType.EPISODE:
      case TautulliMediaType.TRACK:
        return LunaBlock.SUBTITLE_HEIGHT;
      case TautulliMediaType.ARTIST:
      case TautulliMediaType.COLLECTION:
      case TautulliMediaType.LIVE:
      case TautulliMediaType.NULL:
      default:
        return LunaBlock.SUBTITLE_HEIGHT * 3;
    }
  }

  TextSpan get _subtitle1 {
    String? _text = '';
    switch (metadata!.mediaType) {
      case TautulliMediaType.MOVIE:
      case TautulliMediaType.ARTIST:
      case TautulliMediaType.SHOW:
        _text = metadata!.year?.toString() ?? 'lunasea.Unknown'.tr();
        break;
      case TautulliMediaType.ALBUM:
      case TautulliMediaType.SEASON:
      case TautulliMediaType.LIVE:
      case TautulliMediaType.COLLECTION:
        _text = metadata!.title;
        break;
      case TautulliMediaType.EPISODE:
        _text =
            '${metadata!.parentTitle} ${LunaUI.TEXT_BULLET} Episode ${metadata!.mediaIndex}';
        break;
      case TautulliMediaType.TRACK:
        _text =
            '${metadata!.parentTitle} ${LunaUI.TEXT_BULLET} Track ${metadata!.mediaIndex}';
        break;
      case TautulliMediaType.NULL:
      default:
        _text = 'lunasea.Unknown'.tr();
        break;
    }
    return TextSpan(text: _text);
  }

  TextSpan get _subtitle2 {
    String? _text = '';
    switch (metadata!.mediaType) {
      case TautulliMediaType.MOVIE:
      case TautulliMediaType.ARTIST:
      case TautulliMediaType.SHOW:
        _text = metadata!.year?.toString() ?? 'lunasea.Unknown'.tr();
        break;
      case TautulliMediaType.ALBUM:
      case TautulliMediaType.SEASON:
      case TautulliMediaType.LIVE:
      case TautulliMediaType.COLLECTION:
      case TautulliMediaType.EPISODE:
      case TautulliMediaType.TRACK:
        _text = metadata!.title;
        break;
      case TautulliMediaType.NULL:
      default:
        _text = 'lunasea.Unknown'.tr();
        break;
    }
    return TextSpan(text: _text);
  }
}
