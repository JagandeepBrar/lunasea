import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

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
    Future<List<RadarrExtraFile>> _extraFiles;
    Future<List<RadarrMovieFile>> _movieFiles;
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
                _extraFiles = context.read<RadarrState>().api.extraFile.get(movieId: widget.movie.id);
                _movieFiles = context.read<RadarrState>().api.movieFile.get(movieId: widget.movie.id);
            });
            await Future.wait([
                _extraFiles,
                _movieFiles,
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
            body: _isError ? LSErrorMessage(onTapHandler: () async => _refreshKey.currentState.show()) :_body,
        );
    }

    Widget get _body => LSRefreshIndicator(
        refreshKey: _refreshKey,
        onRefresh: _refresh,
        child: FutureBuilder(
            future: _movieFiles == null && _extraFiles == null ? null : Future.wait([
                _movieFiles,
                _extraFiles,
            ]),
            builder: (context, AsyncSnapshot<List<Object>> snapshot) {
                if(snapshot.hasError) {
                    LunaLogger().error('Unable to fetch Radarr files: ${widget.movie.id}', snapshot.error, StackTrace.current);
                    return LSErrorMessage(onTapHandler: () async => _refreshKey.currentState.show());
                }
                if(snapshot.hasData) return _list(snapshot.data[0], snapshot.data[1]);
                return LSLoader();
            },
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
