import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';
import 'package:tuple/tuple.dart';

class RadarrMissingRoute extends StatefulWidget {
    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<RadarrMissingRoute> with AutomaticKeepAliveClientMixin {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();

    @override
    bool get wantKeepAlive => true;

    @override
    Widget build(BuildContext context) {
        super.build(context);
        return Scaffold(
            key: _scaffoldKey,
            body: _body,
        );
    }

    Future<void> _refresh() async {
        RadarrState _state = context.read<RadarrState>();
        _state.fetchMovies();
        _state.fetchQualityProfiles();
        await Future.wait([
            _state.missing,
            _state.qualityProfiles,
        ]);
    }

    Widget get _body => LSRefreshIndicator(
        refreshKey: _refreshKey,
        onRefresh: _refresh,
        child: Selector<RadarrState, Tuple2<
            Future<List<RadarrMovie>>,
            Future<List<RadarrQualityProfile>>
        >>(
            selector: (_, state) => Tuple2(
                state.missing,
                state.qualityProfiles,
            ),
            builder: (context, tuple, _) => FutureBuilder(
                future: Future.wait([
                    tuple.item1,
                    tuple.item2,
                ]),
                builder: (context, AsyncSnapshot<List<Object>> snapshot) {
                    if(snapshot.hasError) {
                        if(snapshot.connectionState != ConnectionState.waiting) {
                            LunaLogger().error('Unable to fetch Radarr upcoming', snapshot.error, StackTrace.current);
                        }
                        return LSErrorMessage(onTapHandler: () => _refreshKey.currentState.show());
                    }
                    if(snapshot.hasData) return _missing(snapshot.data[0], snapshot.data[1]);
                    return LSLoader();
                },
            ),
        ),
    );

    Widget _noUpcomingMovies() => LSGenericMessage(
        text: 'No Movies Found',
        showButton: true,
        buttonText: 'Refresh',
        onTapHandler: () async => _refreshKey.currentState.show(),
    );

    Widget _missing(
        List<RadarrMovie> movies,
        List<RadarrQualityProfile> qualityProfiles,
    ) {
        if(movies.length == 0) return _noUpcomingMovies();
        return LSListView(
            children: List.generate(
                movies.length,
                (index) => RadarrMissingTile(
                    movie: movies[index],
                    profile: qualityProfiles.firstWhere((element) => element.id == movies[index].qualityProfileId, orElse: null),
                ),
            ),
        );
    }
}
