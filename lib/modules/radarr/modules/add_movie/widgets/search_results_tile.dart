import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrAddMovieSearchResultTile extends StatefulWidget {
    final RadarrMovie movie;
    final bool onTapShowOverview;
    final bool exists;
    final bool isExcluded;

    RadarrAddMovieSearchResultTile({
        Key key,
        @required this.movie,
        @required this.exists,
        @required this.isExcluded,
        this.onTapShowOverview = false,
    }) : super(key: key);

    @override
    State<RadarrAddMovieSearchResultTile> createState() => _State();
}

class _State extends State<RadarrAddMovieSearchResultTile> {
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
        decoration: widget.movie.remotePoster == null ? null : LunaCardDecoration(
            uri: widget.movie.remotePoster,
            headers: Provider.of<RadarrState>(context, listen: false).headers,
        ),
    );

    Widget _poster(BuildContext context) {
        if(widget.movie.remotePoster != null) return LSNetworkImage(
            url: widget.movie.remotePoster,
            placeholder: 'assets/images/radarr/nomovieposter.png',
            height: _height,
            width: _width,
            headers: Provider.of<RadarrState>(context, listen: false).headers.cast<String, String>(),
        );
        return ClipRRect(
            child: Image.asset(
                'assets/images/radarr/nomovieposter.png',
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
                    LunaText.title(
                        text: widget.movie.title,
                        color: widget.isExcluded ? LunaColours.red : Colors.white,
                        darken: widget.exists,
                        maxLines: 1,
                    ),
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
                TextSpan(text: widget.movie.lunaYear),
                TextSpan(text: ' ${Constants.TEXT_BULLET} '),
                TextSpan(text: widget.movie.lunaRuntime),
                TextSpan(text: ' ${Constants.TEXT_BULLET} '),
                TextSpan(text: widget.movie.lunaStudio),
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
            text: widget.movie.overview == null || widget.movie.overview.isEmpty ? 'No summary is available.\n' : widget.movie.overview,
        ),
        overflow: TextOverflow.fade,
        softWrap: true,
        maxLines: 2,
    );

    Future<void> _onTap(BuildContext context) async {
        if(widget.onTapShowOverview) {
            LunaDialogs().textPreview(context, widget.movie.title, widget.movie.overview ?? 'No summary is available.');
        } else if(widget.exists) {
            RadarrMoviesDetailsRouter().navigateTo(context, movieId: widget.movie.id ?? -1);
        } else {
            RadarrAddMovieDetailsRouter().navigateTo(context, tmdbId: widget.movie.tmdbId ?? -1);
        }
    }
}
