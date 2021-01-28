import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrMovieDetailsCastCrewPage extends StatefulWidget {
    final RadarrMovie movie;

    RadarrMovieDetailsCastCrewPage({
        Key key,
        @required this.movie,
    }) : super(key: key);

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<RadarrMovieDetailsCastCrewPage> with AutomaticKeepAliveClientMixin {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();
    Future<List<RadarrMovieCredits>> _credits;
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
                _credits = context.read<RadarrState>().api.credits.get(movieId: widget.movie.id);
            });
            await _credits;
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
            future: _credits,
            builder: (context, AsyncSnapshot<List<RadarrMovieCredits>> snapshot) {
                if(snapshot.hasError) {
                    LunaLogger().error('Unable to fetch Radarr credit/crew list: ${widget.movie.id}', snapshot.error, StackTrace.current);
                    return LSErrorMessage(onTapHandler: () async => _refreshKey.currentState.show());
                }
                if(snapshot.hasData) return _list(snapshot.data);
                return LSLoader();
            },
        ),
    );

    Widget _list(List<RadarrMovieCredits> credits) {
        if((credits?.length ?? 0) == 0) return LSGenericMessage(text: 'No Credits Found');
        List<RadarrMovieCredits> _cast = credits.where((credit) => credit.type == RadarrCreditType.CAST).toList();
        List<RadarrMovieCredits> _crew = credits.where((credit) => credit.type == RadarrCreditType.CREW).toList();
        return LSListView(
            children: [
                ...List.generate(_cast.length, (index) => RadarrMovieDetailsCastCrewTile(credits: _cast[index])),
                ...List.generate(_crew.length, (index) => RadarrMovieDetailsCastCrewTile(credits: _crew[index])),
            ],
        );
    }
}
