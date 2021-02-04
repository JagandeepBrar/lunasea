import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';
import 'package:tuple/tuple.dart';

class RadarrHistoryRoute extends StatefulWidget {
    @override
    State<RadarrHistoryRoute> createState() => _State();
}

class _State extends State<RadarrHistoryRoute> with AutomaticKeepAliveClientMixin {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();
    
    @override
    bool get wantKeepAlive => true;

    @override
    void initState() {
        super.initState();
        SchedulerBinding.instance.scheduleFrameCallback((_) => _refresh());
    }

    Future<void> _refresh() async {
        RadarrState _state = Provider.of<RadarrState>(context, listen: false);
        _state.resetHistory();
        await _state.history;
    }

    @override
    Widget build(BuildContext context) {
        super.build(context);
        return Scaffold(
            key: _scaffoldKey,
            body: _body,
        );
    }

    Widget get _body => LSRefreshIndicator(
        refreshKey: _refreshKey,
        onRefresh: _refresh,
        child: Selector<RadarrState, Tuple2<
            Future<RadarrHistory>,
            Future<List<RadarrMovie>>
        >>(
            selector: (_, state) => Tuple2(state.history, state.movies),
            builder: (context, future, _) => FutureBuilder(
                future: Future.wait([
                    future.item1,
                    future.item2,
                ]),
                builder: (context, AsyncSnapshot<List<Object>> snapshot) {
                    if(snapshot.hasError) {
                        if(snapshot.connectionState != ConnectionState.waiting) {
                            LunaLogger().error('Unable to fetch Radarr history', snapshot.error, StackTrace.current);
                        }
                        return LSErrorMessage(onTapHandler: () async => _refreshKey.currentState.show());
                    }
                    if(snapshot.hasData) {
                        return (snapshot.data[0] as RadarrHistory).records.length == 0
                            ? _noHistory()
                            : _history(snapshot.data[0], snapshot.data[1]);
                    }
                    return LSLoader();
                },
            ),
        ),
    );

    Widget _noHistory() => LSGenericMessage(
        text: 'No History Found',
        showButton: true,
        buttonText: 'Refresh',
        onTapHandler: () async => _refreshKey.currentState.show(),
    );

    Widget _history(RadarrHistory history, List<RadarrMovie> movies) => LSListView(
        children: List.generate(
            history.records.length,
            (index) {
                RadarrMovie _movie = movies.firstWhere((movie) => movie.id == history.records[index].movieId, orElse: () => null);
                return RadarrHistoryTile(history: history.records[index], title: _movie?.title);
            }
        ),
    );
}