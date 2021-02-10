import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrMovieDetailsOverviewDescriptionTile extends StatelessWidget {
    final RadarrMovie movie;

    final double _height = 105.0;
    final double _width = 70.0;
    final double _padding = 8.0;

    RadarrMovieDetailsOverviewDescriptionTile({
        Key key,
        @required this.movie,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) => LSCard(
        child: InkWell(
            child: Row(
                children: [
                    LSNetworkImage(
                        url: context.watch<RadarrState>().getPosterURL(movie.id),
                        headers: context.watch<RadarrState>().headers.cast<String, String>(),
                        placeholder: 'assets/images/radarr/nomovieposter.png',
                        height: _height,
                        width: _width,
                    ),
                    Expanded(
                        child: Padding(
                            child: Container(
                                child: Column(
                                    children: [
                                        LunaText.title(text: movie.title, maxLines: 1, darken: !movie.monitored),
                                        Text(
                                            movie.overview == null || movie.overview.isEmpty ? 'No summary is available.\n\n\n' : movie.overview,
                                            maxLines: 4,
                                            overflow: TextOverflow.fade,
                                            style: TextStyle(
                                                color: movie.monitored ? Colors.white70 : Colors.white30,
                                                fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                                            ),
                                        ),
                                    ],
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                ),
                                height: (_height-(_padding*2)),
                            ),
                            padding: EdgeInsets.all(_padding),
                        ),
                    ),
                ],
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
            ),
            borderRadius: BorderRadius.circular(Constants.UI_BORDER_RADIUS),
            onTap: () async => LunaDialogs().textPreview(context, movie.title, movie.overview),
        ),
        decoration: LunaCardDecoration(
            uri: context.watch<RadarrState>().getFanartURL(movie.id),
            headers: context.watch<RadarrState>().headers.cast<String, String>(),
        ),
    );
}
