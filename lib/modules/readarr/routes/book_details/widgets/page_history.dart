import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/readarr.dart';

class ReadarrBookDetailsHistoryPage extends StatefulWidget {
  final ReadarrBook? movie;

  const ReadarrBookDetailsHistoryPage({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<ReadarrBookDetailsHistoryPage>
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
          context.read<ReadarrBookDetailsState>().fetchHistory(context),
      child: FutureBuilder(
        future: context.watch<ReadarrBookDetailsState>().history,
        builder: (context, AsyncSnapshot<List<ReadarrHistoryRecord>> snapshot) {
          if (snapshot.hasError) {
            LunaLogger().error(
                'Unable to fetch Readarr movie history: ${widget.movie!.id}',
                snapshot.error,
                snapshot.stackTrace);
            return LunaMessage.error(onTap: _refreshKey.currentState!.show);
          }
          if (snapshot.hasData) return _list(snapshot.data);
          return const LunaLoader();
        },
      ),
    );
  }

  Widget _list(List<ReadarrHistoryRecord>? history) {
    if ((history?.length ?? 0) == 0)
      return LunaMessage(
        text: 'No History Found',
        buttonText: 'Refresh',
        onTap: _refreshKey.currentState!.show,
      );
    return LunaListViewBuilder(
      controller: ReadarrBookDetailsNavigationBar.scrollControllers[2],
      itemCount: history!.length,
      itemBuilder: (context, index) => ReadarrHistoryTile(
          history: history[index], type: ReadarrHistoryTileType.EPISODE),
    );
  }
}
