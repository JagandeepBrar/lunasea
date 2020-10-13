import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeriesAddSearchResultTile extends StatefulWidget {
    final SonarrSeriesLookup series;
    final bool onTapShowOverview;
    final bool exists;

    SonarrSeriesAddSearchResultTile({
        Key key,
        @required this.series,
        @required this.exists,
        this.onTapShowOverview = false,
    }) : super(key: key);

    @override
    State<SonarrSeriesAddSearchResultTile> createState() => _State();
}

class _State extends State<SonarrSeriesAddSearchResultTile> {
    final double _height = 90.0;
    final double _width = 60.0;
    final double _padding = 8.0;

    @override
    Widget build(BuildContext context) => LSCard(
        child: InkWell(
            child: Row(
                children: [
                    _poster(context),
                    Expanded(child: _information),
                ],
            ),
            onTap: () async => _onTap(context),
            borderRadius: BorderRadius.circular(Constants.UI_BORDER_RADIUS),
        ),
        decoration: widget.series.lunaBannerURL == null ? null : LSCardBackground(
            uri: widget.series.lunaBannerURL,
            headers: Provider.of<SonarrState>(context, listen: false).headers,
        ),
    );

    Widget _poster(BuildContext context) {
        if(widget.series.remotePoster != null) return LSNetworkImage(
            url: widget.series.remotePoster,
            placeholder: 'assets/images/sonarr/noseriesposter.png',
            height: _height,
            width: _width,
            headers: Provider.of<SonarrState>(context, listen: false).headers.cast<String, String>(),
        );
        return ClipRRect(
            child: Image.asset(
                'assets/images/sonarr/noseriesposter.png',
                width: _width,
                height: _height,
            ),
            borderRadius: BorderRadius.circular(Constants.UI_BORDER_RADIUS),
        );
    }

    Widget get _information => Padding(
        child: Container(
            child: Column(
                children: [
                    LSTitle(text: widget.series.title, darken: widget.exists, maxLines: 1),
                    _subtitleOne,
                    _subtitleTwo,
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
            ),
            height: (_height-(_padding*2)),
        ),
        padding: EdgeInsets.all(_padding),
    );

    Widget get _subtitleOne => RichText(
        text: TextSpan(
            style: TextStyle(
                fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                color: widget.exists ? Colors.white30 : Colors.white70,
            ),
            children: [
                TextSpan(text: widget.series.seasonCount == 1 ? '1 Season' : '${widget.series.seasonCount} Seasons'),
                TextSpan(text: ' ${Constants.TEXT_BULLET} '),
                TextSpan(text: (widget.series.year ?? 0) == 0 ? 'Unknown Year' : widget.series.year.toString()),
                TextSpan(text: ' ${Constants.TEXT_BULLET} '),
                TextSpan(text: widget.series.network ?? 'Unknown Network'),
            ],
        ),
        overflow: TextOverflow.fade,
        softWrap: false,
        maxLines: 1,
    );

    Widget get _subtitleTwo => RichText(
        text: TextSpan(
            style: TextStyle(
                fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                fontStyle: FontStyle.italic,
                color: widget.exists ? Colors.white30 : Colors.white70,
            ),
            text: '${widget.series.overview ?? 'No summary is available.'}\n',
        ),
        overflow: TextOverflow.fade,
        softWrap: true,
        maxLines: 2,
    );

    Future<void> _onTap(BuildContext context) async {
        if(widget.onTapShowOverview) {
            LunaDialogs.textPreview(context, widget.series.title, widget.series.overview ?? 'No summary is available.');
        } else if(widget.exists) {
            Provider.of<SonarrState>(context, listen: false).enableVersion3
                ? SonarrSeriesDetailsRouter.navigateTo(context, seriesId: widget.series.id ?? -1)
                : LSSnackBar(
                    context: context,
                    title: 'Series Already Exists',
                    message: 'This series already exists in Sonarr',
                    type: SNACKBAR_TYPE.info,
                );
        } else {
            SonarrSeriesAddDetailsRouter.navigateTo(context, tvdbId: widget.series.tvdbId ?? -1);
        }
    }
}
