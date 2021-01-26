import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';
import 'package:tuple/tuple.dart';

class RadarrMovieDetailsFilesPage extends StatefulWidget {
    final RadarrMovie movie;

    RadarrMovieDetailsFilesPage({
        Key key,
        @required this.movie,
    }) : super(key: key);

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<RadarrMovieDetailsFilesPage> with AutomaticKeepAliveClientMixin {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();
    bool _initialLoad = false;
    bool _isError = false;
    
    @override
    bool get wantKeepAlive => true;

    @override
    void initState() {
        super.initState();
        SchedulerBinding.instance.scheduleFrameCallback((_) => _refresh());
    }

    Future<void> _refresh() async {
        if(widget.movie.id > 0) {
            context.read<RadarrState>().resetExtraFiles(widget.movie?.id);
            context.read<RadarrState>().resetMovieFiles(widget.movie?.id);
            setState(() => _initialLoad = true);
            if((widget.movie?.id ?? -1) >= 1) await Future.wait([
                context.read<RadarrState>().extraFiles[widget.movie?.id],
                context.read<RadarrState>().movieFiles[widget.movie?.id],
            ]);
        } else {
            setState(() => _isError = true);
        }
    }

    @override
    Widget build(BuildContext context) {
        super.build(context);
        return Scaffold(
            key: _scaffoldKey,
            body: _isError ? LSErrorMessage(onTapHandler: () async => _refreshKey.currentState.show()) : _initialLoad ? _body : LSLoader(),
        );
    }

    Widget get _body => LSRefreshIndicator(
        refreshKey: _refreshKey,
        onRefresh: _refresh,
        child: Selector<RadarrState, Tuple2<
            Future<List<RadarrMovieFile>>,
            Future<List<RadarrExtraFile>>
        >>(
            selector: (_, state) => Tuple2(
                state.movieFiles[widget.movie.id],
                state.extraFiles[widget.movie.id],
            ),
            builder: (context, tuple, _) => FutureBuilder(
                future: Future.wait([
                    tuple.item1,
                    tuple.item2,
                ]),
                builder: (context, AsyncSnapshot<List<Object>> snapshot) {
                    if(snapshot.hasError) {
                        if(snapshot.connectionState != ConnectionState.waiting) {
                            LunaLogger().error('Unable to fetch Radarr files: ${widget.movie.id}', snapshot.error, StackTrace.current);
                        }
                        return LSErrorMessage(onTapHandler: () async => _refreshKey.currentState.show());
                    }
                    if(snapshot.hasData) return _list(snapshot.data[0], snapshot.data[1]);
                    return LSLoader();
                },
            ),
        ),
    );

    Widget _list(List<RadarrMovieFile> movieFiles, List<RadarrExtraFile> extraFiles) {
        if((movieFiles?.length ?? 0) == 0 && (extraFiles?.length ?? 0) == 0)
            return LSListView(children: [LSGenericMessage(text: 'No Files Found')]);
        return LSListView(
            children: [
                if((movieFiles?.length ?? 0) > 0) ..._filesTiles(movieFiles),
                if((extraFiles?.length ?? 0) > 0) ..._extraFilesTiles(extraFiles),
            ],
        );
    }

    List<Widget> _filesTiles(List<RadarrMovieFile> movieFiles) => List.generate(
        movieFiles.length,
        (index) => RadarrMovieDetailsFilesFileBlock(movieFile: movieFiles[index]),
    );

    List<Widget> _extraFilesTiles(List<RadarrExtraFile> extraFiles) => List.generate(
        extraFiles.length,
        (index) => RadarrMovieDetailsFilesExtraFileBlock(extraFile: extraFiles[index]),
    ).toList();
}
