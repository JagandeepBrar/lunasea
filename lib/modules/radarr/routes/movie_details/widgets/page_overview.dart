import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrMovieDetailsOverviewPage extends StatefulWidget {
  final RadarrMovie? movie;
  final RadarrQualityProfile? qualityProfile;
  final List<RadarrTag> tags;

  const RadarrMovieDetailsOverviewPage({
    Key? key,
    required this.movie,
    required this.qualityProfile,
    required this.tags,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<RadarrMovieDetailsOverviewPage>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return LunaScaffold(
      module: LunaModule.RADARR,
      scaffoldKey: _scaffoldKey,
      body: Selector<RadarrState, Future<List<RadarrMovie>>?>(
        selector: (_, state) => state.movies,
        builder: (context, movies, _) => LunaListView(
          controller: RadarrMovieDetailsNavigationBar.scrollControllers[0],
          children: [
            RadarrMovieDetailsOverviewDescriptionTile(movie: widget.movie),
            RadarrMovieDetailsOverviewInformationBlock(
              movie: widget.movie,
              qualityProfile: widget.qualityProfile,
              tags: widget.tags,
            ),
          ],
        ),
      ),
    );
  }
}
