import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/readarr.dart';

class ReadarrHistoryRouter extends ReadarrPageRouter {
  ReadarrHistoryRouter() : super('/readarr/history');

  @override
  Widget widget() => _Widget();

  @override
  void defineRoute(FluroRouter router) {
    super.noParameterRouteDefinition(router);
  }
}

class _Widget extends StatefulWidget {
  @override
  State<_Widget> createState() => _State();
}

class _State extends State<_Widget>
    with LunaScrollControllerMixin, LunaLoadCallbackMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();
  final PagingController<int, ReadarrHistoryRecord> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  Future<void> loadCallback() async {
    context.read<ReadarrState>().fetchAllAuthors();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  Future<void> _fetchPage(int pageKey) async {
    await context
        .read<ReadarrState>()
        .api!
        .history
        .get(
          page: pageKey,
          pageSize: ReadarrDatabaseValue.CONTENT_PAGE_SIZE.data,
          sortKey: ReadarrHistorySortKey.DATE,
          sortDirection: ReadarrSortDirection.DESCENDING,
          includeBook: true,
        )
        .then((data) {
      if (data.totalRecords! > (data.page! * data.pageSize!)) {
        return _pagingController.appendPage(data.records!, pageKey + 1);
      }
      return _pagingController.appendLastPage(data.records!);
    }).catchError((error, stack) {
      LunaLogger().error(
        'Unable to fetch Readarr history page: $pageKey',
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
      title: 'readarr.History'.tr(),
      scrollControllers: [scrollController],
    );
  }

  Widget _body() {
    return FutureBuilder(
      future: context.read<ReadarrState>().authors,
      builder: (context, AsyncSnapshot<Map<int, ReadarrAuthor>> snapshot) {
        if (snapshot.hasError) {
          if (snapshot.connectionState != ConnectionState.waiting) {
            LunaLogger().error(
              'Unable to fetch Readarr authors',
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

  Widget _list(Map<int, ReadarrAuthor>? series) {
    return LunaPagedListView<ReadarrHistoryRecord>(
      refreshKey: _refreshKey,
      pagingController: _pagingController,
      scrollController: scrollController,
      listener: _fetchPage,
      noItemsFoundMessage: 'readarr.NoHistoryFound'.tr(),
      itemBuilder: (context, history, _) => ReadarrHistoryTile(
        history: history,
        author: series![history.authorId!],
        type: ReadarrHistoryTileType.ALL,
      ),
    );
  }
}
