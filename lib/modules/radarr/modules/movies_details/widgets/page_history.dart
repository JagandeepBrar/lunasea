import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrMovieDetailsHistoryPage extends StatefulWidget {
    final RadarrMovie movie;

    RadarrMovieDetailsHistoryPage({
        Key key,
        @required this.movie,
    }) : super(key: key);

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<RadarrMovieDetailsHistoryPage> with AutomaticKeepAliveClientMixin {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();
    Future<List<RadarrHistoryRecord>> _history;
    bool _isError = false;
    
    @override
    bool get wantKeepAlive => true;

    @override
    void initState() {
        super.initState();
        SchedulerBinding.instance.scheduleFrameCallback((_) => _refresh());
    }

    Future<void> _refresh() async {
        if((widget.movie?.id ?? -1) > 0) {
            setState(() {
                _history = context.read<RadarrState>().api.history.getForMovie(movieId: widget.movie.id);
            });
            await _history;
        } else {
            setState(() => _isError = true);
        }
    }

    @override
    Widget build(BuildContext context) {
        super.build(context);
        return Scaffold(
            key: _scaffoldKey,
            body: _isError ? LSErrorMessage(onTapHandler: () async => _refreshKey.currentState.show()) : _body,
        );
    }

    Widget get _body => LSRefreshIndicator(
        refreshKey: _refreshKey,
        onRefresh: _refresh,
        child: FutureBuilder(
            future: _history,
            builder: (context, AsyncSnapshot<List<RadarrHistoryRecord>> snapshot) {
                if(snapshot.hasError) {
                    LunaLogger().error('Unable to fetch Radarr movie history: ${widget.movie.id}', snapshot.error, StackTrace.current);
                    return LSErrorMessage(onTapHandler: () async => _refreshKey.currentState.show());
                }
                if(snapshot.hasData) return _list(snapshot.data);
                return LSLoader();
            },
        ),
    );

    Widget _list(List<RadarrHistoryRecord> history) {
        if((history?.length ?? 0) == 0)
            return LSListView(children: [LSGenericMessage(text: 'No History Found')]);
        return LSListView(
            children: List.generate(
                history.length,
                (index) => RadarrMovieDetailsHistoryTile(history: history[index]),
            ),
        );
    }
}
