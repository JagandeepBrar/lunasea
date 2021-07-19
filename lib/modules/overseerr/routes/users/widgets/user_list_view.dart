import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/overseerr.dart';

class OverseerrUserListView extends StatefulWidget {
  final ScrollController scrollController;
  final int pageSize;

  OverseerrUserListView({
    Key key,
    @required this.scrollController,
    this.pageSize = 25,
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
    await context
        .read<OverseerrState>()
        .api
        .users
        .getUsers(
          take: widget.pageSize,
          skip: pageKey * widget.pageSize,
        )
        .then((data) {
      if (data.results.length < widget.pageSize) {
        return _pagingController.appendLastPage(data.results);
      }
      return _pagingController.appendPage(data.results, pageKey + 1);
    }).catchError((error, stack) {
      LunaLogger().error(
        'Unable to fetch Overseerr user page / take: ${widget.pageSize} / skip: ${pageKey * widget.pageSize}',
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
      scrollController: widget.scrollController,
      listener: _fetchPage,
      noItemsFoundMessage: 'overseerr.NoUsersFound'.tr(),
      itemBuilder: (context, user, index) => OverseerrUserTile(user: user),
    );
  }
}
