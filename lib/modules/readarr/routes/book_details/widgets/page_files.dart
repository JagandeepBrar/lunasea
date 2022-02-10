import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/readarr.dart';

class ReadarrBookDetailsFilesPage extends StatefulWidget {
  const ReadarrBookDetailsFilesPage({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<ReadarrBookDetailsFilesPage>
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
      hideDrawer: true,
      scaffoldKey: _scaffoldKey,
      body: _body(),
    );
  }

  Widget _body() {
    return LunaRefreshIndicator(
      context: context,
      key: _refreshKey,
      onRefresh: () async =>
          context.read<ReadarrBookDetailsState>().fetchFiles(context),
      child: FutureBuilder(
        future: Future.wait([
          context.watch<ReadarrBookDetailsState>().movieFiles,
        ]),
        builder: (context, AsyncSnapshot<List<Object>> snapshot) {
          if (snapshot.hasError) {
            LunaLogger().error(
              'Unable to fetch Readarr files: ${context.read<ReadarrBookDetailsState>().book.id}',
              snapshot.error,
              snapshot.stackTrace,
            );
            return LunaMessage.error(onTap: _refreshKey.currentState!.show);
          }
          if (snapshot.hasData) {
            return _list(
              bookFiles: snapshot.requireData[0] as List<ReadarrBookFile>,
            );
          }
          return const LunaLoader();
        },
      ),
    );
  }

  Widget _list({
    required List<ReadarrBookFile> bookFiles,
  }) {
    if (bookFiles.isEmpty) {
      return LunaMessage(
        text: 'No Files Found',
        buttonText: 'Refresh',
        onTap: _refreshKey.currentState!.show,
      );
    }
    return LunaListView(
      controller: ReadarrBookDetailsNavigationBar.scrollControllers[1],
      children: [
        if (bookFiles.isNotEmpty) ..._filesTiles(bookFiles),
      ],
    );
  }

  List<Widget> _filesTiles(List<ReadarrBookFile> movieFiles) {
    return List.generate(
      movieFiles.length,
      (idx) => ReadarrBookDetailsFilesFileBlock(file: movieFiles[idx]),
    );
  }
}
