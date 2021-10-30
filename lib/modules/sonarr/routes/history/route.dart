import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrHistoryRouter extends SonarrPageRouter {
  SonarrHistoryRouter() : super('/sonarr/history');

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

class _State extends State<_Widget> with LunaScrollControllerMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();
  final PagingController<int, SonarrHistoryRecord> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void dispose() {
    _pagingController?.dispose();
    super.dispose();
  }

  Future<void> _fetchPage(int pageKey) async {
    await context
        .read<SonarrState>()
        .api
        .history
        .get(
          page: pageKey,
          pageSize: SonarrDatabaseValue.CONTENT_PAGE_SIZE.data,
          sortKey: SonarrHistorySortKey.DATE,
          sortDirection: SonarrSortDirection.DESCENDING,
          includeSeries: true,
          includeEpisode: true,
        )
        .then((data) {
      if (data.totalRecords > (data.page * data.pageSize)) {
        return _pagingController.appendPage(data.records, pageKey + 1);
      }
      return _pagingController.appendLastPage(data.records);
    }).catchError((error, stack) {
      LunaLogger().error(
        'Unable to fetch Sonarr history page: $pageKey',
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
      appBar: _appBar(),
      body: _body(),
    );
  }

  Widget _appBar() {
    return LunaAppBar(
      title: 'sonarr.History'.tr(),
      scrollControllers: [scrollController],
    );
  }

  Widget _body() {
    return LunaPagedListView<SonarrHistoryRecord>(
      refreshKey: _refreshKey,
      pagingController: _pagingController,
      scrollController: scrollController,
      listener: _fetchPage,
      noItemsFoundMessage: 'sonarr.NoHistoryFound'.tr(),
      itemBuilder: (context, history, _) => SonarrHistoryTile(
        history: history,
      ),
    );
  }
}
