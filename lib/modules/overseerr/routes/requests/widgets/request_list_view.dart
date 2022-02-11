import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/overseerr.dart';

class OverseerrRequestsListView extends StatefulWidget {
  const OverseerrRequestsListView({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<OverseerrRequestsListView> {
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();
  final PagingController<int, OverseerrRequest> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  Future<void> _fetchPage(int pageKey) async {
    final int pageSize = OverseerrDatabaseValue.CONTENT_PAGE_SIZE.data;
    await context
        .read<OverseerrState>()
        .api
        ?.getRequests(
          take: OverseerrDatabaseValue.CONTENT_PAGE_SIZE.data,
          skip: pageKey * pageSize,
        )
        .then((data) => _processPage(data, pageKey, pageSize))
        .catchError((error, stack) {
      LunaLogger().error(
        'Unable to fetch Overseerr requests page / take: $pageSize / skip: ${pageKey * pageSize}',
        error,
        stack,
      );
      _pagingController.error = error;
    });
  }

  void _processPage(OverseerrRequestPage page, int key, int size) {
    List<OverseerrRequest> _requests = page.results ?? [];

    if (_requests.isNotEmpty) {
      _requests.forEach((request) {
        int id = request.media!.tmdbId!;
        switch (request.type!) {
          case OverseerrMediaType.MOVIE:
            context.read<OverseerrState>().fetchMovie(id);
            break;
          case OverseerrMediaType.TV:
            context.read<OverseerrState>().fetchSeries(id);
            break;
        }
      });
    }

    if (_requests.length < size) {
      return _pagingController.appendLastPage(_requests);
    }
    return _pagingController.appendPage(_requests, key + 1);
  }

  @override
  Widget build(BuildContext context) {
    return LunaPagedListView<OverseerrRequest>(
      refreshKey: _refreshKey,
      pagingController: _pagingController,
      scrollController: OverseerrNavigationBar.scrollControllers[0],
      listener: _fetchPage,
      noItemsFoundMessage: 'overseerr.NoRequestsFound'.tr(),
      // itemExtent: LunaBlock.calculateItemExtent(3),
      itemBuilder: (context, request, _) => OverseerrRequestTile(
        request: request,
      ),
    );
  }
}
