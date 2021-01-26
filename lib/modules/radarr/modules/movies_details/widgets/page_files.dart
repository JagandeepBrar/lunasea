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
            setState(() => _initialLoad = true);
            if((widget.movie?.id ?? -1) >= 1) await context.read<RadarrState>().extraFiles[widget.movie?.id];
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
        child: Selector<RadarrState, Future<List<RadarrExtraFile>>>(
            selector: (_, state) => state.extraFiles[widget.movie.id],
            builder: (context, tuple, _) => FutureBuilder(
                future: context.read<RadarrState>().extraFiles[widget.movie.id],
                builder: (context, AsyncSnapshot<List<RadarrExtraFile>> snapshot) {
                    if(snapshot.hasError) {
                        if(snapshot.connectionState != ConnectionState.waiting) {
                            LunaLogger().error('Unable to fetch Radarr extra files: ${widget.movie.id}', snapshot.error, StackTrace.current);
                        }
                        return LSErrorMessage(onTapHandler: () async => _refreshKey.currentState.show());
                    }
                    if(snapshot.hasData) return _list(snapshot.data);
                    return LSLoader();
                },
            ),
        ),
    );

    Widget _list(List<RadarrExtraFile> extraFiles) {
        if(!widget.movie.hasFile && (extraFiles?.length ?? 0) == 0) return LSListView(children: [LSGenericMessage(text: 'No Files Found')]);
        return LSListView(
            children: [
                if((widget.movie.hasFile && widget.movie.movieFile != null)) _filesTile,
                if((extraFiles?.length ?? 0) > 0) ..._extraFilesTiles(extraFiles),
            ],
        );
    }

    Widget get _filesTile => RadarrMovieDetailsFilesFileBlock(movieFile: widget.movie.movieFile);

    List<Widget> _extraFilesTiles(List<RadarrExtraFile> extraFiles) {
        if((extraFiles?.length ?? 0) == 0) return [LSGenericMessage(text: 'No Extra Files Found')];
        return List.generate(
            extraFiles.length,
            (index) => RadarrMovieDetailsFilesExtraFileBlock(extraFile: extraFiles[index]),
        ).toList();
    }
}
