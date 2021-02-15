import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrReleasesRouter extends LunaPageRouter {
    RadarrReleasesRouter() : super('/radarr/releases/:movieid');

    @override
    Future<void> navigateTo(BuildContext context, { @required int movieId }) async => LunaRouter.router.navigateTo(context, route(movieId: movieId));

    @override
    String route({ @required int movieId }) => fullRoute.replaceFirst(':movieid', movieId.toString());

    @override
    void defineRoute(FluroRouter router) => router.define(
        fullRoute,
        handler: Handler(handlerFunc: (context, params) => _RadarrReleasesRoute(movieId: int.tryParse(params['movieid'][0]) ?? -1)),
        transitionType: LunaRouter.transitionType,
    );
}

class _RadarrReleasesRoute extends StatefulWidget {
    final int movieId;

    _RadarrReleasesRoute({
        Key key,
        @required this.movieId,
    }) : super(key: key);

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<_RadarrReleasesRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();
    final ScrollController _scrollController = ScrollController();

    @override
    Widget build(BuildContext context) {
        if(widget.movieId == null || widget.movieId <= 0) return LunaInvalidRoute(title: 'Releases', message: 'Movie Not Found');
        return ChangeNotifierProvider(
            create: (context) => RadarrReleasesState(context, widget.movieId),
            builder: (context, _) => Scaffold(
                key: _scaffoldKey,
                appBar: RadarrReleasesAppBar(scrollController: _scrollController),
                body: _body(context),
            ),
        );
    }

    Widget _body(BuildContext context) {
        return LSRefreshIndicator(
            refreshKey: _refreshKey,
            onRefresh: () async {
                context.read<RadarrReleasesState>().refreshReleases(context);
                await context.read<RadarrReleasesState>().releases;
            },
            child: FutureBuilder(
                future: context.read<RadarrReleasesState>().releases,
                builder: (context, AsyncSnapshot<List<RadarrRelease>> snapshot) {
                    if(snapshot.hasError) {
                        if(snapshot.connectionState != ConnectionState.waiting) LunaLogger().error(
                            'Unable to fetch Radarr releases: ${widget.movieId}',
                            snapshot.error,
                            snapshot.stackTrace,
                        );
                        return LSErrorMessage(onTapHandler: () => _refreshKey.currentState.show());
                    }
                    if(snapshot.hasData) return _list(context, snapshot.data);
                    return LSLoader();
                },
            ),
        );
    }

    Widget _list(BuildContext context, List<RadarrRelease> releases) {
        return Consumer<RadarrReleasesState>(
            builder: (context, state, _) {
                List<RadarrRelease> _processed = _filterAndSortReleases(releases ?? [], state);
                if((_processed?.length ?? 0) == 0) return _noResults(context);
                return LunaListViewBuilder(
                    scrollController: _scrollController,
                    itemCount: _processed.length,
                    itemBuilder: (context, index) => RadarrReleasesTile(release: _processed[index]),
                );
            },
        );
    }

    Widget _noResults(BuildContext context) {
        return LSGenericMessage(
            text: 'No Results Found',
            showButton: true,
            buttonText: 'Refresh',
            onTapHandler: () => _refreshKey.currentState.show(),
        );
    }

    List<RadarrRelease> _filterAndSortReleases(List<RadarrRelease> releases, RadarrReleasesState state) {
        if(releases == null || releases.length == 0) return releases;
        List<RadarrRelease> _filtered = releases.where((release) {
            String _query = state.searchQuery;
            if(_query != null && _query.isNotEmpty) return release.title.toLowerCase().contains(_query.toLowerCase());
            return release != null;
        }).toList();
        _filtered = state.filterType.filter(_filtered);
        state.sortType.sort(_filtered, state.sortAscending);
        return _filtered;
    }
}
