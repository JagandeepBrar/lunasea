import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrUpcomingTile extends StatefulWidget {
    final RadarrMovie movie;

    RadarrUpcomingTile({
        Key key,
        @required this.movie,
    }) : super(key: key);

    @override
    State<RadarrUpcomingTile> createState() => _State();
}

class _State extends State<RadarrUpcomingTile> {
    final double _height = 90.0;
    final double _width = 60.0;
    final double _padding = 8.0;

    @override
    Widget build(BuildContext context) => Selector<RadarrState, Future<List<RadarrMovie>>>(
        selector: (_, state) => state.movies,
        builder: (context, movies, _) => LSCard(
            child: InkWell(
                child: Row(
                    children: [
                        _poster,
                        Expanded(child: _information),
                    ],
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                ),
                borderRadius: BorderRadius.circular(Constants.UI_BORDER_RADIUS),
                onTap: () async => _tileOnTap(),
                // onLongPress: () async => // TODO
            ),
            decoration: LunaCardDecoration(
                uri: Provider.of<RadarrState>(context, listen: false).getPosterURL(widget.movie.id),
                headers: Provider.of<RadarrState>(context, listen: false).headers,
            ),
        ),
    );

    Widget get _poster => LSNetworkImage(
        url: Provider.of<RadarrState>(context, listen: false).getPosterURL(widget.movie.id),
        placeholder: 'assets/images/radarr/nomovieposter.png',
        height: _height,
        width: _width,
        headers: Provider.of<RadarrState>(context, listen: false).headers.cast<String, String>(),
    );

    Widget get _information => Padding(
        child: Container(
            child: Column(
                children: [
                    LSTitle(text: widget.movie.title, darken: !widget.movie.monitored, maxLines: 1),
                    _subtitleOne,
                    _subtitleTwo,
                    _subtitleThree,
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
                color: widget.movie.monitored ? Colors.white70 : Colors.white30,
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
                color: widget.movie.monitored ? Colors.white70 : Colors.white30,
            ),
            children: [
                // TODO: Decide what details should be shown on line 3
            ],
        ),
        overflow: TextOverflow.fade,
        softWrap: false,
        maxLines: 1,
    );

    Widget get _subtitleThree {
        Color color = widget.movie.monitored ? Colors.white70 : Colors.white30;
        if(widget.movie.lunaInCinemas && !widget.movie.lunaIsReleased) {
            color = widget.movie.monitored ? LunaColours.blue : LunaColours.blue.withOpacity(0.30);
        }
        if(!widget.movie.lunaInCinemas && !widget.movie.lunaIsReleased) {
            color = widget.movie.monitored ? LunaColours.orange : LunaColours.orange.withOpacity(0.30);
        }
        return RichText(
            text: TextSpan(
                style: TextStyle(
                    fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                    fontWeight: FontWeight.w600,
                    color: color,
                ),
                children: [
                    if(widget.movie.lunaInCinemas && !widget.movie.lunaIsReleased)
                        TextSpan(text: 'Available in ${widget.movie.lunaEarlierReleaseDate.lunaDaysDifference}'),
                    if(!widget.movie.lunaInCinemas && !widget.movie.lunaIsReleased)
                        TextSpan(text: 'In Cinemas in ${widget.movie.inCinemas.lunaDaysDifference}'),
                ],
            ),
            overflow: TextOverflow.fade,
            softWrap: false,
            maxLines: 1,
        );
    }

    Future<void> _tileOnTap() async => RadarrMoviesDetailsRouter().navigateTo(context);
}
