import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/overseerr.dart';

class OverseerrIssuesListView extends StatefulWidget {
  const OverseerrIssuesListView({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<OverseerrIssuesListView> {
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();
  final PagingController<int, OverseerrIssue> _pagingController =
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
        ?.getIssues(
          take: OverseerrDatabaseValue.CONTENT_PAGE_SIZE.data,
          skip: pageKey * pageSize,
          filter: OverseerrIssueFilterType.ALL.key,
          sort: OverseerrIssueSortType.MOST_RECENT.key,
        )
        .then((data) => _processPage(data, pageKey, pageSize))
        .catchError((error, stack) {
      LunaLogger().error(
        'Unable to fetch Overseerr issues page / take: $pageSize / skip: ${pageKey * pageSize}',
        error,
        stack,
      );
      _pagingController.error = error;
    });
  }

  void _processPage(OverseerrIssuePage page, int key, int size) {
    List<OverseerrIssue> _issues = page.results ?? [];
    if (_issues.length < size) {
      return _pagingController.appendLastPage(_issues);
    }
    return _pagingController.appendPage(_issues, key + 1);
  }

  @override
  Widget build(BuildContext context) {
    return LunaPagedListView<OverseerrIssue>(
      refreshKey: _refreshKey,
      pagingController: _pagingController,
      scrollController: OverseerrNavigationBar.scrollControllers[0],
      listener: _fetchPage,
      noItemsFoundMessage: 'overseerr.NoRequestsFound'.tr(),
      // itemExtent: LunaBlock.calculateItemExtent(3),
      itemBuilder: (context, issue, _) => OverseerrIssueTile(issue: issue),
    );
  }
}
