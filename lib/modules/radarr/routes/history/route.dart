import 'package:collection/collection.dart' show IterableExtension;
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class HistoryRoute extends StatefulWidget {
  const HistoryRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<HistoryRoute> createState() => _State();
}

class _State extends State<HistoryRoute> with LunaScrollControllerMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();
  final PagingController<int, RadarrHistoryRecord> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  Future<void> _fetchPage(int pageKey) async {
    await context
        .read<RadarrState>()
        .api!
        .history
        .get(
          page: pageKey,
          pageSize: RadarrDatabase.CONTENT_PAGE_SIZE.read(),
          sortKey: RadarrHistorySortKey.DATE,
          sortDirection: RadarrSortDirection.DESCENDING,
        )
        .then((data) {
      if (data.totalRecords! > (data.page! * data.pageSize!)) {
        return _pagingController.appendPage(data.records!, pageKey + 1);
      }
      return _pagingController.appendLastPage(data.records!);
    }).catchError((error, stack) {
      LunaLogger().error(
        'Unable to fetch Radarr history page: $pageKey',
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
      title: 'radarr.History'.tr(),
      scrollControllers: [scrollController],
    );
  }

  Widget _body() {
    return FutureBuilder(
      future: context.watch<RadarrState>().movies,
      builder: (context, AsyncSnapshot<List<RadarrMovie>> snapshot) {
        if (snapshot.hasError) {
          if (snapshot.connectionState != ConnectionState.waiting) {
            LunaLogger().error(
              'Unable to fetch Radarr movies for history list',
              snapshot.error,
              snapshot.stackTrace,
            );
          }
          return LunaMessage.error(
            onTap: () => Future.sync(_pagingController.refresh),
          );
        }
        if (snapshot.hasData) return _paginatedList(snapshot.data);
        return const LunaLoader();
      },
    );
  }

  Widget _paginatedList(List<RadarrMovie>? movies) {
    return LunaPagedListView<RadarrHistoryRecord>(
      refreshKey: _refreshKey,
      pagingController: _pagingController,
      scrollController: scrollController,
      listener: _fetchPage,
      noItemsFoundMessage: 'radarr.NoHistoryFound'.tr(),
      itemBuilder: (context, history, index) {
        RadarrMovie? _movie = movies!.firstWhereOrNull(
          (movie) => movie.id == history.movieId,
        );
        return RadarrHistoryTile(
          history: history,
          title: _movie!.title!,
        );
      },
    );
  }
}
