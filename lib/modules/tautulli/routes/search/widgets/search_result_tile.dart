import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliSearchResultTile extends StatelessWidget {
  final TautulliSearchResult result;
  final TautulliMediaType mediaType;
  final double _imageDimension = 84.0;
  final double _padding = 8.0;

  const TautulliSearchResultTile({
    Key key,
    @required this.result,
    @required this.mediaType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaCard(
      context: context,
      child: InkWell(
        child: Row(
          children: [
            _poster(context),
            _details,
          ],
        ),
        onTap: () async => _onTap(context),
      ),
      decoration: result.art != null && result.art.isNotEmpty
          ? LunaCardDecoration(
              uri: context
                  .watch<TautulliState>()
                  .getImageURLFromPath(result.art),
              headers: context.watch<TautulliState>().headers,
            )
          : null,
    );
  }

  Widget _poster(BuildContext context) => LunaNetworkImage(
        context: context,
        url: context.watch<TautulliState>().getImageURLFromPath(result.thumb),
        headers: context.watch<TautulliState>().headers.cast<String, String>(),
        height: _imageDimension,
        width: _imageDimension / 1.5,
        placeholderIcon: LunaIcons.VIDEO_CAM,
      );

  Widget get _details => Expanded(
        child: Padding(
          child: SizedBox(
            child: Column(
              children: [
                _title,
                _subtitleOne,
                _subtitleTwo,
                _library,
                // _date,
                // _userInfo,
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
            ),
            height: (_imageDimension - (_padding * 2)) + 1,
          ),
          padding: EdgeInsets.all(_padding),
        ),
      );

  Widget get _title => LunaText.title(text: result.title, maxLines: 1);

  Widget get _subtitleOne {
    String _text = '';
    switch (result.mediaType) {
      case TautulliMediaType.MOVIE:
      case TautulliMediaType.SHOW:
        _text = result.year?.toString() ?? 'Unknown';
        break;
      case TautulliMediaType.ARTIST:
        break;
      case TautulliMediaType.SEASON:
      case TautulliMediaType.EPISODE:
      case TautulliMediaType.ALBUM:
      case TautulliMediaType.TRACK:
        _text = result?.parentTitle ?? '';
        break;
      case TautulliMediaType.COLLECTION:
        _text =
            '${result?.minYear ?? 0} ${LunaUI.TEXT_EMDASH} ${result?.maxYear ?? 0}';
        break;
      default:
        break;
    }
    return LunaText.subtitle(text: _text, maxLines: 1);
  }

  Widget get _subtitleTwo =>
      LunaText.subtitle(text: result.grandparentTitle, maxLines: 1);

  Widget get _library => Text(
        result.libraryName,
        maxLines: 1,
        overflow: TextOverflow.fade,
        softWrap: false,
        style: const TextStyle(
          color: LunaColours.accent,
          fontWeight: LunaUI.FONT_WEIGHT_BOLD,
        ),
      );

  Future<void> _onTap(BuildContext context) async =>
      TautulliMediaDetailsRouter().navigateTo(
        context,
        ratingKey: result.ratingKey,
        mediaType: mediaType,
      );
}
