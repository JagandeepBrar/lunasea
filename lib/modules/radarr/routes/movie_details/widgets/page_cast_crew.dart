import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrMovieDetailsCastCrewPage extends StatefulWidget {
  final RadarrMovie? movie;

  const RadarrMovieDetailsCastCrewPage({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<RadarrMovieDetailsCastCrewPage>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return LunaScaffold(
      module: LunaModule.RADARR,
      scaffoldKey: _scaffoldKey,
      body: _body(),
    );
  }

  Widget _body() {
    return LunaRefreshIndicator(
      context: context,
      key: _refreshKey,
      onRefresh: () async =>
          context.read<RadarrMovieDetailsState>().fetchCredits(context),
      child: FutureBuilder(
        future: context.watch<RadarrMovieDetailsState>().credits,
        builder: (context, AsyncSnapshot<List<RadarrMovieCredits>> snapshot) {
          if (snapshot.hasError) {
            LunaLogger().error(
                'Unable to fetch Radarr credit/crew list: ${widget.movie!.id}',
                snapshot.error,
                snapshot.stackTrace);
            return LunaMessage.error(onTap: _refreshKey.currentState!.show);
          }
          if (snapshot.hasData) return _list(snapshot.data);
          return const LunaLoader();
        },
      ),
    );
  }

  Widget _list(List<RadarrMovieCredits>? credits) {
    if ((credits?.length ?? 0) == 0)
      return LunaMessage(
        text: 'No Credits Found',
        buttonText: 'Refresh',
        onTap: _refreshKey.currentState!.show,
      );
    List<RadarrMovieCredits> _cast = credits!
        .where((credit) => credit.type == RadarrCreditType.CAST)
        .toList();
    List<RadarrMovieCredits> _crew = credits
        .where((credit) => credit.type == RadarrCreditType.CREW)
        .toList();
    return LunaListView(
      controller: RadarrMovieDetailsNavigationBar.scrollControllers[3],
      children: [
        ...List.generate(_cast.length,
            (index) => RadarrMovieDetailsCastCrewTile(credits: _cast[index])),
        ...List.generate(_crew.length,
            (index) => RadarrMovieDetailsCastCrewTile(credits: _crew[index])),
      ],
    );
  }
}
