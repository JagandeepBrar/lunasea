import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrMovieDetailsOverviewPage extends StatefulWidget {
    final RadarrMovie movie;
    final RadarrQualityProfile qualityProfile;

    RadarrMovieDetailsOverviewPage({
        Key key,
        @required this.movie,
        @required this.qualityProfile,
    }) : super(key: key);

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<RadarrMovieDetailsOverviewPage> with AutomaticKeepAliveClientMixin {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    bool get wantKeepAlive => true;

    @override
    Widget build(BuildContext context) {
        super.build(context);
        return Scaffold(
            key: _scaffoldKey,
            body: Selector<RadarrState, Future<List<RadarrMovie>>>(
                selector: (_, state) => state.movies,
                builder: (context, movies, _) => LSListView(
                    children: [
                        RadarrMovieDetailsOverviewDescriptionTile(movie: widget.movie),
                        RadarrMovieDetailsOverviewDownloadButtons(movie: widget.movie),
                        RadarrMovieDetailsOverviewInformationBlock(movie: widget.movie, qualityProfile: widget.qualityProfile),
                        RadarrMovieDetailsOverviewLinksSection(movie: widget.movie),
                    ],
                ),
            ),
        );
    }
}
