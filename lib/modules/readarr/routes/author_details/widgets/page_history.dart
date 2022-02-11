import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/readarr.dart';

class ReadarrAuthorDetailsHistoryPage extends StatefulWidget {
  const ReadarrAuthorDetailsHistoryPage({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<ReadarrAuthorDetailsHistoryPage>
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
      scaffoldKey: _scaffoldKey,
      module: LunaModule.READARR,
      hideDrawer: true,
      body: _body(),
    );
  }

  Widget _body() {
    return LunaRefreshIndicator(
      context: context,
      key: _refreshKey,
      onRefresh: () async =>
          context.read<ReadarrAuthorDetailsState>().fetchHistory(context),
      child: FutureBuilder(
        future: context.select<ReadarrAuthorDetailsState,
            Future<List<ReadarrHistoryRecord>>?>((s) => s.history),
        builder: (context, AsyncSnapshot<List<ReadarrHistoryRecord>> snapshot) {
          if (snapshot.hasError) {
            LunaLogger().error(
              'Unable to fetch Readarr series history: ${context.read<ReadarrAuthorDetailsState>().author.id}',
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

  Widget _list(List<ReadarrHistoryRecord>? history) {
    if ((history?.length ?? 0) == 0)
      return LunaMessage(
        text: 'readarr.NoHistoryFound'.tr(),
        buttonText: 'lunasea.Refresh'.tr(),
        onTap: _refreshKey.currentState!.show,
      );
    return LunaListViewBuilder(
      controller: ReadarrAuthorDetailsNavigationBar.scrollControllers[2],
      itemCount: history!.length,
      itemBuilder: (context, index) => ReadarrHistoryTile(
        history: history[index],
        type: ReadarrHistoryTileType.SERIES,
      ),
    );
  }
}
