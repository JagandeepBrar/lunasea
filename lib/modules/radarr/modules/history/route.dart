import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrHistoryRoute extends StatefulWidget {
    @override
    State<RadarrHistoryRoute> createState() => _State();
}

class _State extends State<RadarrHistoryRoute> with AutomaticKeepAliveClientMixin {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();
    final PagingController<int, RadarrHistoryRecord> _pagingController = PagingController(firstPageKey: 1);

    @override
    bool get wantKeepAlive => true;

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
    Widget build(BuildContext context) {
        super.build(context);
        return Scaffold(
            key: _scaffoldKey,
            body: _body,
        );
    }

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
        listener: _fetchPage,
        itemBuilder: (context, history, index) {
            RadarrMovie _movie = movies.firstWhere((movie) => movie.id == history.movieId, orElse: () => null);
            return RadarrHistoryTile(history: history, title: _movie?.title);
        },
    );
}
