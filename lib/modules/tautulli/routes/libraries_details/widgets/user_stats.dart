import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliLibrariesDetailsUserStats extends StatefulWidget {
  final int sectionId;

  const TautulliLibrariesDetailsUserStats({
    Key? key,
    required this.sectionId,
  }) : super(key: key);

  @override
  State<TautulliLibrariesDetailsUserStats> createState() => _State();
}

class _State extends State<TautulliLibrariesDetailsUserStats>
    with AutomaticKeepAliveClientMixin, LunaLoadCallbackMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  bool get wantKeepAlive => true;

  @override
  Future<void> loadCallback() async {
    context.read<TautulliState>().fetchLibraryUserStats(widget.sectionId);
    await context.read<TautulliState>().libraryUserStats[widget.sectionId];
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      body: _body(),
    );
  }

  Widget _body() {
    return LunaRefreshIndicator(
      context: context,
      key: _refreshKey,
      onRefresh: loadCallback,
      child: FutureBuilder(
        future:
            context.watch<TautulliState>().libraryUserStats[widget.sectionId],
        builder:
            (context, AsyncSnapshot<List<TautulliLibraryUserStats>> snapshot) {
          if (snapshot.hasError) {
            if (snapshot.connectionState != ConnectionState.waiting)
              LunaLogger().error(
                'Failed to fetch library watch stats',
                snapshot.error,
                snapshot.stackTrace,
              );
            return LunaMessage.error(onTap: _refreshKey.currentState!.show);
          }
          if (snapshot.hasData) return _list(snapshot.data);
          return const LunaLoader();
        },
      ),
    );
  }

  Widget _list(List<TautulliLibraryUserStats>? stats) {
    if ((stats?.length ?? 0) == 0)
      return LunaMessage(
        text: 'No Users Found',
        buttonText: 'Refresh',
        onTap: _refreshKey.currentState?.show,
      );
    return LunaListViewBuilder(
      controller: TautulliLibrariesDetailsNavigationBar.scrollControllers[1],
      itemCount: stats!.length,
      itemBuilder: (context, index) =>
          TautulliLibrariesDetailsUserStatsTile(user: stats[index]),
    );
  }
}
