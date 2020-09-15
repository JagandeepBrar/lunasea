import 'package:flutter/material.dart';
import 'package:tautulli/tautulli.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliMediaDetailsMetadataHeaderTile extends StatelessWidget {
    final TautulliMetadata metadata;
    final double _height = 105.0;
    final double _width = 70.0;
    final double _padding = 8.0;

    TautulliMediaDetailsMetadataHeaderTile({
        Key key,
        @required this.metadata,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) => LSCard(
        child: InkWell(
            child: _body(context),
            onTap: () async => GlobalDialogs.textPreview(
                context,
                _title,
                metadata.summary.trim().isEmpty ? 'No Summary Available.' : metadata.summary.trim(),
            ),
            borderRadius: BorderRadius.circular(Constants.UI_BORDER_RADIUS),
        ),
        decoration: metadata.art != null && metadata.art.isNotEmpty
            ? LSCardBackground(
                uri: Provider.of<TautulliState>(context, listen: false).getImageURLFromPath(
                    metadata.art,
                    width: MediaQuery.of(context).size.width.truncate(),
                ),
                headers: Provider.of<TautulliState>(context, listen: false).headers,
                darken: true,
            )
            : null,
    );

    Widget _body(BuildContext context) => Row(
        children: [
            _poster(context),
            Expanded(child: _mediaInfo),
        ],
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
    );

    String get _posterLink {
        switch(metadata.mediaType) {
            case TautulliMediaType.MOVIE:
            case TautulliMediaType.SHOW:
            case TautulliMediaType.SEASON:
            case TautulliMediaType.ARTIST:
            case TautulliMediaType.ALBUM:
            case TautulliMediaType.LIVE:
            case TautulliMediaType.COLLECTION: return metadata.thumb;
            case TautulliMediaType.EPISODE:
            case TautulliMediaType.TRACK: return metadata.grandparentThumb;
            case TautulliMediaType.NULL:
            default: return '';
        }
    }

    Widget _poster(BuildContext context) {
        return LSNetworkImage(
            url: Provider.of<TautulliState>(context, listen: false).getImageURLFromPath(_posterLink),
            placeholder: 'assets/images/sonarr/noseriesposter.png',
            height: _height,
            width: _width,
            headers: Provider.of<TautulliState>(context, listen: false).headers.cast<String, String>(),
        );
    }

    Widget get _mediaInfo => Padding(
        child: Container(
            child: Column(
                children: [
                    LSTitle(text: _title, maxLines: 1),
                    _subtitle,
                    _summary,
                ],
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
            ),
            height: (_height-(_padding*2)),
        ),
        padding: EdgeInsets.all(_padding),
    );

    String get _title => metadata.grandparentTitle == null || metadata.grandparentTitle.isEmpty
        ? metadata.parentTitle == null || metadata.parentTitle.isEmpty
        ? metadata.title == null || metadata.title.isEmpty
        ? 'Unknown Title'
        : metadata.title
        : metadata.parentTitle
        : metadata.grandparentTitle;

    Widget get _subtitle {
        String _text = '';
        switch(metadata.mediaType) {   
            case TautulliMediaType.MOVIE:
            case TautulliMediaType.ARTIST:
            case TautulliMediaType.SHOW: _text = metadata.year?.toString() ?? 'Unknown'; break;
            case TautulliMediaType.ALBUM:
            case TautulliMediaType.SEASON:
            case TautulliMediaType.LIVE:
            case TautulliMediaType.COLLECTION: _text = metadata.title; break;
            case TautulliMediaType.EPISODE: _text = '${metadata.parentTitle} ${Constants.TEXT_BULLET} Episode ${metadata.mediaIndex}\n${metadata.title}'; break;
            case TautulliMediaType.TRACK: _text = '${metadata.parentTitle} ${Constants.TEXT_BULLET} Track ${metadata.mediaIndex}\n${metadata.title}'; break;
            case TautulliMediaType.NULL:
            default: _text = 'Unknown'; break;
        }
        return Padding(
            child: RichText(
                text: TextSpan(
                    style: TextStyle(
                        color: Colors.white70,
                        fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                    ),
                    text: _text,
                ),
                softWrap: false,
                maxLines: 2,
                overflow: TextOverflow.fade,
            ),
            padding: EdgeInsets.only(top: 3.0),
        );
    }

    Widget get _summary => Padding(
        child: RichText(
            text: TextSpan(
                style: TextStyle(
                    color: Colors.white70,
                    fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                ),
                text: metadata.summary.trim().isEmpty ? 'No Summary Available.' : metadata.summary.trim(),
            ),
            softWrap: true,
            maxLines: metadata.mediaType == TautulliMediaType.EPISODE || metadata.mediaType == TautulliMediaType.TRACK ? 2 : 3,
            overflow: TextOverflow.fade,
        ),
        padding: EdgeInsets.only(top: 3.0),
    );
}
