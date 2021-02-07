import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrMovieTile extends StatefulWidget {
    final RadarrMovie movie;
    final RadarrQualityProfile profile;

    RadarrMovieTile({
        Key key,
        @required this.movie,
        @required this.profile,
    }) : super(key: key);

    @override
    State<RadarrMovieTile> createState() => _State();
}

class _State extends State<RadarrMovieTile> {
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
                onTap: _tileOnTap,
                onLongPress: _tileOnLongPress,
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
                    LunaText.title(text: widget.movie.title, darken: !widget.movie.monitored, maxLines: 1),
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
                TextSpan(
                    text: widget.movie.lunaYear,
                    style: context.read<RadarrState>().moviesSortType == RadarrMoviesSorting.YEAR
                        ? TextStyle(color: LunaColours.accent, fontWeight: FontWeight.w600)
                        : null,
                ),
                TextSpan(text: ' ${Constants.TEXT_BULLET} '),
                TextSpan(
                    text: widget.movie.lunaRuntime,
                    style: context.read<RadarrState>().moviesSortType == RadarrMoviesSorting.RUNTIME
                        ? TextStyle(color: LunaColours.accent, fontWeight: FontWeight.w600)
                        : null,
                ),
                TextSpan(text: ' ${Constants.TEXT_BULLET} '),
                TextSpan(
                    text: widget.movie.lunaStudio,
                    style: context.read<RadarrState>().moviesSortType == RadarrMoviesSorting.STUDIO
                        ? TextStyle(color: LunaColours.accent, fontWeight: FontWeight.w600)
                        : null,
                ),
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
                TextSpan(
                    text: widget.profile?.name ?? Constants.TEXT_EMDASH,
                    style: context.read<RadarrState>().moviesSortType == RadarrMoviesSorting.QUALITY_PROFILE
                        ? TextStyle(color: LunaColours.accent, fontWeight: FontWeight.w600)
                        : null,
                ),
                TextSpan(text: ' ${Constants.TEXT_BULLET} '),
                TextSpan(
                    text: widget.movie.lunaMinimumAvailability,
                    style: context.read<RadarrState>().moviesSortType == RadarrMoviesSorting.MIN_AVAILABILITY
                        ? TextStyle(color: LunaColours.accent, fontWeight: FontWeight.w600)
                        : null,
                ),
                TextSpan(text: ' ${Constants.TEXT_BULLET} '),
                TextSpan(
                    text: widget.movie.lunaDateAdded,
                    style: context.read<RadarrState>().moviesSortType == RadarrMoviesSorting.DATE_ADDED
                        ? TextStyle(color: LunaColours.accent, fontWeight: FontWeight.w600)
                        : null,
                ),
            ],
        ),
        overflow: TextOverflow.fade,
        softWrap: false,
        maxLines: 1,
    );

    Widget get _subtitleThree => Row(
        children: [
            Padding(
                child: Icon(
                    Icons.videocam,
                    size: 16.0,
                    color: widget.movie.lunaIsInCinemas
                        ? widget.movie.monitored ? LunaColours.orange : LunaColours.orange.withOpacity(0.30)
                        : widget.movie.monitored ? Colors.grey : Colors.grey.withOpacity(0.30),
                ),
                padding: EdgeInsets.only(right: 8.0),
            ),
            Padding(
                child: Icon(
                    Icons.album,
                    size: 16.0,
                    color: widget.movie.lunaIsReleased
                        ? widget.movie.monitored ? LunaColours.blue : LunaColours.blue.withOpacity(0.30)
                        : widget.movie.monitored ? Colors.grey : Colors.grey.withOpacity(0.30),
                ),
                padding: EdgeInsets.only(right: 8.0),
            ),
            Padding(
                child: Icon(
                    Icons.check_circle,
                    size: 16.0,
                    color: widget.movie.hasFile
                        ? widget.movie.monitored ? LunaColours.accent : LunaColours.accent.withOpacity(0.30)
                        : widget.movie.monitored ? Colors.grey : Colors.grey.withOpacity(0.30),
                ),
                padding: EdgeInsets.only(right: 8.0),
            ),
            Padding(
                child: widget.movie.hasFile
                    ? widget.movie.lunaHasFileTextObject(widget.movie.monitored)
                    : widget.movie.lunaNextReleaseTextObject(widget.movie.monitored),
                padding: EdgeInsets.only(top: 1.5),
            ),
        ],
    );

    Future<void> _tileOnTap() async => RadarrMoviesDetailsRouter().navigateTo(context, movieId: widget.movie.id);

    Future<void> _tileOnLongPress() async {
        List values = await RadarrDialogs.movieSettings(context, widget.movie);
        if(values[0]) (values[1] as RadarrMovieSettingsType).execute(context, widget.movie);
    }
}
