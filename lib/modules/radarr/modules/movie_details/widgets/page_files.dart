import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrMovieDetailsFilesPage extends StatefulWidget {
    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<RadarrMovieDetailsFilesPage> with AutomaticKeepAliveClientMixin {
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

    Widget get _body => LunaRefreshIndicator(
        context: context,
        key: _refreshKey,
        onRefresh: () async => context.read<RadarrMovieDetailsState>().fetchFiles(context),
        child: FutureBuilder(
            future: Future.wait([
                context.watch<RadarrMovieDetailsState>().movieFiles,
                context.watch<RadarrMovieDetailsState>().extraFiles,
            ]),
            builder: (context, AsyncSnapshot<List<Object>> snapshot) {
                if(snapshot.hasError) {
                    LunaLogger().error('Unable to fetch Radarr files: ${context.read<RadarrMovieDetailsState>().movie.id}', snapshot.error, snapshot.stackTrace);
                    return LunaMessage.error(onTap: _refreshKey.currentState.show);
                }
                if(snapshot.hasData) return _list(snapshot.data[0], snapshot.data[1]);
                return LunaLoader();
            },
        ),
    );

    Widget _list(List<RadarrMovieFile> movieFiles, List<RadarrExtraFile> extraFiles) {
        if((movieFiles?.length ?? 0) == 0 && (extraFiles?.length ?? 0) == 0)
            return LunaMessage(text: 'No Files Found', buttonText: 'Refresh', onTap: _refreshKey.currentState.show);
        return LunaListView(
            scrollController: RadarrMovieDetailsNavigationBar.scrollControllers[1],
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
