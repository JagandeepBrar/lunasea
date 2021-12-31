import 'package:collection/collection.dart' show IterableExtension;
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliLibrariesDetailsInformation extends StatefulWidget {
  final int sectionId;

  const TautulliLibrariesDetailsInformation({
    Key? key,
    required this.sectionId,
  }) : super(key: key);

  @override
  State<TautulliLibrariesDetailsInformation> createState() => _State();
}

class _State extends State<TautulliLibrariesDetailsInformation>
    with AutomaticKeepAliveClientMixin, LunaLoadCallbackMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();
  bool _initialLoad = false;

  @override
  bool get wantKeepAlive => true;

  @override
  Future<void> loadCallback() async {
    context.read<TautulliState>().resetLibrariesTable();
    context.read<TautulliState>().fetchLibraryWatchTimeStats(widget.sectionId);
    setState(() => _initialLoad = true);
    await Future.wait([
      context.read<TautulliState>().librariesTable!,
      context.read<TautulliState>().libraryWatchTimeStats[widget.sectionId]!,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      body: _initialLoad ? _body() : const LunaLoader(),
    );
  }

  Widget _body() {
    return LunaRefreshIndicator(
      context: context,
      key: _refreshKey,
      onRefresh: loadCallback,
      child: FutureBuilder(
        future: Future.wait([
          context.watch<TautulliState>().librariesTable!,
          context
              .watch<TautulliState>()
              .libraryWatchTimeStats[widget.sectionId]!,
        ]),
        builder: (context, AsyncSnapshot<List<Object>> snapshot) {
          if (snapshot.hasError)
            return LunaMessage.error(onTap: _refreshKey.currentState!.show);
          if (snapshot.hasData) {
            TautulliTableLibrary? library =
                (snapshot.data![0] as TautulliLibrariesTable)
                    .libraries!
                    .firstWhereOrNull(
                      (element) => element.sectionId == widget.sectionId,
                    );
            return _list(library,
                snapshot.data![1] as List<TautulliLibraryWatchTimeStats>);
          }
          return const LunaLoader();
        },
      ),
    );
  }

  Widget _list(TautulliTableLibrary? library,
      List<TautulliLibraryWatchTimeStats> watchTimeStats) {
    if (library == null)
      return LunaMessage(
        text: 'Library Not Found',
        buttonText: 'Refresh',
        onTap: _refreshKey.currentState?.show,
      );
    return LunaListView(
      controller: TautulliLibrariesDetailsNavigationBar.scrollControllers[0],
      children: [
        const LunaHeader(text: 'Details'),
        TautulliLibrariesDetailsInformationDetails(library: library),
        const LunaHeader(text: 'Global Stats'),
        TautulliLibrariesDetailsInformationGlobalStats(
            watchtime: watchTimeStats),
      ],
    );
  }
}
