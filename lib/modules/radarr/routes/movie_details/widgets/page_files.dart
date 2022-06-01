import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrMovieDetailsFilesPage extends StatefulWidget {
  const RadarrMovieDetailsFilesPage({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<RadarrMovieDetailsFilesPage>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return LunaScaffold(
      module: LunaModule.RADARR,
      scaffoldKey: _scaffoldKey,
      body: _body(),
    );
  }

  Widget _body() {
    return LunaRefreshIndicator(
      context: context,
      key: _refreshKey,
      onRefresh: () async =>
          context.read<RadarrMovieDetailsState>().fetchFiles(context),
      child: FutureBuilder(
        future: Future.wait([
          context.watch<RadarrMovieDetailsState>().movieFiles,
          context.watch<RadarrMovieDetailsState>().extraFiles,
        ]),
        builder: (context, AsyncSnapshot<List<Object>> snapshot) {
          if (snapshot.hasError) {
            LunaLogger().error(
              'Unable to fetch Radarr files: ${context.read<RadarrMovieDetailsState>().movie.id}',
              snapshot.error,
              snapshot.stackTrace,
            );
            return LunaMessage.error(onTap: _refreshKey.currentState!.show);
          }
          if (snapshot.hasData) {
            return _list(
              movieFiles: snapshot.requireData[0] as List<RadarrMovieFile>,
              extraFiles: snapshot.requireData[1] as List<RadarrExtraFile>,
            );
          }
          return const LunaLoader();
        },
      ),
    );
  }

  Widget _list({
    required List<RadarrMovieFile> movieFiles,
    required List<RadarrExtraFile> extraFiles,
  }) {
    if (movieFiles.isEmpty && extraFiles.isEmpty) {
      return LunaMessage(
        text: 'No Files Found',
        buttonText: 'Refresh',
        onTap: _refreshKey.currentState!.show,
      );
    }
    return LunaListView(
      controller: RadarrMovieDetailsNavigationBar.scrollControllers[1],
      children: [
        if (movieFiles.isNotEmpty) ..._filesTiles(movieFiles),
        if (extraFiles.isNotEmpty) ..._extraFilesTiles(extraFiles),
      ],
    );
  }

  List<Widget> _filesTiles(List<RadarrMovieFile> movieFiles) {
    return List.generate(
      movieFiles.length,
      (idx) => RadarrMovieDetailsFilesFileBlock(file: movieFiles[idx]),
    );
  }

  List<Widget> _extraFilesTiles(List<RadarrExtraFile> extraFiles) {
    return List.generate(
      extraFiles.length,
      (idx) => RadarrMovieDetailsFilesExtraFileBlock(file: extraFiles[idx]),
    );
  }
}
