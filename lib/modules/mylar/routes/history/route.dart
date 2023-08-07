import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/mylar.dart';

class HistoryRoute extends StatefulWidget {
  const HistoryRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<HistoryRoute> createState() => _State();
}

class _State extends State<HistoryRoute>
    with LunaScrollControllerMixin, LunaLoadCallbackMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _refreshKey = GlobalKey<RefreshIndicatorState>();
  final _pagingController =
      PagingController<int, MylarHistoryRecord>(firstPageKey: 1);

  @override
  Future<void> loadCallback() async {
    context.read<MylarState>().fetchAllSeries();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  Future<void> _fetchPage(int pageKey) async {
    await context
        .read<MylarState>()
        .api!
        .history
        .get(
          page: pageKey,
          pageSize: MylarDatabase.CONTENT_PAGE_SIZE.read(),
          sortKey: MylarHistorySortKey.DATE,
          sortDirection: MylarSortDirection.DESCENDING,
          includeEpisode: true,
        )
        .then((data) {
      if (data.totalRecords! > (data.page! * data.pageSize!)) {
        return _pagingController.appendPage(data.records!, pageKey + 1);
      }
      return _pagingController.appendLastPage(data.records!);
    }).catchError((error, stack) {
      LunaLogger().error(
        'Unable to fetch Mylar history page: $pageKey',
        error,
        stack,
      );
      _pagingController.error = error;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      appBar: _appBar() as PreferredSizeWidget?,
      body: _body(),
    );
  }

  Widget _appBar() {
    return LunaAppBar(
      title: 'mylar.History'.tr(),
      scrollControllers: [scrollController],
    );
  }

  Widget _body() {
    return FutureBuilder(
      future: context.read<MylarState>().series,
      builder: (context, AsyncSnapshot<Map<int, MylarSeries>> snapshot) {
        if (snapshot.hasError) {
          if (snapshot.connectionState != ConnectionState.waiting) {
            LunaLogger().error(
              'Unable to fetch Mylar series',
              snapshot.error,
              snapshot.stackTrace,
            );
          }
          return LunaMessage.error(onTap: _refreshKey.currentState!.show);
        }
        if (snapshot.hasData) return _list(snapshot.data);
        return const LunaLoader();
      },
    );
  }

  Widget _list(Map<int, MylarSeries>? series) {
    return LunaPagedListView<MylarHistoryRecord>(
      refreshKey: _refreshKey,
      pagingController: _pagingController,
      scrollController: scrollController,
      listener: _fetchPage,
      noItemsFoundMessage: 'mylar.NoHistoryFound'.tr(),
      itemBuilder: (context, history, _) => MylarHistoryTile(
        history: history,
        series: series![history.seriesId!],
        type: MylarHistoryTileType.ALL,
      ),
    );
  }
}
