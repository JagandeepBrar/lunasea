import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrMissingTile extends StatefulWidget {
    final RadarrMovie movie;
    final RadarrQualityProfile profile;

    RadarrMissingTile({
        Key key,
        @required this.movie,
        @required this.profile,
    }) : super(key: key);

    @override
    State<RadarrMissingTile> createState() => _State();
}

class _State extends State<RadarrMissingTile> {
    final double _height = 90.0;
    final double _width = 60.0;
    final double _padding = 8.0;

    @override
    Widget build(BuildContext context) => Selector<RadarrState, Future<List<RadarrMovie>>>(
        selector: (_, state) => state.missing,
        builder: (context, missing, _) => LSCard(
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
                TextSpan(text: widget.profile?.name ?? Constants.TEXT_EMDASH),
                TextSpan(text: ' ${Constants.TEXT_BULLET} '),
                TextSpan(text: widget.movie.lunaMinimumAvailability),
                TextSpan(text: ' ${Constants.TEXT_BULLET} '),
                TextSpan(text: widget.movie.lunaReleaseDate),
            ],
        ),
        overflow: TextOverflow.fade,
        softWrap: false,
        maxLines: 1,
    );

    Widget get _subtitleThree {
        String _days = widget.movie.lunaEarlierReleaseDate.lunaDaysDifference;
        return RichText(
            text: TextSpan(
                style: TextStyle(
                    fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                    fontWeight: FontWeight.w600,
                    color: LunaColours.red,
                ),
                children: [
                    TextSpan(
                        text: _days == Constants.TEXT_EMDASH
                            ? 'Released'
                            : _days == 'Today' ? 'Released Today' : 'Released $_days Ago'
                    ),
                ],
            ),
            overflow: TextOverflow.fade,
            softWrap: false,
            maxLines: 1,
        );
    }

    Future<void> _tileOnTap() async => RadarrMoviesDetailsRouter().navigateTo(context, movieId: widget.movie.id);
}
