import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrHistoryRouter extends LunaPageRouter {
    RadarrHistoryRouter() : super('/radarr/history/list');

    @override
    void defineRoute(FluroRouter router) => super.noParameterRouteDefinition(router, _RadarrHistoryRoute());
}


class _RadarrHistoryRoute extends StatefulWidget {
    @override
    State<_RadarrHistoryRoute> createState() => _State();
}

class _State extends State<_RadarrHistoryRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();
    final PagingController<int, RadarrHistoryRecord> _pagingController = PagingController(firstPageKey: 1);

    @override
    void dispose() {
        _pagingController?.dispose();
        super.dispose();
    }

    Future<void> _fetchPage(int pageKey) async {
        await context.read<RadarrState>().api.history.get(
            page: pageKey,
            pageSize: RadarrDatabaseValue.CONTENT_PAGE_SIZE.data,
            sortKey: RadarrHistorySortKey.DATE,
            sortDirection: RadarrSortDirection.DESCENDING,
        )
        .then((data) {
            if(data.totalRecords > (data.page * data.pageSize)) return _pagingController.appendPage(data.records, pageKey+1);
            return _pagingController.appendLastPage(data.records);
        })
        .catchError((error, stack) {
            LunaLogger().error('Unable to fetch Radarr history page $pageKey', error, stack);
            _pagingController.error = error;
        });
    }

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body,
    );

    Widget get _appBar => LunaAppBar(
        title: 'History',
        state: context.read<RadarrState>(),
    );

    Widget get _body => FutureBuilder(
        future: context.read<RadarrState>().movies,
        builder: (context, AsyncSnapshot<List<RadarrMovie>> snapshot) {
            if(snapshot.hasError) {
                if(snapshot.connectionState != ConnectionState.waiting) {
                    LunaLogger().error('Unable to fetch Radarr movies for history list', snapshot.error, StackTrace.current);
                }
                return LSErrorMessage(onTapHandler: () => Future.sync(() => _pagingController.refresh()));
            }
            if(snapshot.hasData) return _paginatedList(snapshot.data);
            return LSLoader();
        },
    );

    Widget _paginatedList(List<RadarrMovie> movies) => LunaPagedListView<RadarrHistoryRecord>(
        refreshKey: _refreshKey,
        pagingController: _pagingController,
        scrollController: context.read<RadarrState>().scrollController,
        listener: _fetchPage,
        itemBuilder: (context, history, index) {
            RadarrMovie _movie = movies.firstWhere((movie) => movie.id == history.movieId, orElse: () => null);
            return RadarrHistoryTile(history: history, title: _movie?.title);
        },
    );
}
