import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/overseerr.dart';

class OverseerrUserListView extends StatefulWidget {
  const OverseerrUserListView({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<OverseerrUserListView> {
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();
  final PagingController<int, OverseerrUser> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void dispose() {
    _pagingController?.dispose();
    super.dispose();
  }

  Future<void> _fetchPage(int pageKey) async {
    final int pageSize = OverseerrDatabaseValue.CONTENT_PAGE_SIZE.data;
    await context
        .read<OverseerrState>()
        .api!
        .users
        .getUsers(
          take: OverseerrDatabaseValue.CONTENT_PAGE_SIZE.data,
          skip: pageKey * pageSize,
        )
        .then((data) {
      if (data.results!.length < pageSize) {
        return _pagingController.appendLastPage(data.results!);
      }
      return _pagingController.appendPage(data.results!, pageKey + 1);
    }).catchError((error, stack) {
      LunaLogger().error(
        'Unable to fetch Overseerr user page / take: $pageSize / skip: ${pageKey * pageSize}',
        error,
        stack,
      );
      _pagingController.error = error;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LunaPagedListView<OverseerrUser>(
      refreshKey: _refreshKey,
      pagingController: _pagingController,
      scrollController: OverseerrNavigationBar.scrollControllers[1],
      listener: _fetchPage,
      noItemsFoundMessage: 'overseerr.NoUsersFound'.tr(),
      itemBuilder: (context, user, index) => OverseerrUserTile(user: user),
    );
  }
}
