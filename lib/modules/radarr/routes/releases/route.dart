import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';
import 'package:lunasea/widgets/pages/invalid_route.dart';

class RadarrReleasesRouter extends RadarrPageRouter {
  RadarrReleasesRouter() : super('/radarr/releases/:movieid');

  @override
  Widget widget([
    int movieId = -1,
  ]) {
    return _Widget(movieId: movieId);
  }

  @override
  Future<void> navigateTo(
    BuildContext context, [
    int movieId = -1,
  ]) async {
    LunaRouter.router.navigateTo(context, route(movieId));
  }

  @override
  String route([
    int movieId = -1,
  ]) {
    return fullRoute.replaceFirst(
      ':movieid',
      movieId.toString(),
    );
  }

  @override
  void defineRoute(FluroRouter router) {
    super.withParameterRouteDefinition(
      router,
      (context, params) {
        int movieId = params['movieid'] == null || params['movieid']!.isEmpty
            ? -1
            : (int.tryParse(params['movieid']![0]) ?? -1);
        return _Widget(movieId: movieId);
      },
    );
  }
}

class _Widget extends StatefulWidget {
  final int movieId;

  const _Widget({
    Key? key,
    required this.movieId,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<_Widget> with LunaScrollControllerMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    if (widget.movieId <= 0) {
      return InvalidRoutePage(
        title: 'Releases',
        message: 'Movie Not Found',
      );
    }
    return ChangeNotifierProvider(
      create: (context) => RadarrReleasesState(context, widget.movieId),
      builder: (context, _) => LunaScaffold(
        scaffoldKey: _scaffoldKey,
        appBar: _appBar(context) as PreferredSizeWidget?,
        body: _body(context),
      ),
    );
  }

  Widget _appBar(BuildContext context) {
    return LunaAppBar(
      title: 'Releases',
      scrollControllers: [scrollController],
      bottom: RadarrReleasesSearchBar(scrollController: scrollController),
    );
  }

  Widget _body(BuildContext context) {
    return LunaRefreshIndicator(
      context: context,
      key: _refreshKey,
      onRefresh: () async {
        context.read<RadarrReleasesState>().refreshReleases(context);
        await context.read<RadarrReleasesState>().releases;
      },
      child: FutureBuilder(
        future: context.read<RadarrReleasesState>().releases,
        builder: (context, AsyncSnapshot<List<RadarrRelease>> snapshot) {
          if (snapshot.hasError) {
            if (snapshot.connectionState != ConnectionState.waiting) {
              LunaLogger().error(
                'Unable to fetch Radarr releases: ${widget.movieId}',
                snapshot.error,
                snapshot.stackTrace,
              );
            }
            return LunaMessage.error(
              onTap: () => _refreshKey.currentState!.show,
            );
          }
          if (snapshot.hasData) return _list(context, snapshot.data);
          return const LunaLoader();
        },
      ),
    );
  }

  Widget _list(BuildContext context, List<RadarrRelease>? releases) {
    return Consumer<RadarrReleasesState>(
      builder: (context, state, _) {
        if ((releases?.length ?? 0) == 0) {
          return LunaMessage(
            text: 'No Releases Found',
            buttonText: 'Refresh',
            onTap: _refreshKey.currentState!.show,
          );
        }
        List<RadarrRelease> _processed = _filterAndSortReleases(
          releases ?? [],
          state,
        );
        return LunaListViewBuilder(
          controller: scrollController,
          itemCount: _processed.isEmpty ? 1 : _processed.length,
          itemBuilder: (context, index) {
            if (_processed.isEmpty) {
              return LunaMessage.inList(text: 'No Releases Found');
            }
            return RadarrReleasesTile(release: _processed[index]);
          },
        );
      },
    );
  }

  List<RadarrRelease> _filterAndSortReleases(
    List<RadarrRelease> releases,
    RadarrReleasesState state,
  ) {
    if (releases.isEmpty) return releases;
    List<RadarrRelease> filtered = releases.where(
      (release) {
        String _query = state.searchQuery;
        if (_query.isNotEmpty) {
          return release.title!.toLowerCase().contains(_query.toLowerCase());
        }
        return true;
      },
    ).toList();
    filtered = state.filterType.filter(filtered);
    filtered = state.sortType.sort(filtered, state.sortAscending);
    return filtered;
  }
}
