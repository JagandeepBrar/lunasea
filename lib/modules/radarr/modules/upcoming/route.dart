import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrUpcomingRoute extends StatefulWidget {
    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<RadarrUpcomingRoute> with AutomaticKeepAliveClientMixin {
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

    @override
    void initState() {
        super.initState();
        SchedulerBinding.instance.scheduleFrameCallback((_) => _refresh());
    }

    Future<void> _refresh() async {
        RadarrState _state = context.read<RadarrState>();
        _state.resetUpcoming();
        await _state.upcoming;
    }

    Widget get _body => LSRefreshIndicator(
        refreshKey: _refreshKey,
        onRefresh: _refresh,
        child: Selector<RadarrState, Future<List<RadarrMovie>>>(
            selector: (_, state) => state.upcoming,
            builder: (context, upcoming, _) => FutureBuilder(
                future: upcoming,
                builder: (context, AsyncSnapshot<List<RadarrMovie>> snapshot) {
                    if(snapshot.hasError) {
                        if(snapshot.connectionState != ConnectionState.waiting) {
                            LunaLogger().error('Unable to fetch Radarr upcoming', snapshot.error, StackTrace.current);
                        }
                        return LSErrorMessage(onTapHandler: () => _refreshKey.currentState.show());
                    }
                    if(snapshot.hasData) return _upcoming(snapshot.data);
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

    Widget _upcoming(List<RadarrMovie> movies) {
        if(movies.length == 0) return _noUpcomingMovies();
        return LSListView(
            children: List.generate(
                movies.length,
                (index) => RadarrUpcomingTile(
                    movie: movies[index],
                ),
            ),
        );
    }
}
