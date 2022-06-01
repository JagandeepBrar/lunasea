import 'package:collection/collection.dart' show IterableExtension;
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrMissingRoute extends StatefulWidget {
  const RadarrMissingRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<RadarrMissingRoute>
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
      scaffoldKey: _scaffoldKey,
      body: _body,
    );
  }

  Future<void> _refresh() async {
    RadarrState _state = context.read<RadarrState>();
    _state.fetchMovies();
    _state.fetchQualityProfiles();
    await Future.wait([
      _state.missing!,
      _state.qualityProfiles!,
    ]);
  }

  Widget get _body => LunaRefreshIndicator(
        context: context,
        key: _refreshKey,
        onRefresh: _refresh,
        child: FutureBuilder(
          future: Future.wait([
            context.watch<RadarrState>().missing!,
            context.watch<RadarrState>().qualityProfiles!,
          ]),
          builder: (context, AsyncSnapshot<List<Object>> snapshot) {
            if (snapshot.hasError) {
              if (snapshot.connectionState != ConnectionState.waiting)
                LunaLogger().error(
                  'Unable to fetch Radarr upcoming',
                  snapshot.error,
                  snapshot.stackTrace,
                );
              return LunaMessage.error(onTap: _refreshKey.currentState!.show);
            }
            if (snapshot.hasData)
              return _list(snapshot.data![0] as List<RadarrMovie>,
                  snapshot.data![1] as List<RadarrQualityProfile>);
            return const LunaLoader();
          },
        ),
      );

  Widget _list(
    List<RadarrMovie> movies,
    List<RadarrQualityProfile> qualityProfiles,
  ) {
    if (movies.isEmpty) {
      return LunaMessage(
        text: 'radarr.NoMoviesFound'.tr(),
        buttonText: 'lunasea.Refresh'.tr(),
        onTap: _refreshKey.currentState!.show,
      );
    }
    return LunaListViewBuilder(
      controller: RadarrNavigationBar.scrollControllers[2],
      itemCount: movies.length,
      itemExtent: RadarrMissingTile.itemExtent,
      itemBuilder: (context, index) => RadarrMissingTile(
        movie: movies[index],
        profile: qualityProfiles.firstWhereOrNull(
            (element) => element.id == movies[index].qualityProfileId),
      ),
    );
  }
}
