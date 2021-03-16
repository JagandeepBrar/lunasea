import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:tautulli/tautulli.dart';

class TautulliSearchResultTile extends StatelessWidget {
    final TautulliSearchResult result;
    final TautulliMediaType mediaType;
    final double _imageDimension = 83.0;
    final double _padding = 8.0;

    TautulliSearchResultTile({
        Key key,
        @required this.result,
        @required this.mediaType,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) => LSCard(
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
                uri: context.watch<TautulliState>().getImageURLFromPath(result.art),
                headers: context.watch<TautulliState>().headers,
            )
            : null,
    );

    Widget _poster(BuildContext context) => LSNetworkImage(
        url: context.watch<TautulliState>().getImageURLFromPath(result.thumb),
        headers: context.watch<TautulliState>().headers.cast<String, String>(),
        height: _imageDimension,
        width: _imageDimension/1.5,
        placeholder: 'assets/images/blanks/video.png',
    );

    Widget get _details => Expanded(
        child: Padding(
            child: Container(
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
                height: (_imageDimension-(_padding*2))+1,
            ),
            padding: EdgeInsets.all(_padding),
        ),
    );

    Widget get _title => LSTitle(text: result.title, maxLines: 1);

    Widget get _subtitleOne {
        String _text = '';
        switch(result.mediaType) { 
            case TautulliMediaType.MOVIE:
            case TautulliMediaType.SHOW: _text = result.year?.toString() ?? 'Unknown'; break;
            case TautulliMediaType.ARTIST: break;
            case TautulliMediaType.SEASON:
            case TautulliMediaType.EPISODE:
            case TautulliMediaType.ALBUM:
            case TautulliMediaType.TRACK: _text = result?.parentTitle ?? ''; break;
            case TautulliMediaType.COLLECTION: _text = '${result?.minYear ?? 0} ${Constants.TEXT_EMDASH} ${result?.maxYear ?? 0}'; break;
            default: break;
        }
        return LSSubtitle(text: _text, maxLines: 1);
    }

    Widget get _subtitleTwo => LSSubtitle(text: result.grandparentTitle, maxLines: 1);

    Widget get _library => Text(
        result.libraryName,
        maxLines: 1,
        overflow: TextOverflow.fade,
        softWrap: false,
        style: TextStyle(
            color: LunaColours.accent,
            fontWeight: LunaUI.FONT_WEIGHT_BOLD,
        ),
    );

    Future<void> _onTap(BuildContext context) async => TautulliMediaDetailsRouter.navigateTo(context, ratingKey: result.ratingKey, mediaType: mediaType);
}
